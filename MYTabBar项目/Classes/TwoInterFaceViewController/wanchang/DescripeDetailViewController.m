//
//  DescripeDetailViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/19.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "DescripeDetailViewController.h"

@interface DescripeDetailViewController ()

@end

@implementation DescripeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view from its nib.
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
