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
    UIView * _titleBaseView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{

    _titleBaseView = [UIView new];
    _titleBaseView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_titleBaseView];
    [_titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@200);
    } ];

    UILabel * label = [UILabel new];
    label.text = @"车型";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_titleBaseView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.left.equalTo(@10);
        make.width.equalTo(@(SCREEN_W/6));
        make.height.equalTo(@20);
    } ];
    
    UILabel * label2 = [UILabel new];
    label2.text = @"配置表";
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [_titleBaseView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5);
        make.centerX.equalTo(label.mas_centerX);
        make.left.and.right.equalTo(label);
    } ];




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
