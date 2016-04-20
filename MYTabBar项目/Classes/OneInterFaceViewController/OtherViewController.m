//
//  OtherViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/5.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "OtherViewController.h"
#import "ADViewController.h"
@interface OtherViewController ()<UIGestureRecognizerDelegate>

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titles;
  
    [self createUI];

}
-(void)createUI{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(playInputClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}
-(void)playInputClick{

    ADViewController * ad = [[ADViewController alloc]init];
    [self.navigationController pushViewController:ad animated:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    self.tabBarController.tabBar.hidden = NO;
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
