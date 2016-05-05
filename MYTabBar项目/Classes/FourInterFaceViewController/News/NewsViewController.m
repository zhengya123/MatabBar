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
    for (int i=0; i<7; i++) {
      
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 69+i*20, i*i +20, i*i +20)];
        view.backgroundColor = [UIColor blackColor];
        view.layer.cornerRadius = 25;
        [self.view addSubview:[LPCTools View:view UIVieAnimation:2.0 number:10000]];
    }
    

    
    CALayer* blackPoint = [[CALayer alloc]init];
    blackPoint.frame = CGRectMake(0, 220, 20, 20);
    blackPoint.backgroundColor = [UIColor redColor].CGColor;
    blackPoint.cornerRadius = 10;
    [self.view.layer addSublayer:blackPoint];
    
    CGFloat originY = blackPoint.frame.origin.y;
    
    CAKeyframeAnimation* keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //记录每一个关键帧
    keyAnimation.values = @[[NSValue valueWithCGPoint:blackPoint.frame.origin],[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, originY)],[NSValue valueWithCGPoint:blackPoint.frame.origin]];
    //可以为对应的关键帧指定对应的时间点，其取值范围为0到1.0，keyTimes中的每一个时间值都对应values中的每一帧。如果没有设置keyTimes，各个关键帧的时间是平分的
    keyAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5],
                              [NSNumber numberWithFloat:1]];
    //指定时间函数
    keyAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    keyAnimation.repeatCount = 1000;
    keyAnimation.autoreverses = YES;
    keyAnimation.calculationMode = kCAAnimationLinear;
    keyAnimation.duration = 4;
    [blackPoint addAnimation:keyAnimation forKey:@"rectRunAnimation"];
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
