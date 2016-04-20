//
//  COSTouchVisualizerWindow.m
//  TaXin
//
//  Created by Cyzing on 16/2/14.
//  Copyright © 2016年 Cyzing. All rights reserved.
//

#import "COSTouchVisualizerWindow.h"

// Turn this on to debug touches during development.

#ifdef TARGET_IPHONE_SIMULATOR
#define DEBUG_FINGERTIP_WINDOW 1
#else
#define DEBUG_FINGERTIP_WINDOW 1
#endif

@interface COSTouchSpotView : UIImageView

@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) BOOL shouldAutomaticallyRemoveAfterTimeout;
@property (nonatomic, assign, getter=isFadingOut) BOOL fadingOut;

@end

#pragma mark -

@interface COSTouchVisualizerWindow ()

@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) BOOL fingerTipRemovalScheduled;
@property (nonatomic, strong) NSTimer* timer;

- (void)COSTouchVisualizerWindow_commonInit;
- (BOOL)anyScreenIsMirrored;
- (void)updateFingertipsAreActive;
- (void)scheduleFingerTipRemoval;
- (void)cancelScheduledFingerTipRemoval;
- (void)removeInactiveFingerTips;
- (void)removeFingerTipWithHash:(NSUInteger)hash animated:(BOOL)animated;
- (BOOL)shouldAutomaticallyRemoveFingerTipForTouch:(UITouch *)touch;

@end

#pragma mark -

@implementation COSTouchVisualizerWindow


@synthesize touchImage = _touchImage;
@synthesize touchAlpha = _touchAlpha;
@synthesize fadeDuration = _fadeDuration;

@synthesize rippleImage = _rippleImage;
@synthesize rippleAlpha = _rippleAlpha;
@synthesize rippleFadeDuration = _rippleFadeDuration;

@synthesize overlayWindow = _overlayWindow;
@synthesize active = _active;
@synthesize fingerTipRemovalScheduled = _fingerTipRemovalScheduled;

- (id)initWithCoder:(NSCoder *)decoder {
  // This covers NIB-loaded windows.
  self = [super initWithCoder:decoder];
  if (self != nil) [self COSTouchVisualizerWindow_commonInit];
  return self;
}

- (id)initWithFrame:(CGRect)rect {
  // This covers programmatically-created windows.
  self = [super initWithFrame:rect];
  if (self != nil) [self COSTouchVisualizerWindow_commonInit];
  return self;
}

- (void)COSTouchVisualizerWindow_commonInit {
  self.strokeColor = [UIColor blackColor];
  self.fillColor = [UIColor whiteColor];
  
  self.rippleStrokeColor = [UIColor whiteColor];
  self.rippleFillColor = [UIColor blueColor];
  
  self.overlayWindow = [[UIWindow alloc] initWithFrame:self.frame];
  self.overlayWindow.rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  self.overlayWindow.userInteractionEnabled = NO;
  self.overlayWindow.windowLevel = UIWindowLevelStatusBar;
  self.overlayWindow.backgroundColor = [UIColor clearColor];
  self.overlayWindow.hidden = NO;
  
  self.touchAlpha   = 0.5;
  self.fadeDuration = 0.3;
  
  self.rippleAlpha = 0.2;
  self.rippleFadeDuration = 0.2;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(screenConnect:)
                                               name:UIScreenDidConnectNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(screenDisconnect:)
                                               name:UIScreenDidDisconnectNotification
                                             object:nil];
  
  // Set up active now, in case the screen was present before the window was created (or application launched).
  [self updateFingertipsAreActive];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidConnectNotification    object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
}
#pragma mark -

- (UIImage *)touchImage {
  if (!_touchImage) {
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20.0, 20.0)];
    
    UIGraphicsBeginImageContextWithOptions(clipPath.bounds.size, NO, 0);
    
    UIBezierPath *drawPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10.0, 10.0)
                                                            radius:10.0
                                                        startAngle:0
                                                          endAngle:2 * M_PI
                                                         clockwise:YES];

    drawPath.lineWidth = 2.0;
    
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    
    [drawPath stroke];
    [drawPath fill];
    
    [clipPath addClip];
    
    _touchImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return _touchImage;
}

- (UIImage *)rippleImage {
  UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50.0, 50.0)];
  
  UIGraphicsBeginImageContextWithOptions(clipPath.bounds.size, NO, 0);
  
  UIBezierPath *drawPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(25.0, 25.0)
                                                          radius:22.0
                                                      startAngle:0
                                                        endAngle:2 * M_PI
                                                       clockwise:YES];
  
  drawPath.lineWidth = 2.0;
  
  [self.rippleStrokeColor setStroke];
  [self.rippleFillColor setFill];
  
  [drawPath stroke];
  [drawPath fill];
  
  [clipPath addClip];
  
  _rippleImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return _rippleImage;
}

#pragma mark -
#pragma mark Screen notifications

- (void)screenConnect:(NSNotification *)notification {
  [self updateFingertipsAreActive];
}

- (void)screenDisconnect:(NSNotification *)notification {
  [self updateFingertipsAreActive];
}

- (BOOL)anyScreenIsMirrored {
  if (![UIScreen instancesRespondToSelector:@selector(mirroredScreen)]) return NO;
  
  for (UIScreen *screen in [UIScreen screens]) {
    if ([screen mirroredScreen] != nil) return YES;
  }
  return NO;
}

- (void)updateFingertipsAreActive; {
#if DEBUG_FINGERTIP_WINDOW
  self.active = YES;
#else
  self.active = [self anyScreenIsMirrored];
#endif
}

#pragma mark -
#pragma mark UIWindow overrides

- (void)sendEvent:(UIEvent *)event {
  if (self.active) {
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in [allTouches allObjects]) {
      switch (touch.phase) {
        case UITouchPhaseBegan:
        case UITouchPhaseMoved:
        {
          // Generate ripples
          COSTouchSpotView *rippleView = (COSTouchSpotView *)[self.overlayWindow.rootViewController.view viewWithTag:touch.hash];
          
          rippleView = [[COSTouchSpotView alloc] initWithImage:self.rippleImage];
          [self.overlayWindow.rootViewController.view addSubview:rippleView];
          
          rippleView.alpha = self.rippleAlpha;
          rippleView.center = [touch locationInView:self.overlayWindow.rootViewController.view];
          
          [UIView animateWithDuration:self.rippleFadeDuration
                                delay:0.0
                              options:UIViewAnimationOptionCurveEaseIn // See other options
                           animations:^{
                             [rippleView setAlpha:0.0];
                             [rippleView setFrame:CGRectInset(rippleView.frame, 25, 25)];
                           }
                           completion:^(BOOL finished) {
                             [rippleView removeFromSuperview];
                           }];
        }
        case UITouchPhaseStationary:
        {
          COSTouchSpotView *touchView = (COSTouchSpotView *)[self.overlayWindow.rootViewController.view viewWithTag:touch.hash];
          
          if (touch.phase != UITouchPhaseStationary && touchView != nil && [touchView isFadingOut]) {
            [self.timer invalidate];
            [touchView removeFromSuperview];
            touchView = nil;
          }
          
          if (touchView == nil && touch.phase != UITouchPhaseStationary) {
            touchView = [[COSTouchSpotView alloc] initWithImage:self.touchImage];
            [self.overlayWindow.rootViewController.view addSubview:touchView];

            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(performMorph:) userInfo:touchView repeats:YES];
          }
          
          if (![touchView isFadingOut]) {
            touchView.alpha = self.touchAlpha;
            touchView.center = [touch locationInView:self.overlayWindow.rootViewController.view];
            touchView.tag = touch.hash;
            touchView.timestamp = touch.timestamp;
            touchView.shouldAutomaticallyRemoveAfterTimeout = [self shouldAutomaticallyRemoveFingerTipForTouch:touch];
          }
          break;
        }
          
        case UITouchPhaseEnded:
        case UITouchPhaseCancelled:
        {
          [self removeFingerTipWithHash:touch.hash animated:YES];
          break;
        }
      }
    }
  }
  
  [super sendEvent:event];
  
  [self scheduleFingerTipRemoval]; // We may not see all UITouchPhaseEnded/UITouchPhaseCancelled events.
}

#pragma mark -
#pragma mark Private

- (void)scheduleFingerTipRemoval {
  if (self.fingerTipRemovalScheduled) return;
  self.fingerTipRemovalScheduled = YES;
  [self performSelector:@selector(removeInactiveFingerTips) withObject:nil afterDelay:0.1];
}

- (void)cancelScheduledFingerTipRemoval {
  self.fingerTipRemovalScheduled = YES;
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeInactiveFingerTips) object:nil];
}

- (void)removeInactiveFingerTips {
  self.fingerTipRemovalScheduled = NO;
  
  NSTimeInterval now = [[NSProcessInfo processInfo] systemUptime];
  const CGFloat REMOVAL_DELAY = 0.2;
  
  for (COSTouchSpotView *touchView in [self.overlayWindow.rootViewController.view subviews]) {
    if (![touchView isKindOfClass:[COSTouchSpotView class]]) continue;
    
    if (touchView.shouldAutomaticallyRemoveAfterTimeout && now > touchView.timestamp + REMOVAL_DELAY)
      [self removeFingerTipWithHash:touchView.tag animated:YES];
  }
  
  if ([[self.overlayWindow.rootViewController.view subviews] count])
    [self scheduleFingerTipRemoval];
}

- (void)removeFingerTipWithHash:(NSUInteger)hash animated:(BOOL)animated {
  COSTouchSpotView *touchView = (COSTouchSpotView *)[self.overlayWindow.rootViewController.view viewWithTag:hash];
  if (touchView == nil)
    return;
  
  if ([touchView isFadingOut]) return;
  
  BOOL animationsWereEnabled = [UIView areAnimationsEnabled];
  
  if (animated) {
    [UIView setAnimationsEnabled:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:self.fadeDuration];
  }
  
  touchView.frame = CGRectMake(touchView.center.x - touchView.frame.size.width,
                               touchView.center.y - touchView.frame.size.height,
                               touchView.frame.size.width  * 2,
                               touchView.frame.size.height * 2);
  
  touchView.alpha = 0.0;
  
  if (animated) {
    [UIView commitAnimations];
    [UIView setAnimationsEnabled:animationsWereEnabled];
  }
  
  touchView.fadingOut = YES;
  [touchView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:self.fadeDuration];
}

- (BOOL)shouldAutomaticallyRemoveFingerTipForTouch:(UITouch *)touch;
{
  // We don't reliably get UITouchPhaseEnded or UITouchPhaseCancelled
  // events via -sendEvent: for certain touch events. Known cases
  // include swipe-to-delete on a table view row, and tap-to-cancel
  // swipe to delete. We automatically remove their associated
  // fingertips after a suitable timeout.
  //
  // It would be much nicer if we could remove all touch events after
  // a suitable time out, but then we'll prematurely remove touch and
  // hold events that are picked up by gesture recognizers (since we
  // don't use UITouchPhaseStationary touches for those. *sigh*). So we
  // end up with this more complicated setup.
  
  UIView *view = [touch view];
  view = [view hitTest:[touch locationInView:view] withEvent:nil];
  
  while (view != nil) {
    if ([view isKindOfClass:[UITableViewCell class]]) {
      for (UIGestureRecognizer *recognizer in [touch gestureRecognizers]) {
        if ([recognizer isKindOfClass:[UISwipeGestureRecognizer class]]) return YES;
      }
    }
    
    if ([view isKindOfClass:[UITableView class]]) {
      if ([[touch gestureRecognizers] count] == 0) return YES;
    }
    
    view = view.superview;
  }
  
  return NO;
}

- (void)performMorph:(NSTimer*)theTimer {
  UIView *view = (UIView*)[theTimer userInfo];
  NSTimeInterval duration = .4;
  NSTimeInterval delay = 0;
  // Start
  view.alpha = _touchAlpha;
  view.transform = CGAffineTransformMakeScale(1, 1);
  [UIView animateWithDuration:duration/4 delay:delay options:0 animations:^{
    // End
    view.transform = CGAffineTransformMakeScale(1, 1.2);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:duration/4 delay:0 options:0 animations:^{
      // End
      view.transform = CGAffineTransformMakeScale(1.2, 0.9);
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:duration/4 delay:0 options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeScale(0.9, 0.9);
      } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/4 delay:0 options:0 animations:^{
          // End
          view.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
          
        }];
      }];
    }];
  }];
}

@end

#pragma mark -

@implementation COSTouchSpotView

@end