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
@interface FourstViewController ()

@end

@implementation FourstViewController
{

    UIImageView * _imageView;


}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [super.navigationController setNavigationBarHidden:YES];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image=[UIImage imageNamed:@"fengmian.png"];
    
    //[self.view addSubview:_imageView];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setupGroup1{
    WMSettingGroup *group       = [self addGroup];
    WMSettingLabelItem *qq      = [WMSettingLabelItem
                                   itemWithIcon:@"personal_btn_qq"
                                   title:@"新闻热点"
                                   destVcClass:NSClassFromString(@"NewsViewController")];

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
    
    qq.readyForDestVc = ^(WMSettingLabelItem *item, NewsViewController *descVC) {
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
                              itemWithIcon:@"qq1"
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
    ZYtoappstore * toappStore = [[ZYtoappstore alloc]init];
    toappStore.myAppID        = @"1055238193";
       
    [toappStore showGotoAppStore:self];


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
