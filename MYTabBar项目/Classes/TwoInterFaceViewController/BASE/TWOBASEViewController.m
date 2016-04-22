//
//  TWOBASEViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/18.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "TWOBASEViewController.h"

@interface TWOBASEViewController ()

@end

@implementation TWOBASEViewController
/**
 *  跳转的时候隐藏tabBar，需要继承次类（这是他们的爸爸，哈哈哈）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    if(self.navigationController.childViewControllers.count == 1)
    {
       self.tabBarController.tabBar.hidden = NO;
        
    }else{
    
    
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
