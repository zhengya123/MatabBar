//
//  ErweimaViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/11.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ErweimaViewController.h"
#import "QRCodeGenerator.h"
@interface ErweimaViewController ()

@end

@implementation ErweimaViewController
{

    CATransition *animation;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)createUI{

    NSString * uRL = @"http://weixin.qq.com/r/FInw6PnEJKRbrb2L99wG";
    UIImage * image = [QRCodeGenerator qrImageForString:uRL imageSize:300];
    _backImage.image = image;


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
