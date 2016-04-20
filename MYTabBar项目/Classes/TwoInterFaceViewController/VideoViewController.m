//
//  VideoViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/15.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "VideoViewController.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "API.h"
@interface VideoViewController ()

@property (weak, nonatomic) FMGVideoPlayView *playView;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleName;
    self.tabBarController.tabBar.hidden = YES;
    [self setupVideoPlayView];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupVideoPlayView
{
    FMGVideoPlayView *playView = [FMGVideoPlayView videoPlayView];
    // 视频资源路径
    [playView setUrlString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
    //[playView setUrlString:@"http://v.17173.com/v_102_623/MjQ3NTc0MDg.html"];
    // 播放器显示位置（竖屏时）
     playView.frame = CGRectMake(0, 0, SCREEN_W, 250);
    // 添加到当前控制器的view上
    [self.view addSubview:playView];
    
    // 指定一个作为播放的控制器
    playView.contrainerViewController = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{

    [_playView removeFromSuperview];
    self.tabBarController.tabBar.hidden = NO;
    


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
