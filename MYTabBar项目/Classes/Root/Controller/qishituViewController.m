//
//  qishituViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/6.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "qishituViewController.h"
#import "KSGuideManager.h"
@interface qishituViewController ()

@end

@implementation qishituViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *paths = [NSMutableArray new];
    
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]];
    
    [[KSGuideManager shared] showGuideViewWithImages:paths];
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
