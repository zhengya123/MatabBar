//
//  ChangePassWordViewController.m
//  foodsecurity
//
//  Created by fuyang on 15/4/13.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "API.h"
#import "commonModel.h"
#import "loginViewController.h"
#import "AppDelegate.h"
#import "CustomTextFieldView.h"
@interface ChangePassWordViewController ()<commonConnectDelegate,UIAlertViewDelegate>
{
    CustomTextFieldView *oldPassWordTF;
    CustomTextFieldView *newPassWordTF;
}
@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self createTextFieldAndButton];
    // Do any additional setup after loading the view from its nib.
}

//添加导航条的标题和返回按钮
-(void)setNavigationBar
{
    self.navigationItem.title = @"修改密码";
}


//创建内容
-(void)createTextFieldAndButton
{
    oldPassWordTF=[[CustomTextFieldView alloc]initWithFrame:CGRectMake(10, 10+NAVIGATIONITEM_HIGH, FRAME.size.width-20, 50) placeholder:@"请输入旧密码"];
    oldPassWordTF.tag=1000;
    [self.view addSubview:oldPassWordTF];
    
    newPassWordTF=[[CustomTextFieldView alloc]initWithFrame:CGRectMake(10, 70+NAVIGATIONITEM_HIGH, FRAME.size.width-20, 50) placeholder:@"请输入新密码"];
    newPassWordTF.tag=2000;
    [self.view addSubview:newPassWordTF];
    
   
    UIButton *sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame=CGRectMake(10, 160+NAVIGATIONITEM_HIGH, FRAME.size.width-20, 60);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[commonModel imageWithColor:TOOLBAR_COLOR] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[commonModel imageWithColor:PRESS_MOLV_COLOR] forState:UIControlStateHighlighted];
    sureButton.titleLabel.font=[UIFont systemFontOfSize:20];
    sureButton.layer.cornerRadius=5;
    [sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    
    
    
    
}


//确定按钮点击事件
-(void)sureButtonClicked:(UIButton *)button
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    if (oldPassWordTF.textField.text.length==0) {
        alert.message=@"旧密码不能为空";
        [alert show];
    }else if(newPassWordTF.textField.text.length==0)
    {
        alert.message=@"新密码不能为空";
        [alert show];
    }else
    {
        [self togoRequest];
    }
    
}


//网络请求
-(void)togoRequest
{
    NSDictionary *paramater = @{@"OldPassword":[commonModel md5:oldPassWordTF.textField.text], @"NewPassword":[commonModel md5:newPassWordTF.textField.text],@"UserId":[[NSUserDefaults standardUserDefaults] stringForKey:@"UserId"]};
    NSLog(@" md5 %@",[commonModel md5:oldPassWordTF.textField.text]);
    [self gotToChange:paramater];
}

//网络请求
-(void)gotToChange:(NSDictionary *)paramater
{
//    commonModel* connect = [[commonModel alloc]initWithUrl:BASE_URL_LOGIN postpath:POST_CHANGEPASSWORD parameters:paramater];
//    connect.delegate=self;
}


-(void)gotTheData:(NSDictionary *)dataDic and:(commonModel *)connect
{
    NSLog(@"修改密码啦啦啦===%@",dataDic);
    newPassWordTF.textField.text=@"";
    oldPassWordTF.textField.text=@"";
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.delegate=self;
    alert.tag=110;
    [alert show];
}

-(void)gotTheErrorMessage:(NSString *)errorMessage and:(commonModel *)connect
{
    NSLog(@"to changePassWord  %@",errorMessage);
    if (errorMessage.length!=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


//UIAlertView的代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==110) {
//        loginViewController *login = [[loginViewController alloc]init];
//        AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
//        UINavigationController *nc=[[UINavigationController alloc]initWithRootViewController:login];
//        delegate.window.rootViewController=nc;
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
