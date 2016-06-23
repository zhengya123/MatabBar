//
//  OneInterFaceViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "OneInterFaceViewController.h"
#import "API.h"
#import "commonModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "OneTableViewCell.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "SDCycleScrollView.h"
#import "SecondTableViewCell.h"
#import "OtherViewController.h"
#import "ADViewController.h"
#import "UINavigationBar+Awesome.h"
#import "sanpengViewController.h"
#import "CarViewController.h"
#import "LPCTools.h"
#import "NoticeViewController.h"
#import "XTPopView.h"
#import "LookViewController.h"
#import "accountManager.h"
#import "UITableView+HeightCache.h"//动态计算tableView的高度
#import "tableViewController.h"
#define NAVBAR_CHANGE_POINT 50
@interface OneInterFaceViewController ()<
      SDCycleScrollViewDelegate,
      commonConnectDelegate,
      UITableViewDelegate,
      UITableViewDataSource,
      selectIndexPathDelegate>


@property (nonatomic, strong) UIButton *right;
@end

@implementation OneInterFaceViewController
{
    UITableView * _tableView;
    SDCycleScrollView * _scrollView;
    //UIPageControl * _pageControl;
    NSDictionary * dict;
    NSMutableArray * _arrayDS;
    NSMutableArray * _arratAD;
    NSMutableArray * imageArray;
    BOOL _isLoadMore;
    UIImageView * _imageView;
    commonModel * requestData;
    CATransition *animation;
    XTPopView *view1;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self createNAV];
    [self initData];
    //[self createplace];
    [self gotoRequest];
    [self createUI];
    
    
   
}
//判断屏幕方向
- (void)viewWillLayoutSubviews
{
    
   // [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    if (orientation == UIDeviceOrientationPortrait ||orientation ==
        UIDeviceOrientationPortraitUpsideDown) { // 竖屏
        [self createUI];
        [_tableView reloadData];
    } else { // 横屏
       // [self createUI2];
       // [_tableView reloadData];
    }
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

-(void)createNAV{

//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"首页";
    self.navigationItem.title = @"首页";
    
    _right = [UIButton buttonWithType:UIButtonTypeCustom];
    [_right setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    _right.frame = CGRectMake(0, 0, 30, 30);
    [_right addTarget:self action:@selector(erweimas:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * buIm = [[UIBarButtonItem alloc]initWithCustomView:_right];
    [self.navigationItem setRightBarButtonItem:buIm];

}
-(void)initData{
    _isLoadMore=NO;
    _arrayDS =[[NSMutableArray alloc]init];
    _arratAD=[[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];


}
-(void)createUI{
    //跳转动画
    animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];//cell分割线取消内距
    [self.view addSubview:_tableView];

    [_tableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    [_tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecondCell"];
    
    
    //滚动广告页
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 280)];
    _scrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, 280) imageURLStringsGroup:nil];
    //[_scrollView setPlaceholderImage:[UIImage imageNamed:@"3"]];
    _scrollView.infiniteLoop = YES;
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _scrollView.delegate = self;
    _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _scrollView.autoScrollTimeInterval = 3.5;
    
    [headerView addSubview:_scrollView];
    
     _tableView.tableHeaderView=headerView;
    
    //[self createplace];
    [self addHeaderMJRefresh];
    [self addFooterMJRefresh];

}
-(void)addHeaderMJRefresh{
    //下拉刷新
    
    MJRefreshNormalHeader * header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewestData)];
    _tableView.header=header;
    
    
}
-(void)addFooterMJRefresh{
    //上拉加载
    MJRefreshAutoFooter * footer=[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _tableView.footer=footer;
    
    
    
}
-(void)loadNewestData{
    _isLoadMore=NO;
    
    [self gotoRequest];
    [_arratAD removeAllObjects];
    [_arrayDS removeAllObjects];
    [imageArray removeAllObjects];
}
-(void)loadMoreData{
    _isLoadMore=YES;
    //[self gotoRequest];
    
}

-(void)gotoRequest{

    NSString * str=ONEINTERFACE_TABLEVIEW;
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self next];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];


     }
-(void)next{

   // NSLog(@"%@",dict);
    NSDictionary * dict1 = [NSDictionary new];
    NSDictionary * dict2 = [NSDictionary new];
    NSDictionary * dicAD = [NSDictionary new];
    dict1 = dict[@"result"];
    dict2=dict1[@"recommend"];
    dicAD=dict1[@"ad"];
    NSArray * array2=[[NSArray alloc]init];
    NSArray * arrayAD=[[NSArray alloc]init];
    
    array2=dict2[@"list"];
    arrayAD=dicAD[@"list"];
    for (NSDictionary * dic1 in array2) {
        
        [_arrayDS addObject:dic1];
        
        
    }
    
    for (NSDictionary * dic2 in arrayAD) {
        [_arratAD addObject:dic2];
    }
    [self addAD];
     [_tableView.header endRefreshing];
    [_tableView reloadData];


}
-(void)addAD{
    CGSize scvSize=_scrollView.bounds.size;
    for (int i=0; i<_arratAD.count; i++) {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(scvSize.width * i, 0, scvSize.width, scvSize.height)];
        
        NSString * str=[_arratAD[i]objectForKey:@"Img"];
        [imageView setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"place"]];
      
        [imageArray addObject:str];
       
    }
    _scrollView.imageURLStringsGroup =imageArray;
    NSLog(@"imageArray==%@",imageArray);
    [_imageView stopAnimating];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

-(void)erweimas:(UIButton *)button{
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
    view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfRightUp Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
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
            tableViewController * table = [[tableViewController alloc]init];
            [self.navigationController pushViewController:table animated:YES];
            
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
            LookViewController * looklook = [[LookViewController alloc]init];
            [self.navigationController pushViewController:looklook animated:YES];
            [view1 dismiss];
            
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

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        return _arrayDS.count;
    }else{
        return 1;
    
    }
    


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell setLayoutMargins:UIEdgeInsetsZero];//cell取消内距，联合对其cell的分割线
        //cell.titleImage.image = [UIImage imageNamed:@"king2"];
        
        
        
        /**
         *  下划线（标题）
         */
        cell.titleLabel.text = [_arrayDS[indexPath.row]objectForKey:@"Title"];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[_arrayDS[indexPath.row]objectForKey:@"Title"] attributes:attribtDic];
        cell.titleLabel.attributedText = attribtStr;
        
        
        /**
         *  中划线（回复）
         */
        cell.name.text = [_arrayDS [indexPath.row]objectForKey:@"Collection"];
        NSDictionary *attribtDics = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStrs = [[NSMutableAttributedString alloc]initWithString:[_arrayDS[indexPath.row]objectForKey:@"Collection"] attributes:attribtDics];
        cell.name.attributedText = attribtStrs;
        
        
        
        /**
         *  描述的文字
         */
        cell.discribe.text = [_arrayDS[indexPath.row]objectForKey:@"PreviewContent"];
        
        /**
         *  图片
         */
        [cell.titleImage setImageWithURL:[NSURL URLWithString:[_arrayDS[indexPath.row]objectForKey:@"Img"]]];
        
        return cell;
    }else{
    
        SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
        [cell.buttonone addTarget:self action:@selector(buttonone) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttontwo addTarget:self action:@selector(buttontwo) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonthree addTarget:self action:@selector(buttonthree) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonfour addTarget:self action:@selector(buttonfour) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
    }
    

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    //第二个section里面的动画
    if (indexPath.section == 1) {
     
        NSArray * array = tableView.indexPathsForVisibleRows;
        NSIndexPath * firstIndexPath = array[1];
        
        
        //设置anchorPoint
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        //为了防止cell视图移动，重新把cell放回原来的位置
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
        
        //设置cell 按照z轴旋转90度，注意是弧度
        if (firstIndexPath.row < indexPath.row) {
            cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
        }else{
            cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
        }
        
        cell.alpha = 0.0;
        
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1.0;
        }];
  
    }
    



}
-(void)buttonone{
    NSLog(@"议价交易");
//    OtherViewController * other = [[OtherViewController alloc]init];
//    other.titles = @"议价交易";
//    [self.navigationController pushViewController:other animated:YES];
    sanpengViewController * sanpeng = [sanpengViewController new];
    [self.navigationController pushViewController:sanpeng animated:YES];

}
-(void)buttontwo{
     NSLog(@"竞价交易");
    animation.type = @"rippleEffect";//滴水效果
    animation.subtype = kCATransitionFromTop;
    CarViewController * carVC = [CarViewController new];
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentModalViewController:carVC animated:YES];
   
}
-(void)buttonthree{
     NSLog(@"闪拍交易");
    accountManager * other = [[accountManager alloc]init];
    //other.titles = @"闪拍交易";
    [self.navigationController pushViewController:other animated:YES];
}
-(void)buttonfour{
     NSLog(@"拍品公告");
    NoticeViewController * noticeVC = [[NoticeViewController alloc]init];
    [self.navigationController pushViewController:noticeVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        //return 105;
        
        return [tableView DW_CalculateCellWithIdentifier:@"Cell" indexPath:indexPath configuration:^(OneTableViewCell * cell) {
            cell.titleLabel.text = [_arrayDS[indexPath.row]objectForKey:@"Title"];//一定要在返回高度时将内容注入，否则返回高度无效
            cell.name.text = [_arrayDS [indexPath.row]objectForKey:@"Collection"];
            cell.discribe.text = [_arrayDS[indexPath.row]objectForKey:@"PreviewContent"];
           // [cell.titleImage setImageWithURL:[NSURL URLWithString:[_arrayDS[indexPath.row]objectForKey:@"Img"]]];
        }];

    }else{
       // OneTableViewCell * cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return 88 * PROPORTION_HEIGHT;
        //return cell.frame.size.height;
    }
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 1) {
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
        DetailViewController * detail = [[DetailViewController alloc]init];
        detail.TopicId = [_arrayDS[indexPath.row] objectForKey:@"TopicId"];
        
        [self.navigationController pushViewController:detail animated:YES];
    }else{
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
//        OtherViewController * other = [[OtherViewController alloc]init];
//        [self.navigationController pushViewController:other animated:YES];
    }
    

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"%ld",index);
    NSString * str = [NSString stringWithFormat:@"点击的是第%ld页",index +1];
    UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
//    ADViewController * ad = [[ADViewController alloc]init];
//    ad.adlianjie = imageArray[index];
//    [self.navigationController pushViewController:ad animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [view1 dismiss];
   // [self.navigationController.navigationBar lt_reset];
}
-(void)viewDidDisappear:(BOOL)animated{

   // [imageArray removeAllObjects];

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
