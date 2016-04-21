//
//  OrderDetailListView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  购物车订单详情列表

#import <UIKit/UIKit.h>

@class ShopCartView;

@interface OrderDetailListView : UIView

/** 订单详情列表 */
@property (strong, nonatomic) UITableView *listTableView;

/** 订单对象 */
@property (strong, nonatomic) NSMutableArray *objects;

@property (strong, nonatomic) ShopCartView *shopCartView;

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com