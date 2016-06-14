//
//  StudentInformationViewController.m
//  foodsecurity
//
//  Created by dqong on 16/6/7.
//  Copyright © 2016年 net.bjzsgj. All rights reserved.
//

#import "StudentInformationViewController.h"
#import "API.h"
#import "commonModel.h"
//#import "schoolList.h"
//#import "classList.h"
#import "StudentChangeViewController.h"
@interface StudentInformationViewController ()

@end

@implementation StudentInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"宝贝信息";
    self.view.backgroundColor=BG_COLOR;
    [self NAV];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshUI];
    
}

-(void)NAV{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setTitle:@"修改" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(studentChange) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;



}
-(void)createUI{

    //学生信息
        UIView *studentNameV=[self customView:CGRectMake(0, 10+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学生姓名" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentName"] tag:1000];
        [self.view addSubview:studentNameV];
    
        NSString *strGender=[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentGender"];
        UIView *studentGenderV=[self customView:CGRectMake(0, studentNameV.frame.size.height+studentNameV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学生性别" rightLabel:[strGender integerValue]?@"男":@"女" tag:2000];
        [self.view addSubview:studentGenderV];
    
        UIView *studentBirthdayV=[self customView:CGRectMake(0, studentGenderV.frame.size.height+studentGenderV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"出生日期" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentBirthday"] tag:3000];
        [self.view addSubview:studentBirthdayV];
    
        UIView *kindergartenView=[self customView:CGRectMake(0, studentBirthdayV.frame.size.height+studentBirthdayV.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学校" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"KindergartenName"] tag:4000];
        [self.view addSubview:kindergartenView];
        NSLog(@"KindergartenName==%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"KindergartenName"]);
    
    UIView *class=[self customView:CGRectMake(0, kindergartenView.frame.size.height+kindergartenView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) leftLabel:@"学校" rightLabel:[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"] tag:5000];
    [self.view addSubview:class];
    
//        UIButton *classButton;
//        UIView *classView=[self createCustomViewFrame:CGRectMake(0, kindergartenView.frame.size.height+kindergartenView.frame.origin.y+5+NAVIGATIONITEM_HIGH, FRAME.size.width, 40) LeftStr:@"班级" rightStr:[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"] button:classButton tag:5000 select:@selector(changeClassClick)];
       //classView.backgroundColor =  [UIColor colorWithRed:107/255.0 green:160/255.0 blue:230/255.0 alpha:0.6];
        
        //[self.view addSubview:classView];




}

//改变班级按钮跳转方法
//-(void)changeClassClick{
//
//    classList * class = [[classList alloc]init];
//    [self.navigationController pushViewController:class animated:YES];
//
//
//}

-(void)refreshUI
{
    UILabel *schoolLabel=(UILabel *)[self.view viewWithTag:4002];
    schoolLabel.text=[[NSUserDefaults standardUserDefaults] stringForKey:@"KindergartenName"];
    
    UILabel *classButton=(UILabel *)[self.view viewWithTag:5000];
    classButton.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"ClassName"];
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

-(void)studentChange{
    StudentChangeViewController * studentChange = [[StudentChangeViewController alloc]init];
    [self.navigationController pushViewController:studentChange animated:YES];



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
