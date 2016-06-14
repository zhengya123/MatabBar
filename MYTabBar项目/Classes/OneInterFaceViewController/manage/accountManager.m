//
//  accountManager.m
//  foodsecurity
//
//  Created by wangweiyi on 15/3/25.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "accountManager.h"
#import "loginViewController.h"
#import "AppDelegate.h"
#import "ChangePassWordViewController.h"
#import "API.h"
#import "commonModel.h"
//#import "schoolList.h"
//#import "classList.h"
#import "StudentInformationViewController.h"
#import "ChangeParentInformationViewController.h"
@interface accountManager ()
{
    UIScrollView *scrollView;
}
@end

@implementation accountManager

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BG_COLOR;
    [self setNavigationBar];
    //[self creareScrollView];
    //[self createLabels];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshUI];
    [self.view reloadInputViews];
    [self createLabels];
    
}

//添加导航条的标题和返回按钮
-(void)setNavigationBar
{
    self.navigationItem.title = @"信息管理";

}

//创建一个滚动试图
-(void)creareScrollView
{
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATIONITEM_HIGH, FRAME.size.width, FRAME.size.height-64-NAVIGATIONITEM_HIGH)];
    scrollView.backgroundColor=BG_COLOR;
    [self.view addSubview:scrollView];
}

//创建内容
-(void)createLabels
{
    //学生信息
//    UIView *studentNameV=[self customView:CGRectMake(0, 10+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学生姓名" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentName"] tag:1000];
//    [scrollView addSubview:studentNameV];
//    
//    NSString *strGender=[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentGender"];
//    UIView *studentGenderV=[self customView:CGRectMake(0, studentNameV.frame.size.height+studentNameV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学生性别" rightLabel:[strGender integerValue]?@"男":@"女" tag:2000];
//    [scrollView addSubview:studentGenderV];
//    
//    UIView *studentBirthdayV=[self customView:CGRectMake(0, studentGenderV.frame.size.height+studentGenderV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"出生日期" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentBirthday"] tag:3000];
//    [scrollView addSubview:studentBirthdayV];
//    
//    UIView *kindergartenView=[self customView:CGRectMake(0, studentBirthdayV.frame.size.height+studentBirthdayV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学校" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"KindergartenName"] tag:4000];
//    [scrollView addSubview:kindergartenView];
//    NSLog(@"KindergartenName==%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"KindergartenName"]);
//    
////    UIView *classView=[self customView:CGRectMake(0, kindergartenView.frame.size.height+kindergartenView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"班级" rightLabel:[NSString stringWithFormat:@"%@(%@)",[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"],[[NSUserDefaults standardUserDefaults] valueForKey:@"NickName"]]];
//    UIButton *classButton;
//    UIView *classView=[self createCustomViewFrame:CGRectMake(0, kindergartenView.frame.size.height+kindergartenView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) LeftStr:@"班级" rightStr:[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"] button:classButton tag:5000 select:@selector(buttonCliked:)];
//   //classView.backgroundColor =  [UIColor colorWithRed:107/255.0 green:160/255.0 blue:230/255.0 alpha:0.6];
//    
//    [scrollView addSubview:classView];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/4+5, 10 + NAVIGATIONITEM_HIGH, SCREEN_W/2-10, SCREEN_W/2 -10)];
    imageView.image = [UIImage imageNamed:@"play_balanced_sel"];
    [self.view addSubview:imageView];
    
    //家长信息
    UIView *nameView=[self customView:CGRectMake(0,SCREEN_H-400+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"家长姓名" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"Name"] tag:6000];
    [self.view addSubview:nameView];
    
    UIView *relationView=[self customView:CGRectMake(0, nameView.frame.size.height+nameView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"亲属关系" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"Relation"] tag:7000];
    [self.view addSubview:relationView];
    
    UIView *telView=[self customView:CGRectMake(0, relationView.frame.size.height+relationView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"手机号" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"] tag:8000];
    [self.view addSubview:telView];
    
    UIView *addressView=[self customView:CGRectMake(0, telView.frame.size.height+telView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"家庭住址" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"Address"] tag:9000];
    [self.view addSubview:addressView];
    
//    UIButton *changePassWordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    changePassWordBtn.frame=CGRectMake(0, addressView.frame.size.height+addressView.frame.origin.y+20+NAVIGATIONITEM_HIGH, FRAME.size.width, 40);
//    [changePassWordBtn setTitle:@"  修改密码" forState:UIControlStateNormal];
//    [changePassWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [changePassWordBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [changePassWordBtn addTarget:self action:@selector(changeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:changePassWordBtn];
//    UIImageView *jiantouView=[[UIImageView alloc]initWithFrame:CGRectMake(FRAME.size.width-30, 12, 7, 12)];
//    jiantouView.image=[UIImage imageNamed:@"more_right_normal"];
//    [changePassWordBtn addSubview:jiantouView];
    
    /**
     *  查看学生信息
     */
    UIButton * LookStudentInformation = [UIButton buttonWithType:UIButtonTypeCustom];
    LookStudentInformation.frame = CGRectMake(20, SCREEN_H-64-55-55, SCREEN_W/2 - 40, 50);
    LookStudentInformation.layer.cornerRadius = 15;
    [LookStudentInformation setTitle:@"查看宝贝信息" forState:UIControlStateNormal];
    [LookStudentInformation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LookStudentInformation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [LookStudentInformation setBackgroundColor:TOOLBAR_COLOR];
    [LookStudentInformation addTarget:self action:@selector(studentInformationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LookStudentInformation];

//    [LookStudentInformation setBackgroundImage:[commonModel imageWithColor:TOOLBAR_COLOR] forState:UIControlStateNormal];
//    [LookStudentInformation setBackgroundImage:[commonModel imageWithColor:PRESS_MOLV_COLOR] forState:UIControlStateHighlighted];
    
    /**
     *  修改家长信息
     */
    UIButton * ChangeParentInformation = [UIButton buttonWithType:UIButtonTypeCustom];
    ChangeParentInformation.frame = CGRectMake(SCREEN_W/2 +20, SCREEN_H-64-55-55, SCREEN_W/2 - 40, 50);
    ChangeParentInformation.layer.cornerRadius = 15;
    [ChangeParentInformation setTitle:@"修改家长信息" forState:UIControlStateNormal];
    [ChangeParentInformation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ChangeParentInformation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [ChangeParentInformation setBackgroundColor:TOOLBAR_COLOR];
    [ChangeParentInformation addTarget:self action:@selector(ChangeParentInformationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ChangeParentInformation];
//    [ChangeParentInformation setBackgroundImage:[commonModel imageWithColor:TOOLBAR_COLOR] forState:UIControlStateNormal];
//    [ChangeParentInformation setBackgroundImage:[commonModel imageWithColor:PRESS_MOLV_COLOR] forState:UIControlStateHighlighted];
    
    /**
     *  退出登录
     */
    UIButton *quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame=CGRectMake(0, SCREEN_H - 50 - 64, FRAME.size.width, 50);
    [quitBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    quitBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    quitBtn.layer.borderWidth=0.5;
    quitBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    quitBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
   // quitBtn.layer.cornerRadius = 15;
    [quitBtn addTarget:self action:@selector(quiteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBtn];
    [quitBtn setBackgroundImage:[commonModel imageWithColor:TOOLBAR_COLOR] forState:UIControlStateNormal];
    [quitBtn setBackgroundImage:[commonModel imageWithColor:PRESS_MOLV_COLOR] forState:UIControlStateHighlighted];
    
    /**
     *  上个版本的scrollView偏移量，未删（已弃用）
     */
    scrollView.contentSize=CGSizeMake(FRAME.size.width, quitBtn.frame.size.height+quitBtn.frame.origin.y);
}

//班级button点击事件
-(void)buttonCliked:(UIButton *)button
{
//    schoolList *school = [[schoolList alloc]init];
//    school.inTypeString=@"guanli";
//    [self.navigationController pushViewController:school animated:YES];
   // classList * class = [[classList alloc]init];
   // [self.navigationController pushViewController:class animated:YES];
}

//查看学生信息
-(void)studentInformationClick{

    StudentInformationViewController * studentInformation = [[StudentInformationViewController alloc]init];
    [self.navigationController pushViewController:studentInformation animated:YES];

}

//修改家长信息界面
-(void)ChangeParentInformationClick{

    ChangeParentInformationViewController * changeParentInformation = [[ChangeParentInformationViewController alloc]init];
    [self.navigationController pushViewController:changeParentInformation animated:YES];



}

//修改密码button点击事件
-(void)changeButtonClicked:(UIButton *)button
{
    ChangePassWordViewController *changePassWordVC=[[ChangePassWordViewController alloc]init];
    [self.navigationController pushViewController:changePassWordVC animated:YES];
}

//退出button点击事件
-(void)quiteButtonClicked:(UIButton *)button
{
//    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"passWord"];
//    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"loginState"];
//    loginViewController *login = [[loginViewController alloc]init];
//    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
//    UINavigationController *nc=[[UINavigationController alloc]initWithRootViewController:login];
//    delegate.window.rootViewController=nc;
    
}

//创建一个公用方法
-(UIView *)customView:(CGRect )frame leftLabel:(NSString *)leftText rightLabel:(NSString *)rightText tag:(NSInteger)tag
{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 30)];
    leftLabel.text=leftText;
    leftLabel.font=[UIFont systemFontOfSize:15];
    leftLabel.tag=tag+1;
    [view addSubview:leftLabel];
    if (rightText.length!=0) {
        CGSize leftsize=[leftText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(100, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        leftLabel.frame=CGRectMake(10, 0, 90, leftsize.height+30);
    }
    
    
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, FRAME.size.width-110, 30)];
    rightLabel.text=rightText;
    
    rightLabel.numberOfLines=0;
    rightLabel.font=[UIFont systemFontOfSize:15];
    rightLabel.textColor=[UIColor lightGrayColor];
    rightLabel.textAlignment=NSTextAlignmentRight;
    rightLabel.tag=tag+2;
    CGSize size=[rightText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(FRAME.size.width-110, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    rightLabel.frame=CGRectMake(100, 0, FRAME.size.width-110, size.height+30);
    [view addSubview:rightLabel];
    view.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height+30);
    return view;
}



-(UIView *)createCustomViewFrame:(CGRect)frame LeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr button:(UIButton *)button tag:(NSInteger)tag select:(SEL)select
{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    label.text=leftStr;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(70, 0, FRAME.size.width-70, 40);
    [button setTitle:rightStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    button.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 30);
    button.tag=tag+2;
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    [view addSubview:button];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width-20, 14, 7, 12)];
    imageView.image=[UIImage imageNamed:@"more_right_pressed"];
    [button addSubview:imageView];
    
    return view;
}


-(void)refreshUI
{
    UILabel *schoolLabel=(UILabel *)[self.view viewWithTag:4002];
    schoolLabel.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"KindergartenName"];
    
    UIButton *classButton=(UIButton *)[self.view viewWithTag:5002];
    [classButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"] forState:UIControlStateNormal];
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
