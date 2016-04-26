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
#import "API.h"
#import "BUIView.h"
#import "NewsViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface FourInterFaceViewController ()<
UITableViewDelegate,
UITableViewDataSource,
CLLocationManagerDelegate>

//初始化定位变量
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation FourInterFaceViewController
{
    NSMutableArray * _arrayDS;
    UITableView * _tableView;
    UIImageView * _imageView;
    CATransition *animation;
    NSString * message;
    CLPlacemark * plmark;
    UIView * view;
    NSTimer * time;
    NSString * weizhixinxi;

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super.navigationController setNavigationBarHidden:YES];
    //self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   [self getLocation];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
//(定位)初始化变量manager
- (void)getLocation{
    _manager = [[CLLocationManager alloc]init];
    [_manager requestAlwaysAuthorization];
    _manager.delegate = self;
    [_manager startUpdatingLocation];
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
    NSString * strseven=[NSString stringWithFormat:@"我的城市"];
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
    
    /**
     View显示正在定位中、、、
     */
    view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/4 , SCREEN_H/2- SCREEN_W/4 *( 9/16), SCREEN_W/2, SCREEN_W/2 * ( 9/16))];
    view.layer.cornerRadius = 25;
    view.backgroundColor = [UIColor whiteColor];
    //[view setBackgroundColor:[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.5]];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 50)];
    label.text = @"正在定位中、、、";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    view.hidden = YES;
    
}
//- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha
//{
//[view.backgroundColor colorWithAlphaComponent:0.5];
//    
//}
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
            case 2:
            {
                //我的定位的城市
                [self location];
            
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
   //将密码置为空
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"mimao"];
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
-(void)location{
    
    
    if (plmark.name == nil) {
        view.hidden = NO;
        time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dingweijianche) userInfo:nil repeats:YES];
    }else{
    
        NSString * location = [NSString stringWithFormat:@"您现在的地址是：%@",plmark.name];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:location delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    

}
-(void)dingweijianche{

    if (plmark.name !=nil) {
        view.hidden = YES;
        [self location];
        [time invalidate];
    }



}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currLocation=[locations lastObject];
    NSLog(@"la---%f, lo---%f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
    // 使用CLGeocoder的做法，其实是因为ios5开始，iphone推荐的做法。而MKReverseGeocoder在ios5之后，就不再推荐使用了，因为这个类需要实现两个委托方法。而使用CLGeocodre，则可以使用直接的方法。
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray* placemarks,NSError *error) {
        if (placemarks.count >0   ) {
            // 自动定位获取城市等信息
            plmark = [placemarks objectAtIndex:0];
            NSLog(@"%@", plmark.name); //显示所有地址
            //            _label.text = plmark.name; //给label负值
        }
    }];
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
