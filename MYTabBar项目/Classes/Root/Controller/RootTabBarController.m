//
//  RootTabBarController.m
//  Application
//
//  Created by MS on 15-10-13.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "RootTabBarController.h"
#import "ZYTabBarButton.h"
@interface RootTabBarController ()

@property (nonatomic, assign) BOOL firstLoad; //是否为第一次加载

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    //只能在这个方法里面写,要不self.viewControllers为空
    
    if (_firstLoad) {
        //先把系统的都隐藏掉
        NSArray * arrayTabBarButtons = self.tabBar.subviews;
        for (UIView * tabBarButton in arrayTabBarButtons) {
            tabBarButton.hidden = YES;
        }
        
        //取到每个钮的宽度
        CGFloat itemWidth = self.view.bounds.size.width/self.viewControllers.count;
        for (int i = 0; i < self.viewControllers.count; i++) {
            UIViewController * vc = [self.viewControllers objectAtIndex:i];
            
            ZYTabBarButton * tabButton = [[ZYTabBarButton alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, 50) unselectedImage:vc.tabBarItem.image selectedImage:vc.tabBarItem.selectedImage title:vc.tabBarItem.title];
            tabButton.tag = 100 + i;
            [tabButton setClickEventTarget:self action:@selector(tabBarButtonClick:)];
            
            if (i == 0) {
                tabButton.selected = YES;
            }
            
            [self.tabBar addSubview:tabButton];
        }
        
        //保证只加载一次
        _firstLoad = NO;
    }
}

- (void)tabBarButtonClick:(ZYTabBarButton *)button
{
    //tabbar按钮点击的时候需要切换视图
    ZYTabBarButton * currentSelectedButton = (ZYTabBarButton *)[self.tabBar viewWithTag:(self.selectedIndex + 100)];
    
    if (currentSelectedButton != button) {
        currentSelectedButton.selected = NO;
        button.selected = YES;
        self.selectedIndex = button.tag - 100;
    }
}

//屏幕旋转的时候会调用这个方法
- (BOOL)shouldAutorotate
{
    return YES;
}























@end




