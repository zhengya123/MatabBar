//
//  tableViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/6/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "tableViewController.h"
#import "API.h"
@interface tableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger openSection;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *aArr;
@property (nonatomic, strong) NSMutableArray *bArr;
@property (nonatomic, strong) NSMutableArray *cArr;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) BOOL isDo;
@end

@implementation tableViewController
static NSString *const cellID = @"cell";
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分组";
    _isDo = NO;
    openSection = -1;
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:[NSString stringWithFormat:@"%ld", section] forState:UIControlStateNormal];
    [button addTarget:self action:sel_registerName("doOpen:") forControlEvents:UIControlEventTouchUpInside];
    button.tag = section + 1000;
    return button;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (void)doOpen:(UIButton *)sender {
    if (openSection == sender.tag - 1000) {
        _isDo = !_isDo;
        [self.tableView reloadData];
    } else {
        _isDo = NO;
        openSection = sender.tag - 1000;
        [self.tableView reloadData];
    }
    if (!_isDo) {
        self.tableView.scrollEnabled = NO; // 打开状态 不能滑动
        //[self.tableView setContentOffset:CGPointMake(0, openSection * 44 - 64) animated:YES];
    } else {
        self.tableView.scrollEnabled = YES; // 关闭状态 能够滑动
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == openSection) {
        if (_isDo) { // YES 为打开过
            return 0;
        } // 没打开过
        return [self.dataArr[openSection] count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [_dataArr[indexPath.section][indexPath.row] stringValue];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
        switch (indexPath.section) {
            case 0:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        NSLog(@"点了第一个");
                    
                    }
                        break;
                    case 1:
                    {
                        NSLog(@"点了第2个");
                    
                    }
                        break;
                    case 2:
                    {
                        NSLog(@"点了第3个");
                    
                    }
                        break;
                        
                    default:
                    {
                        NSLog(@"点了其他的了");
                    
                    }
                        break;
                }
            
            }
                break;
            case 1:
            {
                NSLog(@"点开了第二组");
            
            }
                break;
            case 2:
            {
            
                NSLog(@"点开了第三组");
            }
                break;
            default:
                break;
        }
    



}
- (NSMutableArray *)aArr {
    if (!_aArr) {
        _aArr = [NSMutableArray arrayWithObjects:@111,@222,@333,@444,@555,@666,@777, nil];
    }
    return _aArr;
}
- (NSMutableArray *)bArr {
    if (!_bArr) {
        _bArr = [NSMutableArray arrayWithObjects:@2222,@4444,@6666,@8888,@1111, nil];
    }
    return _bArr;
}
- (NSMutableArray *)cArr {
    if (!_cArr) {
        _cArr = [NSMutableArray arrayWithObjects:@33333,@55555,@77777,@99999,@11111,@22222,@33333, nil];
    }
    return _cArr;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:self.aArr,self.bArr,self.cArr, nil];
    }
    return _dataArr;
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
