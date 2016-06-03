//
//  GradeViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/6/3.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "GradeViewController.h"
#import "YYStarView.h"
@interface GradeViewController ()<YYStarViewDelegate>
@property (nonatomic,strong)YYStarView * straView;
@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{

    self.straView = [[YYStarView alloc]initWithFrame:CGRectMake(10, 100, 300, 40) numberOfStars:5];
    self.straView.scorePercent = 0.3;//初始显示的星数
    self.straView.allowIncompleteStar = YES;//是否允许不是整数
    self.straView.hasAnimation = YES;//是否允许动画
    self.straView.delegate = self;
    [self.view addSubview:self.straView];


}

-(void)starView:(YYStarView *)starView scorePercentDidChange:(CGFloat)newScorePercent{
    NSLog(@"%f",self.straView.scorePercent);
    if (self.straView.scorePercent < 0.8) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"谢谢老板" message:@"我们已经收到您的评分，感谢您对我们的支持，我们尽快改正不足，欢迎再次光临" delegate:self cancelButtonTitle:@"谢 谢" otherButtonTitles:nil, nil];
        [alert show];
    }else{
    
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"谢谢老板" message:@"，欢迎再次光临" delegate:self cancelButtonTitle:@"谢 谢" otherButtonTitles:nil, nil];
        [alert show];
    
    
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
