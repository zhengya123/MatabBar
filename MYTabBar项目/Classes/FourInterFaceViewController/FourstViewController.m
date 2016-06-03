//
//  FourstViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/29.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "FourstViewController.h"
#import "NewsViewController.h"
#import "ErweimaViewController.h"
#import "LookViewController.h"
#import "FourInterFaceViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "ZYtoappstore.h"
#import "AddressListViewController.h"
#import "BanbenViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#include <SystemConfiguration/CaptiveNetwork.h>
#import "GradeViewController.h"
@interface FourstViewController ()

@end

@implementation FourstViewController
{

    UIImageView * _imageView;


}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    //self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    //[super.navigationController setNavigationBarHidden:YES];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
//    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    _imageView.image=[UIImage imageNamed:@"fengmian.png"];
    //[self.view addSubview:_imageView];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];//此组可以不跳转界面进行其他动作
    
    /**
     *  获取当前WIFI信息
     */
    NSArray * ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for(NSString * ifnam in ifs){
    
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@  => %@",ifnam,info);
        
        if (info && [info count]) {
            break;
        }
    
    
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setupGroup1{
    WMSettingGroup *group       = [self addGroup];
    WMSettingLabelItem *qq      = [WMSettingLabelItem
                                   itemWithIcon:@"personal_btn_qq"
                                   title:@"五星评级"
                                   destVcClass:NSClassFromString(@"GradeViewController")];

    WMSettingLabelItem *weiChat = [WMSettingLabelItem
                                   itemWithIcon:@"photo_icon_wechat"
                                   title:@"娱乐杂志"
                                   destVcClass:NSClassFromString(@"NewsViewController")];

    WMSettingLabelItem *quwei   = [WMSettingLabelItem
                                   itemWithIcon:@"photo_icon_wechat"
                                   title:@"趣味笑话"
                                   destVcClass:NSClassFromString(@"NewsViewController")];
    WMSettingLabelItem *weibo   = [WMSettingLabelItem
                                   itemWithIcon:@"photo_icon_weibo"
                                   title:@"访问通讯录"
                                   destVcClass:NSClassFromString(@"AddressListViewController")];
    
    qq.readyForDestVc = ^(WMSettingLabelItem *item, GradeViewController *descVC) {
       // descVC.sourceItem = item;
        
    };
    weiChat.readyForDestVc = ^(WMSettingLabelItem *item, NewsViewController *descVC) {
       // descVC.sourceItem = item;
    };
    quwei.readyForDestVc = ^(WMSettingLabelItem *item, NewsViewController *descVC) {
        //descVC.sourceItem = item;
    };
    weibo.readyForDestVc = ^(WMSettingLabelItem *item, AddressListViewController *descVC) {
        //descVC.sourceItem = item;
    };
    group.items = @[qq, weiChat,quwei, weibo];
}
-(void)setupGroup2{
    WMSettingGroup *group       = [self addGroup];

    WMSettingLabelItem *qq      = [WMSettingLabelItem
                                  itemWithIcon:@"personal_btn_qq"
                                  title:@"我的二维码"
                                  destVcClass:NSClassFromString(@"ErweimaViewController")];

    WMSettingLabelItem *weiChat = [WMSettingLabelItem
                                   itemWithIcon:@"photo_icon_wechat"
                                   title:@"扫一扫"
                                   destVcClass:NSClassFromString(@"LookViewController")];

    WMSettingLabelItem *quwei   = [WMSettingLabelItem
                                  itemWithIcon:@"photo_icon_wechat"
                                  title:@"旧版本入口"
                                  destVcClass:NSClassFromString(@"FourInterFaceViewController")];

    qq.readyForDestVc           = ^(WMSettingLabelItem *item, ErweimaViewController *descVC) {
        // descVC.sourceItem = item;
    };
    weiChat.readyForDestVc      = ^(WMSettingLabelItem *item, LookViewController *descVC) {
        // descVC.sourceItem = item;
    };
    quwei.readyForDestVc        = ^(WMSettingLabelItem *item, FourInterFaceViewController *descVC) {
        //descVC.sourceItem = item;
    };

    group.items                 = @[qq, weiChat,quwei];
}
-(void)setupGroup3{
    WMSettingGroup *group     = [self addGroup];
    /**
     * 点击了执行跳转操作
     */
    WMSettingLabelItem *qq    = [WMSettingLabelItem
                              itemWithIcon:@"qq2"
                              title:@"版本信息"
                              destVcClass:NSClassFromString(@"BanbenViewController")];
    
    qq.readyForDestVc           = ^(WMSettingLabelItem *item, BanbenViewController *descVC) {
        descVC.titleName = @"版本信息";
    };

    
    /**
     *  appstore评论功能
     */
    WMSettingItem * items     = [WMSettingItem itemWithIcon:@"photo_icon_wechat" title:@"评论"];

    items.operation           = ^(WMSettingItem * item){

        NSLog(@"点击了评论");

        
        [self evaluateAuthenticate];//指纹验证
       // [self authentication];//密码验证 (不支持)


    };
    /**
     *  点击了不跳转，直接进行操作
     */
    WMSettingItem * item = [WMSettingItem itemWithIcon:@"photo_icon_wechat" title:@"退出登录"];
    
    item.operation = ^(WMSettingItem * item){
    
        NSLog(@"点击了退出登录");
        //将密码置为空
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"mimao"];
        LoginViewController * login = [[LoginViewController alloc]init];
        AppDelegate * appdelegate = [[UIApplication sharedApplication] delegate];
        RootNavigationController * nav = [[RootNavigationController alloc]initWithRootViewController:login];
        appdelegate.window.rootViewController = nav;
        
    
    };
    /**
     *  点击退出APP
     */
    WMSettingItem * back = [WMSettingItem itemWithIcon:@"photo_icon_wechat" title:@"退出APP"];
    back.operation = ^(WMSettingItem * item){
        NSLog(@"点击了退出APP");
        [[UIApplication sharedApplication]performSelector:@selector(suspend)];
        
    };
    group.items = @[qq, items,item,back];
    
}

/**
 * 指纹验证
 */
- (void)evaluateAuthenticate
{
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    
    
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                    ZYtoappstore * toappStore = [[ZYtoappstore alloc]init];
                    toappStore.myAppID        = @"1055238193";
                
                    [toappStore showGotoAppStore:self];
                NSLog(@"验证成功，主线程处理UI");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        
                        NSLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                       
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            NSLog(@"用户选择输入密码，切换主线程处理");
                           // [self  authentication];
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}


/**
 *  密码验证
 */

- (void)authentication
{
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    
    
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    BOOL can = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    
    NSLog(@"BOOL == %d",can);
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                ZYtoappstore * toappStore = [[ZYtoappstore alloc]init];
                toappStore.myAppID        = @"1055238193";
                
                [toappStore showGotoAppStore:self];
                NSLog(@"验证成功，主线程处理UI");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
//                switch (error.code) {
//                    case LAErrorSystemCancel:
//                    {
//                        
//                        NSLog(@"系统取消授权，如其他APP切入");
//                        break;
//                    }
//                    case LAErrorUserCancel:
//                    {
//                        
//                        NSLog(@"用户取消验证Touch ID");
//                        break;
//                    }
//                    case LAErrorAuthenticationFailed:
//                    {
//                        
//                        NSLog(@"授权失败");
//                        break;
//                    }
//                    case LAErrorPasscodeNotSet:
//                    {
//                        
//                        NSLog(@"系统未设置密码");
//                        break;
//                    }
//                    case LAErrorTouchIDNotAvailable:
//                    {
//                        
//                        NSLog(@"设备Touch ID不可用，例如未打开");
//                        break;
//                    }
//                    case LAErrorTouchIDNotEnrolled:
//                    {
//                        
//                        NSLog(@"设备Touch ID不可用，用户未录入");
//                        break;
//                    }
//                    case LAErrorUserFallback:
//                    {
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            
//                            NSLog(@"用户选择输入密码，切换主线程处理");
//                            
//                        }];
//                        break;
//                    }
//                    default:
//                    {
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            
//                            
//                            NSLog(@"其他情况，切换主线程处理");
//                        }];
//                        break;
//                    }
//                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
