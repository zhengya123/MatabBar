//
//  DescripeViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/18.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "DescripeViewController.h"
#import "LPCTools.h"
#import "API.h"
#import "DecripeCollectionViewCell.h"
#import "DescripeDetailViewController.h"
@interface DescripeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation DescripeViewController
{

    NSString * str1;
    NSString * str2;
    NSString * str3;
    NSArray * arrayCollecView;
    UIView * Views;
    UICollectionView *_collectionView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    self.BaseViews.hidden = YES;
    self.descripeBaseView.hidden = YES;
    [self createUI];//资料
    [self createdescripe];//描述
    [self createBaseView];
    // Do any additional setup after loading the view from its nib.
}
-(void)createData{
    
    
    str1 = @"您可以在资料中上传你的诊疗结果和各种检查单据，请您务必提交清晰的图片用于医患双方进行查看。";
    
    str2 = @"目前可传分类为化验单、心电图、影像、造影、入院报告、出院报告、诊断证明、其他。";
    
    str3 = @"每个分类可以同时上传多张图片。";
    
    arrayCollecView = @[@"本人",@"心电图",@"医生",@"诊断证明",@"公开",@"造影",@"隐藏",@"化验单",@"入院报告",@"影像",@"出院报告",@"其他",@"备注"];
    
}
//底层界面
-(void)createBaseView{
    Views = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_W, 50)];
    Views.layer.cornerRadius = 25;
    [self.view addSubview:Views];
   // [Views addSubview:[LPCTools createButton:CGRectMake(0, 0, SCREEN_W/2, 50) bgColor:[UIColor whiteColor] title:@"资料" titleColor:[UIColor redColor] tag:111 action:@selector(informations) vc:nil ]];
    //[Views addSubview:[LPCTools createButton:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, 50) bgColor:[UIColor redColor] title:@"描述" titleColor:[UIColor whiteColor] tag:112 action:@selector(decripes) vc:nil]];
    [Views addSubview:[LPCTools createButton:CGRectMake(0, 0, SCREEN_W/2, 50) bgColor:[UIColor whiteColor] title:@"资料" titleColor:[UIColor redColor] tag:111 action:@selector(informations) vc:nil image:[UIImage imageNamed:@"ziliao"]]];
    [Views addSubview:[LPCTools createButton:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, 50) bgColor:[UIColor whiteColor] title:@"描述" titleColor:[UIColor redColor] tag:112 action:@selector(decripes) vc:nil image:[UIImage imageNamed:@"miaoshu"]]];


}
//资料按钮点击
-(void)informations{

    [UIView animateWithDuration:0.3f animations:^{
        self.BaseViews.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.BaseViews.alpha = 0.8f;
    } completion:^(BOOL finished) {
        self.BaseViews.hidden = NO;
        Views.hidden = YES;
    }];

   
    
    

}
//描述按钮点击
-(void)decripes{
    [UIView animateWithDuration:0.3f animations:^{
        self.descripeBaseView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.descripeBaseView.alpha = 0.8f;
    } completion:^(BOOL finished) {
        self.descripeBaseView.hidden = NO;
        Views.hidden = YES;
    }];


}
//资料界面
-(void)createUI{

    
    self.information1.text = str1;
    self.information2.text = str2;
    self.information3.text = str3;
    UIView * colorV = [[UIView alloc]init];
    colorV.frame = CGRectMake(PROPORTION * 13, self.information.frame.origin.y + 50, SCREEN_W-2 * 13 * PROPORTION, 2);
    colorV.backgroundColor = [UIColor whiteColor];
    [self.BaseViews addSubview:colorV];
    
    UIButton * ziliao = [UIButton buttonWithType:UIButtonTypeCustom];
    ziliao.frame = CGRectMake(SCREEN_W/2-25, SCREEN_H - 100, 50, 50);
    [ziliao setTitle:@"X" forState:UIControlStateNormal];
    ziliao.titleLabel.font = [UIFont systemFontOfSize:30];
    [ziliao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ziliao setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [ziliao setBackgroundColor:[UIColor whiteColor]];
    
    ziliao.layer.cornerRadius = 25;
    [ziliao addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [self.BaseViews addSubview:ziliao];

}
//描述界面
-(void)createdescripe{

    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout  *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置集合视图滚动的方向
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置cell横向最小间隔
    flow.minimumLineSpacing = 0;
    //设置cell纵向最小间隔
    flow.minimumInteritemSpacing =0;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,122, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.descripeBaseView addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DecripeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    UIButton * ziliao = [UIButton buttonWithType:UIButtonTypeCustom];
    ziliao.frame = CGRectMake(SCREEN_W/2-25, SCREEN_H - 100, 50, 50);
    [ziliao setTitle:@"X" forState:UIControlStateNormal];
    ziliao.titleLabel.font = [UIFont systemFontOfSize:30];
    [ziliao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ziliao setBackgroundColor:[UIColor whiteColor]];
    ziliao.layer.cornerRadius = 25;
    [ziliao addTarget:self action:@selector(miaoshu) forControlEvents:UIControlEventTouchUpInside];
    [self.descripeBaseView addSubview:ziliao];

}
//资料界面X
- (void)button {
    [UIView animateWithDuration:0.3f animations:^{
        self.BaseViews.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.BaseViews.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.BaseViews.hidden = YES;
        Views.hidden = NO;
    }];
    

    
}
//描述界面X
-(void)miaoshu {
    [UIView animateWithDuration:0.3f animations:^{
        self.descripeBaseView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.descripeBaseView.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.descripeBaseView.hidden = YES;
        Views.hidden = NO;
    }];
    
    
}
#pragma mark - dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 13;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //要与注册时、xib中填写的值一致
    static NSString *cellIde = @"cell";
    //如果从重用队列中取不到cell对象,集合视图会根据注册的信息自动创建cell
    DecripeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    cell.headImage.image = [UIImage imageNamed:@"二维码"];
    cell.titleLabels.text = arrayCollecView[indexPath.row];
    return cell;
}
#pragma mark - delegate
//选中某一个Item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected item:%d",indexPath.item);
    DescripeDetailViewController *DesVC = [[DescripeDetailViewController alloc]init];
    DesVC.titleName = arrayCollecView[indexPath.row];
    [self.navigationController pushViewController:DesVC animated:YES];
    
}
#pragma mark - layout delegate
//在集合视图中，每一个cell叫做item
//设置每个cell(item)的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_W/3,39);
}
//描述的是所有cell最外边组成的视图与collectionView上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(30,30, 20, 30);
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
