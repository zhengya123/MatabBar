//
//  CarViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/26.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "CarViewController.h"
#import "Masonry.h"
#import "API.h"
@interface CarViewController ()

@end

@implementation CarViewController
{
    UIWebView * _webView;
    NSOperationQueue * queue;
     CATransition *animation;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    
    animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    
    
    _webView = [UIWebView new];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(@20);
        make.left.and.right.equalTo(@0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@(SCREEN_H -20));
    }];
    
    //返回按钮
    UIButton * button = [UIButton new];
    button.layer.cornerRadius = 25;
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button addTarget:self action:@selector(clicksss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@(SCREEN_H -55));
        make.width.equalTo(@50);
        make.height.equalTo(@50);
        
    }];
    __weak typeof(self) weakSelf=self;
    /**
     block对于其变量 都会形成strong reference,对于self也会形成strong reference
     
     而如果self本身对block也是strong reference ，就会形成strong reference循环
     
     造成内存泄露，为了防止这种情况发生，在block外就应该创建一个 __weak typeof
     */
    
    
    NSBlockOperation * opration =[NSBlockOperation blockOperationWithBlock:^{
        NSString * strURL=[NSString stringWithFormat:@"%@",SHANGPIN_LOGIN];
        NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.webView loadRequest:request];
            
            
        }];
        
        
    }];
    queue=[[NSOperationQueue alloc]init];
    [queue addOperation:opration];




}
-(void)clicksss{
   
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissModalViewControllerAnimated:YES];



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
