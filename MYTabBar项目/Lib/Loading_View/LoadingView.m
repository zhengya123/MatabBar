//
//  LoadingView.m
//  CCheartDoctor
//
//  Created by GUXI on 15/11/22.
//  Copyright © 2015年 CCheart. All rights reserved.
//

#import "LoadingView.h"
//#import "UIView+Extension.h"

@interface LoadingView()

@property (nonatomic, weak)UIImageView *loadingImage;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *loadingImage = [[UIImageView alloc] init];
        loadingImage.image = [UIImage imageNamed:@"loading"];
        self.loadingImage = loadingImage;
        [self addSubview:loadingImage];
        
    }
    return self;
}
-(void)createRotating{

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.byValue = @(M_PI * 2);
    anim.duration = 1;
    anim.repeatCount = CGFLOAT_MAX;
    [self.loadingImage.layer addAnimation:anim forKey:nil];

}
-(void)remoRotating{

    [self.loadingImage.layer removeAllAnimations];
    self.loadingImage.hidden = YES;

}

//开始动画
- (void)startRotating {
    [self createRotating];
    self.loadingImage.hidden = NO;
}


- (void)stopRotating {
    [self.layer removeAnimationForKey:@"rotating"];
    [self remoRotating];
}

//设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat loadingX = (self.frame.size.width - 50) * 0.5;
    CGFloat loadingY = (self.frame.size.height - 50) * 0.5;
    self.loadingImage.frame = CGRectMake(loadingX, loadingY, 50, 50);
}


@end




