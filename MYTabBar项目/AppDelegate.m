//
//  AppDelegate.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "AppDelegate.h"
#import "OneInterFaceViewController.h"
#import "TwoInterFaceViewController.h"
#import "ThreeInterFaceViewController.h"
#import "FourInterFaceViewController.h"
#import "RootTabBarController.h"
#import "RootNavigationController.h"
#import "LoginViewController.h"
#import "qishituViewController.h"
#import "APIKey.h"
#import "API.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "COSTouchVisualizerWindow.h"//屏幕触感动画
@interface AppDelegate ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)UIView * lunchView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)SDCycleScrollView * scrollView;


#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
/**
 *  高德地图AppKey
 */
#define gaodeAppKey @"cae88d9916a9f3bc227cb4ee4b010ac5"
@end

@implementation AppDelegate
{
    NSMutableArray  * array;
    NSString * str;
    NSString * str2;
    NSString * str3;
    NSString * str4;
    NSString * str5;
    NSString * str6;
    NSTimer * time;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    str = @"http://mg.soupingguo.com/bizhi/big/10/258/043/10258043.jpg";
    str2 = @"http://img1.hoto.cn/haodou/center/ad/ceba6d32.jpg";
    str3 = @"http://img1.hoto.cn/haodou/center/ad/cc98cacd.jpg";
    str4 = @"http://img1.hoto.cn/haodou/center/ad/83642f0.jpg";
    str5 = @"http://img1.hoto.cn/haodou/center/ad/840f99e.jpg";
    str6 = @"http://img1.hoto.cn/haodou/center/ad/f82b750f.jpg";
    array = [[NSMutableArray alloc]init];
    [array addObject:str];
    [array addObject:str2];
    [array addObject:str3];
    //[array addObject:str4];
    //[array addObject:str5];
    //[array addObject:str6];
    /**
     * UIView
     */
    _lunchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
   // [self.window addSubview:_lunchView];
    /**
     *UIScrollView
     */
    _scrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) imageURLStringsGroup:nil];
    _scrollView.infiniteLoop = YES;
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _scrollView.delegate = self;
    _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _scrollView.autoScrollTimeInterval = 3.5;
     _scrollView.imageURLStringsGroup =array;
    [_lunchView addSubview:_scrollView];
    NSLog(@"%ld",array.count);
    
    /**
     *UIImageView
     */
//    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"3"]];
   // [_lunchView addSubview:_imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_W/2 + 80, 40, 60, 40);
    [button setTitle:@"跳过" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.alpha = 0.6;
    button.layer.cornerRadius = 50/5;
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [_lunchView addSubview:button];
    
   // time = [NSTimer scheduledTimerWithTimeInterval:array.count * 3.5 target:self selector:@selector(removeAdImageView) userInfo:nil repeats:YES];
   // [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:array.count * 3.5];
    self.window.backgroundColor = [UIColor whiteColor];
    [self loadRootViewController];
    [self.window makeKeyAndVisible];
    //[self window];
    [self c];
    return YES;
    
    
}
-(void)jump{
    NSLog(@"跳过广告了");
    
    [UIView animateWithDuration:0.3f animations:^{
        _lunchView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _lunchView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_lunchView removeFromSuperview];
        [self loadRootViewController];
        [time invalidate];
    }];


}
-(void)removeAdImageView{
    [UIView animateWithDuration:0.3f animations:^{
        _lunchView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _lunchView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_lunchView removeFromSuperview];
         [self loadRootViewController];
        [time invalidate];
    }];



}
//触感动画
- (COSTouchVisualizerWindow *)window
{
    static COSTouchVisualizerWindow *customWindow = nil;
    if (!customWindow) {
        customWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [customWindow setFillColor:TOUCH_COLOR];
        [customWindow setStrokeColor:[UIColor clearColor]];
        [customWindow setTouchAlpha:0.4];
        
        [customWindow setRippleFillColor:TOUCH_COLOR];
        [customWindow setRippleStrokeColor:[UIColor clearColor]];
        [customWindow setRippleAlpha:0.1];
    }
    return customWindow;
}

- (void)c
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    [AMapLocationServices sharedServices].apiKey = (NSString *)APIKey;
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([array[index] hasPrefix:@"http://"]||[array[index] hasPrefix:@"https://"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:array[index]]];
    }


}

-(void)loadRootViewController{

    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"mimao"].length == 0) {
        LoginViewController * login = [[LoginViewController alloc]init];
        RootNavigationController * nav = [[RootNavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
    }else{
    
        self.window.rootViewController = [self createTabBarController];
    }
   
//    qishituViewController * qishitu = [[qishituViewController alloc]init];
//    RootNavigationController * navv = [[RootNavigationController alloc]initWithRootViewController:qishitu];
//    self.window.rootViewController = navv;

}
-(UITabBarController *)createTabBarController{
    //初始化四个视图
    OneInterFaceViewController * oneVC=[[OneInterFaceViewController alloc]init];
    TwoInterFaceViewController * twoVC=[[TwoInterFaceViewController alloc]init];
    ThreeInterFaceViewController * threeVC=[[ThreeInterFaceViewController alloc]init];
    FourInterFaceViewController * fourVC=[[FourInterFaceViewController alloc]init];
    
    //初始化对应的导航栏
    RootNavigationController * oneNav=[[RootNavigationController alloc]initWithRootViewController:oneVC];
    RootNavigationController * twoNav=[[RootNavigationController alloc]initWithRootViewController:twoVC];
    RootNavigationController * threeNav=[[RootNavigationController alloc]initWithRootViewController:threeVC];
    RootNavigationController * fourNav=[[RootNavigationController alloc]initWithRootViewController:fourVC];
    //设置tabBar上对应的标题
    oneNav.tabBarItem.title=@"热 点";
    twoNav.tabBarItem.title=@"发 现";
    threeNav.tabBarItem.title=@"附 近";
    fourNav.tabBarItem.title=@"关 于";
    
    //设置tabBar对应的图片
    oneNav.tabBarItem.image=[UIImage imageNamed:@"tab_0"];
    oneNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_c0"];
    twoNav.tabBarItem.image=[UIImage imageNamed:@"tab_1"];
    twoNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_c1"];
    threeNav.tabBarItem.image=[UIImage imageNamed:@"tab_2"];
    threeNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_c2"];
    fourNav.tabBarItem.image=[UIImage imageNamed:@"tab_3"];
    fourNav.tabBarItem.selectedImage=[UIImage imageNamed:@"tab_c3"];
    
    //用设置好的四个视图来初始化TabBarController
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[oneNav,twoNav,threeNav,fourNav];
    return tabBarController;





}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
