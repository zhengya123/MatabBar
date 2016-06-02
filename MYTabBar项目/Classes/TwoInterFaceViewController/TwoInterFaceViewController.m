//
//  TwoInterFaceViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "TwoInterFaceViewController.h"
#import "MySecondTableViewCell.h"
#import "MyFirst1TableViewCell.h"
#import "MyThreeTableViewCell.h"
#import "API.h"
#import "TwoInterDetailViewController.h"
#import "VideoViewController.h"
#import "DescripeViewController.h"
#import "ZXShopCartViewController.h"
#import "HFStretchableTableHeaderView.h"
#import "XTPopView.h"
@interface TwoInterFaceViewController ()<UITableViewDataSource,UITableViewDelegate,selectIndexPathDelegate>
@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic, strong) UIButton *right;
@end

@implementation TwoInterFaceViewController
{

    UITableView * _tableView;
    UIImageView * BaseV;
    NSArray * arrayLabeltext;
    NSArray * arrayTitles;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self createData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createData{

    arrayLabeltext = @[@"咨询*会议",@"视频中心",@"技术邦",@"驻地手术指导",@"学术会议",@"人工关节登记"];
    arrayTitles = @[@"技术邦精选",@"老教授信息"];

}
-(void)createUI{
    self.navigationItem.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton * left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setImage:[UIImage imageNamed:@"Bargainingdeal@3x"] forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 30, 30);
    [left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * buImleft = [[UIBarButtonItem alloc]initWithCustomView:left];
    [self.navigationItem setLeftBarButtonItem:buImleft];
   
    _right = [UIButton buttonWithType:UIButtonTypeCustom];
    [_right setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    _right.frame = CGRectMake(0, 0, 30, 30);
    [_right addTarget:self action:@selector(erweima:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * buIm = [[UIBarButtonItem alloc]initWithCustomView:_right];
    [self.navigationItem setRightBarButtonItem:buIm];
    
    
   
    
    BaseV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 249)];
    BaseV.image = [UIImage imageNamed:@"banner"];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MySecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"nameCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"MyFirst1TableViewCell" bundle:nil] forCellReuseIdentifier:@"firstnameCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyThreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"threenameCell"];
    //_tableView.tableHeaderView = BaseV;
    [self.view addSubview:_tableView];
    
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:_tableView withView:BaseV subViews:self.view];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }else{
    
        return 1;
    }
   

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        MyFirst1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"firstnameCell"];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.zixun addTarget:self action:@selector(zixunhuizhen) forControlEvents:UIControlEventTouchUpInside];
        [cell.shipin addTarget:self action:@selector(shipinzhongxin) forControlEvents:UIControlEventTouchUpInside];
        [cell.jishubang addTarget:self action:@selector(jishubangzhongxin) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhudishoushu addTarget:self action:@selector(zhudishoushizhidao) forControlEvents:UIControlEventTouchUpInside];
        [cell.huiyi addTarget:self action:@selector(xueshuhuiyi) forControlEvents:UIControlEventTouchUpInside];
        [cell.rengongdengji addTarget:self action:@selector(rengongguanjiedengji) forControlEvents:UIControlEventTouchUpInside];
        cell.Labelzixun.text = arrayLabeltext[0];
        cell.labelshipin.text = arrayLabeltext[1];
        cell.labeljishu.text = arrayLabeltext[2];
        cell.labelzhudi.text = arrayLabeltext[3];
        cell.labelxueshu.text = arrayLabeltext[4];
        cell.labelrengong.text = arrayLabeltext[5];
        return cell;
        

    }else if(indexPath.section == 1){
        MySecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
    
    
        MyThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"threenameCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    
    }
    
    


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200  ;
    }else if(indexPath.section ==1){
    
        return 111 * PROPORTION;
    }else{
    
        return 184 * PROPORTION;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    if(section == 0){
    
    
    }else{
       
        headView.backgroundColor = [UIColor whiteColor];
        
        UIView * colorView = [[UIView alloc]initWithFrame:CGRectMake(15, 5, 3, 40)];
        [colorView setBackgroundColor:[UIColor greenColor]];
        [headView addSubview:colorView];
        
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width / 2, 40)];
        NSLog(@"%ld",section);
        nameLabel.text = arrayTitles[section-1];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor blackColor];
        
        nameLabel.font = [UIFont systemFontOfSize:26.0];
        [headView addSubview:nameLabel];
        
        
        UIButton * next = [UIButton buttonWithType:UIButtonTypeCustom];
        next.frame = CGRectMake(SCREEN_W-25, 10, 16, 25);
        [next setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [headView addSubview:next];

    
        
    }
   //    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, 0, self.view.frame.size.width / 3, 30)];
//    priceLabel.text = @"最新价";
//    priceLabel.textAlignment = NSTextAlignmentCenter;
//    priceLabel.textColor = [UIColor whiteColor];
//    priceLabel.font = [UIFont boldSystemFontOfSize:15.0];
//    
//    UILabel *precentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3 * 2, 0, self.view.frame.size.width / 3, 30)];
//    precentLabel.text = @"这是个一头";
//    precentLabel.textAlignment = NSTextAlignmentCenter;
//    precentLabel.textColor = [UIColor whiteColor];
//    precentLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    
//    [headView addSubview:priceLabel];
//    [headView addSubview:precentLabel];
    return headView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
    
        return 10;
    }else{
    return 50;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)left:(UIButton *)button{
    NSLog(@"左侧点击了");


}
-(void)erweima:(UIButton *)button{
    NSLog(@"二维码点击了");
    
    /**
     XTTypeOfUpLeft,     // 上左
     XTTypeOfUpCenter,   // 上中
     XTTypeOfUpRight,    // 上右
     
     XTTypeOfDownLeft,   // 下左
     XTTypeOfDownCenter, // 下中
     XTTypeOfDownRight,  // 下右
     
     XTTypeOfLeftUp,     // 左上
     XTTypeOfLeftCenter, // 左中
     XTTypeOfLeftDown,   // 左下
     
     XTTypeOfRightUp,    // 右上
     XTTypeOfRightCenter,// 右中
     XTTypeOfRightDown,  // 右下
     */
    CGPoint point = CGPointMake(_right.center.x,_right.frame.origin.y + 64);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfUpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
    view1.dataArray = @[@"发起群聊",@"添加朋友", @"扫一扫", @"收付款"];
    view1.images = @[@"发起群聊",@"添加朋友", @"扫一扫", @"付款"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor whiteColor];
    view1.delegate = self;
    [view1 popView];




}

- (void)selectIndexPathRow:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"Click 0 ......");
        }
            break;
        case 1:
        {
            NSLog(@"Clikc 1 ......");
        }
            break;
        case 2:
        {
            NSLog(@"Clikc 2 ......");
        }
            break;
        case 3:
        {
            NSLog(@"Clikc 3 ......");
        }
            break;
        default:
            break;
    }
}

- (void)zixunhuizhen{
   
//    TwoInterDetailViewController * twoDetail = [[TwoInterDetailViewController alloc]init];
//   twoDetail.titleName = arrayLabeltext[0];
//    NSLog(@"%@",arrayLabeltext[0]);
//    [self.navigationController pushViewController:twoDetail animated:YES];
    ZXShopCartViewController * shop = [[ZXShopCartViewController alloc]init];
    //self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:shop animated:YES];
}
-(void)shipinzhongxin{

    
    VideoViewController * videoVC = [[VideoViewController alloc]init];
    videoVC.titleName = arrayLabeltext[1];
    [self.navigationController pushViewController:videoVC animated:YES];
}
-(void)jishubangzhongxin{
    
    TwoInterDetailViewController * twoDetail = [[TwoInterDetailViewController alloc]init];
    twoDetail.titleName = arrayLabeltext[2];
    [self.navigationController pushViewController:twoDetail animated:YES];


}
-(void)zhudishoushizhidao{
    
//    TwoInterDetailViewController * twoDetail = [[TwoInterDetailViewController alloc]init];
//    twoDetail.titleName = arrayLabeltext[3];
//    
//    [self.navigationController pushViewController:twoDetail animated:YES];

    DescripeViewController * DP = [[DescripeViewController alloc]init];
    [self.navigationController pushViewController:DP animated:YES];
}
-(void)xueshuhuiyi{
    TwoInterDetailViewController * twoDetail = [[TwoInterDetailViewController alloc]init];
    twoDetail.titleName = arrayLabeltext[4];
    [self.navigationController pushViewController:twoDetail animated:YES];


}
-(void)rengongguanjiedengji{
    
    TwoInterDetailViewController * twoDetail = [[TwoInterDetailViewController alloc]init];
    twoDetail.titleName = arrayLabeltext[5];
    [self.navigationController pushViewController:twoDetail animated:YES];


}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     *  方案一
     */
//    CGFloat y = scrollView.contentOffset.y;//如果有导航栏，则应该加上导航栏的高度
//    if(y < 180){
//        CGRect frame = BaseV.frame;
//        frame.origin.y = y;
//        frame.size.height = -y;
//        BaseV.frame = frame;
//    
//    
//    
//    }

    /**
     *  方案二
     */
    
    
    CGFloat width = self.view.frame.size.width; // 图片宽度
    
    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值
    
    if (yOffset < 0) {
        
        CGFloat totalOffset = 249 + ABS(yOffset);
        BaseV.frame =CGRectMake(0, yOffset, width, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        
    }
    NSLog(@"偏移量==%f",yOffset);
    /**
     * 方案三
     */
    
      //  [self.stretchHeaderView scrollViewDidScroll:scrollView];
  
    /**
     * 方案四
     */


}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
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
