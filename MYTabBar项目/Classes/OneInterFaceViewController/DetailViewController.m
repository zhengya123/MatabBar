//
//  DetailViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "DetailViewController.h"
#import "API.h"
#import "SVProgressHUD.h"
@interface DetailViewController ()<UIWebViewDelegate>

@end

@implementation DetailViewController
{
    UIWebView * _webView;
 NSOperationQueue * queue;
    UIImageView * _imageView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self initUI];
    [self updateData];
}
-(void)createplace{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/2-50, SCREEN_H/2-50-69, 100, 100)];
    NSMutableArray * images = [[NSMutableArray alloc]init];
    for (int i = 1; i<13; i++) {
        NSString * imageName = [NSString stringWithFormat:@"ifree_load_0%d@2x.png",i];
        UIImage * image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    
    
    _imageView.animationImages = images;
    _imageView.animationDuration = 0.5;
    _imageView.animationRepeatCount = 100;
    
    [self.view addSubview:_imageView];
    
    [_imageView startAnimating];
    
    
    
    
}

-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self createNAV];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49)];
    _webView.delegate=self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    [self createplace];
    
}
-(void)createNAV{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"页面详情";
    self.navigationItem.titleView = titleLabel;
    
}
-(void)updateData{
   // [SVProgressHUD showWithStatus:@"正在加载，请稍后"];
    __weak typeof(self) weakSelf=self;
    /**
     block对于其变量 都会形成strong reference,对于self也会形成strong reference
     
     而如果self本身对block也是strong reference ，就会形成strong reference循环
     
     造成内存泄露，为了防止这种情况发生，在block外就应该创建一个 __weak typeof
     */
    
   
    NSBlockOperation * opration =[NSBlockOperation blockOperationWithBlock:^{
        NSString * strURL=[NSString stringWithFormat:@"http://m.haodou.com/topic-%@.html?_v=nohead",self.TopicId];
        NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.webView loadRequest:request];
            
            
        }];
       

    }];
    queue=[[NSOperationQueue alloc]init];
    [queue addOperation:opration];
   

    
    
}
//-(void)webViewDidStartLoad:(UIWebView *)webView{
//
//[_imageView stopAnimating];
//
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [_imageView stopAnimating];
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
