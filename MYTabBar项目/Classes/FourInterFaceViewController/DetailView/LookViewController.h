//
//  LookViewController.h
//  MYTabBar项目
//
//  Created by dqong on 16/4/11.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface LookViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStadus;
@property (weak, nonatomic) IBOutlet UIButton *kaishis;


-(BOOL)startReading;
-(void)stopReading;

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end
