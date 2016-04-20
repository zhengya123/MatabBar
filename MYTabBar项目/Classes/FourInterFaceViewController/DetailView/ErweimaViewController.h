//
//  ErweimaViewController.h
//  MYTabBar项目
//
//  Created by dqong on 16/4/11.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ErweimaViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end
