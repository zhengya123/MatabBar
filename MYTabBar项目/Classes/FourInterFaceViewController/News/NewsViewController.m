//
//  NewsViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/19.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "NewsViewController.h"
#import "LPCTools.h"
@interface NewsViewController ()

@end

@implementation NewsViewController
{
    UIView * Vieww;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新闻";
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    Vieww =[LPCTools View:CGRectMake(0, 150, 320, 50) tag:111];
    [self.view addSubview:Vieww];




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
