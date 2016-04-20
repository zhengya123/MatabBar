//
//  FourInterFaceViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "FourInterFaceViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootNavigationController.h"
#import "ErweimaViewController.h"
#import "LookViewController.h"

#import "BUIView.h"
#import "NewsViewController.h"
@interface FourInterFaceViewController ()<
UITableViewDelegate,
UITableViewDataSource>


@end

@implementation FourInterFaceViewController
{
    NSMutableArray * _arrayDS;
    UITableView * _tableView;
    UIImageView * _imageView;
    CATransition *animation;
    NSString * message;

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super.navigationController setNavigationBarHidden:YES];
    //self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)initData{
    
   // self.navigationItem.title=@"关   于";
    // UITextAttributeTextColor=[UIColor redColor];
    
    _arrayDS =[[NSMutableArray alloc]init];
    NSMutableArray * arrayone=[[NSMutableArray alloc]init];
    NSMutableArray * arraytwo=[[NSMutableArray alloc]init];
    NSMutableArray * arraythree=[[NSMutableArray alloc]init];
    
    
    NSString * strone=[NSString stringWithFormat:@"新闻热点"];
    NSString * strtwo=[NSString stringWithFormat:@"娱乐杂志"];
    NSString * strthree=[NSString stringWithFormat:@"趣味笑话"];
    NSString * strfour=[NSString stringWithFormat:@"分享"];
    
    
    [arrayone addObject:strone];
    [arrayone addObject:strtwo];
    [arrayone addObject:strthree];
    [arrayone addObject:strfour];
    
    
    NSString * strfive=[NSString stringWithFormat:@"我的二维码"];
    NSString * strsix=[NSString stringWithFormat:@"扫一扫"];
    NSString * strseven=[NSString stringWithFormat:@"摇一摇"];
    [arraytwo addObject:strfive];
    [arraytwo addObject:strsix];
    [arraytwo addObject:strseven];
    
    NSString * streight=[NSString stringWithFormat:@"版本信息"];
    NSString * strneight=[NSString stringWithFormat:@"关于我们"];
    NSString * tuichu = [NSString stringWithFormat:@"退出登陆"];
    
    [arraythree addObject:streight];
    [arraythree addObject:strneight];
    [arraythree addObject:tuichu];
    
    
    
    [_arrayDS addObject:arrayone];
    [_arrayDS addObject:arraytwo];
    [_arrayDS addObject:arraythree];
    
}
-(void)initUI{
    
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1]];
    //设置背景样式可用通过设置tintColor来设置
    // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0];//改变navigation的背景颜色
    //self.navigationController.navigationBarHidden=YES;
    //self.automaticallyAdjustsScrollViewInsets=YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.backgroundColor=[UIColor clearColor];
    
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image=[UIImage imageNamed:@"fengmian.png"];
    
    [self.view addSubview:_imageView];
    
    [self.view addSubview:_tableView];
    
    animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _arrayDS.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_arrayDS objectAtIndex:section] count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str=@"CellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str ];
    }
    NSArray * array1=[_arrayDS objectAtIndex:indexPath.section];
    NSString * strDS=[array1 objectAtIndex:indexPath.row];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"进入符.png"] forState:UIControlStateNormal];
    cell.textLabel.text=strDS;
    [cell setAccessoryView:button];
    //cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.alpha=0.1;
    
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0 ) {
        return @" ";
    }if (section==1) {
        return @"";
    }
    else{
        
        return @" ";
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                message = @"即将展示一条新闻";
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"跳转", nil];
                [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
                    if (buttonIndex == 0) {
                        
                    }else if (buttonIndex ==1){
                    
                        NewsViewController * LV = [[NewsViewController alloc]init];
                        [self.navigationController pushViewController:LV animated:YES];
                    
                    }
                }];
                [alert show];
                
            }
                break;
            case 1:
            {
            UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"娱乐杂志" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"第一个" otherButtonTitles:@"第二个",@"第三个", nil];
                [actionSheet showInView:self.view];
                
                
                 }
                break;
                
            case 2:
            {
            
            
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                case 0:
            {
                ErweimaViewController * erweima = [[ErweimaViewController alloc]init];
                animation.type = @"rippleEffect";
                animation.subtype = kCATransitionFromTop;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentModalViewController:erweima animated:YES];
            
            }
                break;
            case 1:
            {
                LookViewController * looklook = [[LookViewController alloc]init];
                animation.type = @"rippleEffect";//滴水效果
                animation.subtype = kCATransitionFromTop;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentModalViewController:looklook animated:YES];
            
            }
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section==2) {
        
        switch (indexPath.row) {
            case 0:
            {
                
                break;
            }
            case 1:
            {
                
                break;
            }
            case 2:
            {
                [self tuichudenglu];
                
            }
            default:
                break;
        }
    }
    

}
-(void)tuichudenglu{

    LoginViewController * login = [[LoginViewController alloc]init];
    AppDelegate * appdelegate = [[UIApplication sharedApplication] delegate];
    RootNavigationController * nav = [[RootNavigationController alloc]initWithRootViewController:login];
    appdelegate.window.rootViewController = nav;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
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
