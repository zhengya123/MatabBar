//
//  sanpengViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/22.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "sanpengViewController.h"
#import "API.h"
@interface sanpengViewController ()

@end

@implementation sanpengViewController
{

    UIView * navBaseView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NAV];
    // Do any additional setup after loading the view from its nib.
}
-(void)NAV{

    
    //segnment添加的View
    navBaseView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/4, 0, SCREEN_W/2, 40)];
    navBaseView.backgroundColor = [UIColor yellowColor];
    self.navigationItem.titleView = navBaseView;

    //segment
    NSArray * segarray = @[@"隐藏相同",@"显示全部"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"SnellRoundhand-Bold" size:19],NSFontAttributeName ,nil];
    UISegmentedControl * segnment = [[UISegmentedControl alloc]initWithItems:segarray];
    segnment.frame = CGRectMake(0, 0, navBaseView.frame.size.width, navBaseView.frame.size.height);
    segnment.selectedSegmentIndex = 0;
    [segnment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segnment addTarget:self action:@selector(segnmentClick:) forControlEvents:UIControlEventValueChanged];
    [navBaseView addSubview:segnment];

}
-(void)segnmentClick:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
        
            NSLog(@"隐藏相同");
        }
            break;
            case 1:
        {
        
            NSLog(@"显示全部");
        }
            break;
            
        default:
            break;
    }



}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    [navBaseView removeFromSuperview];
//}
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
