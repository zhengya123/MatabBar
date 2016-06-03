//
//  NoticeViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/5/6.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "Masonry.h"
#import "API.h"
@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@end

@implementation NoticeViewController
{

    
    UITableView * _tableView;
    NSArray * array;
    UISearchBar * searchBar;



}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    searchController.active = true;
//
//
//
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createData];
    [self createNAV];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  假数据模拟高度
 */
-(void)createData{
    
    NSString * str1 = @"我是 是四核四his导航v随地hi和DVI和vvvvvvvvvvvvvvvvvvvvvvvvvv";
    NSString * str2 = @"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111”";
    NSString * str3 = @"我曾经遇见过一个学员，他本人在一家银行上班，工作也相当稳定，可他就是非常喜欢会计这个专业，于是这种人具有很强表现出强烈的自发主动性，不仅复习而且预习，用他的话说，在热爱的事情上面，根本无需计较，学习会计对他而言就是一种莫大的放松与享受。我曾经遇见过一个学员，他本人在一家银行上班，工作也相当稳定，可他就是非常喜欢会计这个专业，于是这种人具有很强表现出强烈的自发主动性，不仅复习而且预习，用他的话说，在热爱的事情上面，根本无需计较，学习会计对他而言就是一种莫大的放松与享受。我曾经遇见过一个学员，他本人在一家银行上班，工作也相当稳定，可他就是非常喜欢会计这个专业，于是这种人具有很强表现出强烈的自发主动性，不仅复习而且预习，用他的话说，在热爱的事情上面，根本无需计较，学习会计对他而言就是一种莫大的放松与享受。";
  NSString * str4 = @"商业社会最大的便利就是专业的人做专业的事，只要你想学，并且你肯投资你自己，你就能找到专业的老师指点，胜过你自己苦苦摸索，从投资回报的角度来看，这种成长其实是最快的。";
    array = @[str1,str2,str3,str4];
    [_tableView reloadData];

}
/**
 *  导航栏搜索框
 */
-(void)createNAV{

    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(50, 20, SCREEN_W-100, 30)];
    titleview.backgroundColor = [UIColor whiteColor];
    
    searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, SCREEN_W-100, 30);
    searchBar.backgroundColor = [UIColor yellowColor];
    searchBar.keyboardType = UIReturnKeyDefault;
    searchBar.placeholder = @"请输入、、、";
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    [titleview addSubview:searchBar];
    
    self.navigationItem.titleView = titleview;




}
-(void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@69);
//        make.left.and.right.equalTo(@0);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.height.equalTo(self.view.mas_height);
//    }];
    [_tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableCell"];
    





}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return array.count;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NoticeTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"tableCell"];

    NSString * str = array[indexPath.row];
    cell.label.text = str;
    cell.label.numberOfLines = 0;
    cell.label.font = [UIFont systemFontOfSize:17];

    return cell;



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

    CGFloat contentWidth = self.view.frame.size.width;
    UIFont *font = [UIFont systemFontOfSize:17];
    NSString *content = [array objectAtIndex:[indexPath row]];
     CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 5000.0f) lineBreakMode:NSLineBreakByWordWrapping];

    NSLog(@"%f",size.height);
    return size.height +30 ;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第二个section里面的动画
    
        
        NSArray * array = tableView.indexPathsForVisibleRows;
        NSIndexPath * firstIndexPath = array[0];
        
        
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

#pragma mark - SearchBarDelegate
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//
//    [searchBar resignFirstResponder];
//
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [searchBar resignFirstResponder];

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
