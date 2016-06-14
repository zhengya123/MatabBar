//
//  ChangeParentInformationViewController.m
//  foodsecurity
//
//  Created by dqong on 16/6/7.
//  Copyright © 2016年 net.bjzsgj. All rights reserved.
//

#import "ChangeParentInformationViewController.h"
#import "API.h"
#import "commonModel.h"
//#import "classModel.h"
#import "SVProgressHUD.h"
@interface ChangeParentInformationViewController ()<UITextFieldDelegate,commonConnectDelegate>

@end

@implementation ChangeParentInformationViewController
{


    UIView * backview;
    UITextField * textField1;//家长姓名
    UITextField * textField2;//家庭住址
    NSString * _relationShipName;//按钮显示的亲属关系
    UIButton * relationShip;//亲属关系按钮
    NSArray * array;
    commonModel * presentSave;
   // classModel * classmodel;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改家长信息";
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
    [button addTarget:self action:@selector(Parentsave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;


}
-(void)createData{

    array = @[@"家长姓名",@"亲属关系",@"手机号",@"家庭住址"];


}
//家长信息
-(void)createUI{
   
    
    for (int i = 0; i<4; i++) {
        
        /**
         * 底层的View
         */
        backview = [[UIView alloc]init];
        backview.frame = CGRectMake(0, i*50 + 20, SCREEN_W, 40);
        backview.backgroundColor = [UIColor whiteColor];
        backview.tag = 100 + i;
        [self.view addSubview:backview];
        
        /**
         * 左侧的文字
         */
        UILabel * labelleft1 = [[UILabel alloc]init];
        labelleft1.frame = CGRectMake( 10,  5, SCREEN_W/4-20, 30);
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
     家长姓名
     */
    textField1 = [[UITextField alloc]init];
    textField1.frame = CGRectMake(SCREEN_W/2, 25, SCREEN_W/2-20, 30);
    textField1.textAlignment = NSTextAlignmentRight;
    textField1.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Name"];
    textField1.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textField1];

    /**
     *  亲属关系
     */
    NSString * rela = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Relation"]];
    relationShip = [UIButton buttonWithType:UIButtonTypeCustom];
    relationShip.frame = CGRectMake(SCREEN_W/2, 75, SCREEN_W/2-20, 30);
    [relationShip setTitle:rela forState:UIControlStateNormal];
    relationShip.titleLabel.font = [UIFont systemFontOfSize:17];
    [relationShip setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [relationShip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [relationShip addTarget:self action:@selector(relashipClick) forControlEvents:UIControlEventTouchUpInside];
    relationShip.tag = 1001;
    [self.view addSubview:relationShip];
    
    /**
     * 手机号
     */
    UILabel * phone = [[UILabel alloc]init];
    phone.frame = CGRectMake( SCREEN_W/2,  125, SCREEN_W/2-20, 30);
    phone.textAlignment = NSTextAlignmentRight;
    phone.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    phone.font = [UIFont systemFontOfSize:17];
    phone.textColor = [UIColor darkGrayColor];
    [self.view addSubview:phone];
    
    
    /**
     * 家庭住址
     */
    textField2 = [[UITextField alloc]init];
    textField2.frame = CGRectMake(SCREEN_W/2, 175, SCREEN_W/2-20, 30);
    textField2.textAlignment = NSTextAlignmentRight;
    textField2.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Address"];
    textField2.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textField2];
}

-(void)relashipClick{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请选择亲属关系" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"爸爸",@"妈妈",@"爷爷",@"奶奶",@"外公",@"外婆",@"其他", nil];
    alert.delegate=self;
    alert.tag = 1111;
    [alert show];


}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1111) {
        switch (buttonIndex) {
            case 0:
            {
                _relationShipName = @"其他";
            }
                break;
            case 1:
            {
                _relationShipName = @"爸爸";
            }
                break;
            case 2:
            {
                _relationShipName = @"妈妈";
            }
                break;
            case 3:
            {
                _relationShipName = @"爷爷";
            }
                break;
            case 4:
            {
                _relationShipName = @"奶奶";
            }
                break;
            case 5:
            {
                _relationShipName = @"外公";
            }
                break;
            case 6:
            {
                _relationShipName = @"外婆";
            }
                break;
            case 7:
            {
                _relationShipName = @"其他";
            }
                break;
                
            default:
                break;
        }
        UIButton *button=(UIButton *)[self.view viewWithTag:1001];
        [button setTitle:_relationShipName forState:UIControlStateNormal];
    }
    
    
    
    
    



}

/**
 *  保存按钮的操作
 */
-(void)Parentsave{
    if (textField1.text.length == 0 || relationShip.titleLabel.text.length == 0 || textField2.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警  告" message:@"请将信息补充完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        /**
         *  开始进行网络操作
         */
        [SVProgressHUD showWithStatus:@"正在保存"];
        NSLog(@"可以进行网络操作了");
        
        if (_relationShipName.length == 0) {
            _relationShipName = [[NSUserDefaults standardUserDefaults] stringForKey:@"Relation"];
        }
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        
        
            NSDictionary *KindergartenRoom=@{@"Id":[[NSUserDefaults standardUserDefaults]valueForKey:@"ClassNameID"]};
            NSDictionary *Student=@{@"Id":[[NSUserDefaults standardUserDefaults]stringForKey:@"StudentId"]};
            [paraDic addEntriesFromDictionary:@{@"Id":[[NSUserDefaults standardUserDefaults] stringForKey:@"ParentId"],@"Code":[[NSUserDefaults standardUserDefaults] stringForKey:@"userCode"],@"Name":textField1.text,@"Address":textField2.text,@"Relation":_relationShipName,@"KindergartenRoom":KindergartenRoom,@"Student":Student}];
        
        
//            presentSave = [[commonModel alloc]initWithUrl:BASE_URL_LOGIN postpath:POST_CHANGESCHOOLANDCLASS parameters:paraDic];
//            presentSave.delegate = self;
        
    
    }



}
#pragma mark - commnModelDelegate
-(void)gotTheData:(NSDictionary *)dataDic and:(commonModel *)connect{

    //先把存的值替换掉
    [[NSUserDefaults standardUserDefaults]setValue:textField1.text forKey:@"Name"];
    [[NSUserDefaults standardUserDefaults]setValue:textField2.text forKey:@"Address"];
    if (_relationShipName) {
       [[NSUserDefaults standardUserDefaults] setValue:_relationShipName forKey:@"Relation"];
    }
    [SVProgressHUD dismissWithSuccess:@"保存成功"];
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
