//
//  StudentChangeViewController.m
//  foodsecurity
//
//  Created by dqong on 16/6/7.
//  Copyright © 2016年 net.bjzsgj. All rights reserved.
//

#import "StudentChangeViewController.h"
#import "API.h"
#import "commonModel.h"
//#import "classList.h"
#import "SVProgressHUD.h"
@interface StudentChangeViewController ()<UIAlertViewDelegate,UITextFieldDelegate,commonConnectDelegate>

@end

@implementation StudentChangeViewController
{

    UIView * backview;
    NSArray * array;
    UITextField * studentName;//学生姓名
    UITextField * studentBirthday;//学生生日
    UIButton * studentSex;//学生性别
    NSString * stuSex;
    UIDatePicker * pickdate;
    UIToolbar *toolbar;//工具条
    commonModel * studentChangeSave;
    NSNumber * Gender;//性别 1是男 0是女
    BOOL status;//是否在读
    NSNumber * Sta;//是否在读（用）



}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"宝贝信息";
    self.view.backgroundColor=BG_COLOR;
    [self NAV];
    [self createData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)NAV{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(Studentsave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;

}
-(void)createData{

    array = @[@"学生姓名",@"学生性别",@"出生日期",@"学校"];

}
-(void)createUI{

    UIView * v = [[UIView alloc]init];
    v.frame = CGRectMake(0, 5, SCREEN_W, SCREEN_H);
    v.backgroundColor = BG_COLOR;
    [self.view addSubview:v];
    
    /**
     *  左侧
     */
    for (int i = 0; i<4; i++) {
        
        /**
         * 底层的View
         */
        backview = [[UIView alloc]init];
        backview.frame = CGRectMake(0, i*55 + 5, SCREEN_W, 50);
        backview.backgroundColor = [UIColor whiteColor];
        backview.tag = 100 + i;
        [v addSubview:backview];
        
        /**
         * 左侧的文字
         */
        UILabel * labelleft1 = [[UILabel alloc]init];
        labelleft1.frame = CGRectMake( 10,  5, SCREEN_W/4-20, 40);
        labelleft1.textAlignment = NSTextAlignmentLeft;
        labelleft1.text = array[i];
        labelleft1.font = [UIFont systemFontOfSize:15];
        labelleft1.textColor = [UIColor darkGrayColor];
        [backview addSubview:labelleft1];
        
        /**
         * 左侧的图片
         */
        
    }


    /**
     * 右侧
     */
    /**
     * 学生姓名
     */
    studentName = [[UITextField alloc]init];
    studentName.frame = CGRectMake(SCREEN_W/2, 20, SCREEN_W/2-20, 30);
    studentName.textAlignment = NSTextAlignmentRight;
    studentName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"StudentName"];
    studentName.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:studentName];
    
    
    /**
     * 学生性别
     */
    NSString *strGender=[[NSUserDefaults standardUserDefaults] valueForKey:@"StudentGender"];
    studentSex = [UIButton buttonWithType:UIButtonTypeCustom];
    studentSex.frame = CGRectMake(SCREEN_W/2, 75, SCREEN_W/2-20, 30);
    [studentSex setTitle:[strGender integerValue]?@"男":@"女" forState:UIControlStateNormal];
    studentSex.titleLabel.font = [UIFont systemFontOfSize:17];
    [studentSex setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [studentSex setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [studentSex addTarget:self action:@selector(studentSexClick) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@",strGender);
    if ([strGender isEqual:0]) {
        Gender = @0;
    }else{
        Gender = @1;
    }
    [self.view addSubview:studentSex];
    
    /**
     * 出生日期
     */
    studentBirthday = [[UITextField alloc]init];
    studentBirthday.frame = CGRectMake(SCREEN_W/2, 130, SCREEN_W/2-20, 30);
    studentBirthday.textAlignment = NSTextAlignmentRight;
    studentBirthday.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"StudentBirthday"];
    studentBirthday.font = [UIFont systemFontOfSize:17];
    studentBirthday.delegate = self;
    [self.view addSubview:studentBirthday];
    
    //添加一个时间选择器
    pickdate=[[UIDatePicker alloc]init];
    [pickdate setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    pickdate.datePickerMode=UIDatePickerModeDate;
    studentBirthday.inputView = pickdate;
    toolbar=[[UIToolbar alloc]init];
    toolbar.barTintColor=[UIColor blackColor];
    toolbar.frame=CGRectMake(0, 0, SCREEN_W, 44);
    
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(dateClick)];
    
    toolbar.items = @[item2, item3];
    studentBirthday.inputAccessoryView=toolbar;
    
    /**
     * 学校
     */
    UILabel * schoolName = [[UILabel alloc]init];
    schoolName.frame = CGRectMake( SCREEN_W/4,  185, SCREEN_W/4 * 3-20, 30);
    schoolName.textAlignment = NSTextAlignmentRight;
    schoolName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"KindergartenName"];
    schoolName.lineBreakMode = NSLineBreakByWordWrapping;
    schoolName.numberOfLines = 0;
    schoolName.font = [UIFont systemFontOfSize:14];
    schoolName.textColor = [UIColor darkGrayColor];
    [self.view addSubview:schoolName];
    
    /**
     *  换班级
     */
    UIButton *classButton;
    UIView *classView=[self createCustomViewFrame:CGRectMake(0, 235, FRAME.size.width, 40) LeftStr:@"班级" rightStr:[[NSUserDefaults standardUserDefaults] valueForKey:@"ClassName"] button:classButton tag:5000 select:@selector(changeClassClickss)];
    [self.view addSubview:classView];
}
-(void)dateClick{

    [studentBirthday endEditing:YES];

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString * str = [NSString stringWithFormat:@"%@",pickdate.date];
    textField.text = [str substringToIndex:10];
    
}

/**
 * 改变班级时的跳转
 */
-(void)changeClassClickss{

    //classList * class = [[classList alloc]init];
   // [self.navigationController pushViewController:class animated:YES];



}
/**
 * 性别选择
 */
-(void)studentSexClick{

    UIAlertView *sex = [[UIAlertView alloc]initWithTitle:@"请选择性别" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
    sex.delegate = self;
    sex.tag=1009;
    [sex show];



}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1009) {
        switch (buttonIndex) {
            case 1:
            {
                stuSex = @"男";
                Gender = @1;
            }
                break;
            case 2:
            {
                stuSex = @"女";
                Gender = @0;
            }
                break;
                        default:
                break;
        }
       
        [studentSex setTitle:stuSex forState:UIControlStateNormal];
    }
    
}


/**
 *  保存提交
 */
-(void)Studentsave{
    if (studentName.text.length ==0 || studentSex.titleLabel.text.length == 0 || studentBirthday.text.length == 0) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请将信息补充完整！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        
    }else{
        NSLog(@"可以进行修改学生信息的网络操作了");
        [SVProgressHUD showWithStatus:@"正在保存"];
        status = [[NSUserDefaults standardUserDefaults]objectForKey:@"Status"];
        if (status) {
            Sta = @0;
        }else{
        
            Sta = @1;
        }
        NSMutableDictionary * parame = [[NSMutableDictionary alloc]init];
        
       [parame addEntriesFromDictionary:@{@"Id":[[NSUserDefaults standardUserDefaults]objectForKey:@"StudentId"],@"Code":[[NSUserDefaults standardUserDefaults]objectForKey:@"StudentCode"],@"Name":studentName.text,@"Birthday":studentBirthday.text,@"Gender":Gender,@"Status":Sta}];
        
        
//        studentChangeSave = [[commonModel alloc]initWithUrl:BASE_URL_LOGIN postpath:POST_UPDATESTUDENT parameters:parame];
//        studentChangeSave.delegate = self;
        
    }

}

-(void)gotTheData:(NSDictionary *)dataDic and:(commonModel *)connect{
    
    NSLog(@"%@",dataDic);
    [SVProgressHUD dismissWithSuccess:@"保存成功"];
    //先把存的值替换掉
    [[NSUserDefaults standardUserDefaults]setValue:studentName.text forKey:@"StudentName"];
     [[NSUserDefaults standardUserDefaults]setValue:studentBirthday.text forKey:@"StudentBirthday"];
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

}
-(void)gotTheErrorMessage:(NSString *)errorMessage and:(commonModel *)connect{
    NSLog(@"%@",errorMessage);
    [SVProgressHUD dismiss];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"保存失败，请检查用户信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];




}
-(void)connectError:(commonModel *)connect{
    NSLog(@"网络连接错误");


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
