//
//  BanbenViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/5/11.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "BanbenViewController.h"
#import "API.h"
#import "Masonry.h"
#import "HIKLoadView.h"
#import "ZYView.h"
@interface BanbenViewController ()


@property (nonatomic, strong) HIKLoadView *loadingView;
@end

@implementation BanbenViewController
{

    ZYView * zyView;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleName;
    
    //[self.view insertSubview:_loadingView aboveSubview:self.playerView];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{

    UIView * baseView1 = [UIView new];
    baseView1.backgroundColor = [UIColor whiteColor];
    baseView1.layer.cornerRadius = 25;
    [self.view addSubview:baseView1];
    
    [baseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@50);
    }];

    UIView * baseView2 = [UIView new];
    baseView2.backgroundColor = [UIColor whiteColor];
    baseView2.layer.cornerRadius = 25;
    [self.view addSubview:baseView2];
    
    [baseView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView1.mas_bottom).offset(50);
        make.left.equalTo(@10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@50);
    }];

    UILabel * label = [UILabel new];
    label.frame = CGRectMake(10, 5, SCREEN_W/3, 40);
    label.text = @"版本号：";
    label.textAlignment = NSTextAlignmentLeft;
    [baseView1 addSubview:label];
    
    UILabel * label2 = [UILabel new];
    label2.frame = CGRectMake(10, 5, SCREEN_W/3, 40);
    label2.text = @"构件号：";
    label2.textAlignment = NSTextAlignmentLeft;
    [baseView2 addSubview:label2];
    
    UILabel * label11 = [UILabel new];
    label11.frame = CGRectMake(SCREEN_W/3, 5, SCREEN_W/2, 40);
    label11.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    label11.textAlignment = NSTextAlignmentRight;
    [baseView1 addSubview:label11];
    
    UILabel * label22 = [UILabel new];
    label22.frame = CGRectMake(SCREEN_W/3, 5, SCREEN_W/2, 40);
    label22.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    label22.textAlignment = NSTextAlignmentRight;
    [baseView2 addSubview:label22];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_H -100, SCREEN_W, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clicksss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if(!_loadingView)
        _loadingView = [[HIKLoadView alloc] initWithHIKLoadViewStyle:HIKLoadViewStyleSqureClockWise];
    _loadingView.frame = CGRectMake(SCREEN_W/2-50, 300, 100, 100);
    [self.view addSubview:_loadingView];
    // [self.view insertSubview:_loadingView aboveSubview:self.view];
    [_loadingView stopSquareClockwiseAnimation];


}
-(void)clicksss{
    NSLog(@"点击了");
   // [self.loadingView startSquareClcokwiseAnimation];
    
    
    if(zyView == nil){
    
        zyView = [[ZYView alloc]init];
        zyView.frame = CGRectMake(0, SCREEN_W/2, SCREEN_W, SCREEN_W/2);
        [self.view addSubview:zyView];
    
    
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
