//
//  LoginViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/25.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "LoginViewController.h"
#import "OneInterFaceViewController.h"
#import "TwoInterFaceViewController.h"
#import "ThreeInterFaceViewController.h"
#import "FourInterFaceViewController.h"
#import "RootTabBarController.h"
#import "RootNavigationController.h"
@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *zhanghao;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UIButton *denglu;

@end

@implementation LoginViewController
{
    UITabBarController * tabBarController;
    CATransition *animations;


}
-(void)viewWillAppear:(BOOL)animated{
    
    [super.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    //[self createTabBarController];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)denglu:(UIButton *)sender {
     if(_zhanghao.text.length ==0 ){
        NSLog(@"账号不能为空");
        UIAlertView * laert = [[UIAlertView alloc]initWithTitle:@"不好意思" message:@"账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [laert show];

    
    }else if(_mima.text.length ==0){
   
        NSLog(@"密码不能为空");
        UIAlertView * laert = [[UIAlertView alloc]initWithTitle:@"不好意思" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [laert show];
    }else if ([_zhanghao.text isEqualToString:@"0"]&&[_mima.text isEqualToString:@"0"]) {
        NSLog(@"%@--%@",_zhanghao.text,_mima.text);
        [self gointoMain];
        NSLog(@"可以登陆了");
        
        
    }else{
        UIAlertView * laert = [[UIAlertView alloc]initWithTitle:@"不好意思" message:@"账号或者密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [laert show];
    
    
    }
    
    
}
-(void)createUI{
    NSString * zh = [[NSUserDefaults standardUserDefaults]objectForKey:@"zhanghaoo"];
    NSString * mm = [[NSUserDefaults standardUserDefaults]objectForKey:@"mima"];
    if (zh != nil) {
        _zhanghao.text = zh;
    }
    if (mm !=nil) {
        _mima.text = mm;
    }
    self.view.backgroundColor = [UIColor greenColor];
    _zhanghao.delegate = self;
    _mima.delegate = self;
    [_denglu.layer addAnimation:[self opacityForever_Animation:1.0] forKey:nil];


    animations = [CATransition animation];
    animations.duration = 1.0;
    animations.timingFunction = UIViewAnimationCurveEaseInOut;
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
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[oneNav,twoNav,threeNav,fourNav];
    return tabBarController;
    
    
    
    
    
}

#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

-(void)gointoMain{
    animations.type = @"rippleEffect";//滴水效果
    animations.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:animations forKey:nil];
    [self.view.window setRootViewController:[self createTabBarController]];
   
    
    [[NSUserDefaults standardUserDefaults]setObject:_zhanghao.text forKey:@"zhanghaoo"];
    [[NSUserDefaults standardUserDefaults]setObject:_mima.text forKey:@"mimao"];
//    UIApplication *application=[UIApplication sharedApplication];
//    UIWindow *window=application.keyWindow;
//    window.rootViewController = [self createTabBarController];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == 110) {
//        switch (buttonIndex) {
//            case 0:
//                //self.view.backgroundColor = [UIColor cyanColor];
//            { UIApplication *application=[UIApplication sharedApplication];
//                UIWindow *window=application.keyWindow;
//                window.rootViewController = [self createTabBarController];
//                break;
//            }
//                           
//        }
//
//    }
   

}
#pragma mark - UITextFiledDelegate
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_zhanghao resignFirstResponder];
    [_mima resignFirstResponder];
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
