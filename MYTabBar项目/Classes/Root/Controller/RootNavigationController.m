//
//  RootNavigationController.m
//  Application
//
//  Created by MS on 15-10-13.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "RootNavigationController.h"
#import "UINavigationBar+Awesome.h"
@interface RootNavigationController ()<
UIGestureRecognizerDelegate>

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    //更新状态栏风格
//    //如果有NavigationController 一定要在NavigationController里面设置
//    [self setNeedsStatusBarAppearanceUpdate];
//    
//    //启用返回手势需要添加这个手势delegate属性
//    self.interactivePopGestureRecognizer.delegate = self;
//    
//    //设置标题颜色 字体
//    self.navigationBar.titleTextAttributes = @{
//                                               NSForegroundColorAttributeName:[UIColor grayColor],
//                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
//                                               };
//    //self.navigationBarHidden=YES;
//    //设置背景样式可用通过设置tintColor来设置
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0];//改变navigation的背景颜色
   // [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:0];
    [self.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationBar.titleTextAttributes = @{
                                                                                              NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                              NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                                              };
   // [self.navigationBar setBarTintColor:[UIColor yellowColor]];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置返回按钮文字属性
    NSMutableDictionary *textAttrs            = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    // textAttrs[NSFontAttributeName]            = ECG_AUTO_FONT_16;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
//返回状态栏风格
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


#pragma mark - UIGestureRecognizerDelegate

//在手势的代理函数这里判断 是否要启用手势 返回YES是启用 返回NO就是禁用
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    return NO;
}



@end
