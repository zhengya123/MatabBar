//
//  ADViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/13.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ADViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface ADViewController ()

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    
//     UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.adlianjie] placeholderImage:[UIImage imageNamed:@"3"]];
//    [self.view addSubview:imageView];



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
