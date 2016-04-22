//
//  sanpengViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/4/22.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "sanpengViewController.h"
#import "API.h"
#import "commonModel.h"
#import "SDCycleScrollView.h"
#import "CarCollectionViewCell.h"
@interface sanpengViewController ()<
commonConnectDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@end

@implementation sanpengViewController
{

    UIView * navBaseView;
    commonModel * requestData;
     UICollectionView *_collectionView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NAV];
    [self createUI];
    [self request];
    // Do any additional setup after loading the view from its nib.
}
-(void)request{
    NSDictionary * partment = @{@"seriesId":@107};
    requestData = [[commonModel alloc]initWithUrl:FENGHUANG_BASE getPath:FENGHUANG_GETBUTCAR parameters:partment];
    requestData.delegate = self;
    



}
-(void)gotTheData:(NSDictionary *)dataDic and:(commonModel *)connect{
   // NSLog(@"%@",dataDic);

}
-(void)gotTheErrorMessage:(NSString *)errorMessage and:(commonModel *)connect{

    NSLog(@"%@",errorMessage);
}
-(void)connectError:(commonModel *)connect{




}
-(void)NAV{

    
    //segnment添加的View
    navBaseView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/4, 0, SCREEN_W/2, 40)];
    navBaseView.backgroundColor = [UIColor yellowColor];
    self.navigationItem.titleView = navBaseView;

    //segment
    NSArray * segarray = @[@"隐藏相同",@"显示全部"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"SnellRoundhand-Bold" size:17 * PROPORTION],NSFontAttributeName ,nil];
    UISegmentedControl * segnment = [[UISegmentedControl alloc]initWithItems:segarray];
    segnment.frame = CGRectMake(0, 0, navBaseView.frame.size.width, navBaseView.frame.size.height);
    segnment.selectedSegmentIndex = 0;
    [segnment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segnment addTarget:self action:@selector(segnmentClick:) forControlEvents:UIControlEventValueChanged];
    [navBaseView addSubview:segnment];

}
-(void)createUI{

    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout  *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置集合视图滚动的方向
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置cell横向最小间隔
    flow.minimumLineSpacing = 20 * PROPORTION;
    //设置cell纵向最小间隔
    flow.minimumInteritemSpacing =0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_W/4 - 25 * PROPORTION,25, (SCREEN_W-(SCREEN_W/4-25))*PROPORTION ,self.titleBaseView.frame.size.height - 50) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [self.titleBaseView addSubview:_collectionView];


    [_collectionView registerNib:[UINib nibWithNibName:@"CarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];


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
    CarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    
    cell.titless.text = @"1.6L 手动时尚型";
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
#pragma mark - delegate
//选中某一个Item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected item:%d",indexPath.item);
    
    
}
#pragma mark - layout delegate
//在集合视图中，每一个cell叫做item
//设置每个cell(item)的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(152,130);
}
//描述的是所有cell最外边组成的视图与collectionView上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10,10, 10, 30);
}

-(void)segnmentClick:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
        
            NSLog(@"隐藏相同");
        }
            break;
            case 1:
        {
        
            NSLog(@"显示全部");
        }
            break;
            
        default:
            break;
    }



}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    [navBaseView removeFromSuperview];
//}
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
