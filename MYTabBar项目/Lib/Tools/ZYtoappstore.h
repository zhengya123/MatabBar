//
//  ZYtoappstore.h
//  MYTabBar项目
//
//  Created by dqong on 16/5/5.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface ZYtoappstore : NSObject
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    
    UIAlertView *alertViewTest;
    
#else
    
    UIAlertController *alertController;
    
#endif
    
}

@property (nonatomic,strong) NSString * myAppID;//appID



- (void)showGotoAppStore:(UIViewController *)VC;

@end
