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
#import "Masonry.h"
#import "tableTableViewCell.h"
@interface sanpengViewController ()<
commonConnectDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate>

//@property(nonatomic,strong)UIView *titleBaseView;
@end

@implementation sanpengViewController
{

    UIView * navBaseView;
    commonModel * requestData;
    UICollectionView *_collectionView;
    UIView *BaseView;
    UITableView * _tableView;
    NSMutableArray * paramitems;
    NSMutableArray * valueitems;
    NSMutableArray * arrays;
    NSArray * laji;
    UILongPressGestureRecognizer* longPress;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NAV];
    [self createData];
    [self createUI];
   // [self request];
    // Do any additional setup after loading the view from its nib.
}
-(void)createData{

    paramitems = [[NSMutableArray alloc]init];
    valueitems = [[NSMutableArray alloc]init];
    arrays = [[NSMutableArray alloc]init];
    laji = @[@"1.1L手动挡",@"1.2L手动挡",@"1.3L手动挡",@"1.4L手动挡",@"1.5L手动挡",@"1.6L手动挡",@"1.7L手动挡",@"1.8L手动挡",@"1.9L手动挡",@"2.0L手动挡",@"2.1L手动挡",@"2.2L手动挡",@"2.3L手动挡"];

}
-(void)request{
    NSDictionary * partment = @{@"seriesId":@107};
    requestData = [[commonModel alloc]initWithUrl:FENGHUANG_BASE getPath:FENGHUANG_GETBUTCAR parameters:partment];
    requestData.delegate = self;
    

   

}
-(void)gotTheData:(NSArray *)dataDic and:(commonModel *)connect{
   // NSLog(@"%@",dataDic);
//    NSDictionary * dic = dataDic[0] ;
//    NSLog(@"%@",dic);
    
//    NSArray * array = [[dataDic[0] objectForKey:@"result"] objectForKey:@"paramtypeitems"];
//    NSDictionary * dict = [[NSDictionary alloc]init];
//    
//    for ( dict in array) {
//        
//        [paramitems addObject:[dict objectForKey:@"paramitems"]];
//        
//        NSDictionary * dict2 = [[NSDictionary alloc]init];
//       // NSMutableArray * arra = [[NSMutableArray alloc]init];
//        for (dict2 in paramitems) {
//            
//            [arrays addObject:dict2];
//            NSLog(@"%@",arrays[0]);
//             NSLog(@"== %@",[array[0] objectForKey:@"valueitems"]);
//            [valueitems addObject:[array[0] objectForKey:@"id"]];
//            
//        }
//    }
//   
//    NSLog(@"collectionView == %@",paramitems);
//    [_collectionView reloadData];
    

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

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@69);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@(SCREEN_H-69));
       // make.centerX.equalTo(self.view.mas_centerX);
       // make.centerY.equalTo(self.view.mas_centerY);
    }];

     [_tableView registerNib:[UINib nibWithNibName:@"tableTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cells"];
    
    
    BaseView = [UIView new];
    BaseView.backgroundColor = [UIColor greenColor];
    _tableView.tableHeaderView = BaseView;
    [BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(SCREEN_W));
        make.height.equalTo(@100);
    }];
    
    
    UILabel * label = [UILabel new];
    label.text = @"车型";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [BaseView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.left.equalTo(@10);
        make.width.equalTo(@(SCREEN_W/6));
        make.height.equalTo(@20);
    } ];
    
    UILabel * label2 = [UILabel new];
    label2.text = @"配置表";
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [BaseView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5);
        make.centerX.equalTo(label.mas_centerX);
        make.left.and.right.equalTo(label);
    } ];
    
    
   
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout  *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing =0;
   
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    
    //_collectionView = [[UICollectionView alloc]init];
    //_collectionView.collectionViewLayout= flow;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [BaseView addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(@10);
    make.left.equalTo(label2.mas_right).offset(10);
    make.width.equalTo(@((SCREEN_W/6) * 5-10));
    make.height.equalTo(@80);
}];

    [_collectionView registerNib:[UINib nibWithNibName:@"CarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    
    
   
    

}

#pragma mark - DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
    
    
        
        return 50;
    }



}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    tableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cells" forIndexPath:indexPath];
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPresss:)];
    [cell addGestureRecognizer:longPress];
    return cell;

}
- (void)longPresss:(UILongPressGestureRecognizer*)longPress{
    NSLog(@"长按了cell");
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"改变背景颜色" delegate:self cancelButtonTitle:@"保持原样" destructiveButtonTitle:@"取消" otherButtonTitles:@"变为红色",@"变为蓝色",@"变为紫色", nil];
    /*
     UIActionSheetStyleAutomatic        = -1,       // take appearance from toolbar style otherwise uses 'default'
     UIActionSheetStyleDefault          = UIBarStyleDefault,
     UIActionSheetStyleBlackTranslucent = UIBarStyleBlackTranslucent,
     UIActionSheetStyleBlackOpaque
     
     */
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    //提示框不需要设置显示位置和大小 在底部
    [sheet showInView:self.view];


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
    cell.titless.text = laji[indexPath.row];
    cell.titless.font = [UIFont systemFontOfSize:14];
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
    return CGSizeMake((_collectionView.frame.size.width)/2-20,80);
}
//描述的是所有cell最外边组成的视图与collectionView上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10,10, 10, 10);
}
//collection动画
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row % 2 != 0) {
        cell.transform = CGAffineTransformTranslate(cell.transform, SCREEN_W/2, 0);
    }else{
        cell.transform = CGAffineTransformTranslate(cell.transform, -SCREEN_W/2, 0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];







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
