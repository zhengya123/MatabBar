//
//  ShopCartView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/27.
//  Copyright © 2016年 周想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOutView.h"
#import "OrderDetailListView.h"
#import "BadgeView.h"

@interface ShopCartView : UIView

/** 购物车按钮 */
@property (strong, nonatomic)  UIButton *shopCartBtn;

/** 总价Label */
@property (strong, nonatomic)  UILabel *totalPriceLabel;

/** 结算按钮 */
@property (strong, nonatomic)  UIButton *payButton;

/** 分割线 */
@property (strong, nonatomic)  UILabel *line;

/** 父视图 */
@property (strong, nonatomic) UIView *parentView;

/** 订单数组 */
@property (strong, nonatomic) NSMutableArray *orderArray;

/** 弹出列表背景视图 */
@property (strong, nonatomic) PopOutView *popOutView;

/** 购物车详情列表视图 */
@property (strong, nonatomic) OrderDetailListView *detailListView;

/** 购物车角标视图 */
@property (strong, nonatomic) BadgeView *badgeView;

/** 总价 */
@property (assign, nonatomic) double inTotal;

/** 是否打开详情 */
@property (assign, nonatomic) BOOL is_open;

/** 购物车标记值 */
@property (assign, nonatomic) NSInteger badgeValue;

- (instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView;

-(void)dismissAnimated:(BOOL)animated;

-(void)setTotalPrice:(double)inTotal;

-(void)updateFrame:(UIView *)view;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com