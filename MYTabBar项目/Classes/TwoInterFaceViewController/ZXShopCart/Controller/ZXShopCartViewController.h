//
//  ZXShopCartViewController.h
//  ZXShopCart
//
//  Created by Xiang on 16/2/2.
//  Copyright © 2016年 周想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWOBASEViewController.h"
@interface ZXShopCartViewController : TWOBASEViewController

/** 订单数据 */
@property (nonatomic, strong) NSMutableArray *orderArray;

/** 订单所选总数量 */
@property (nonatomic, assign) NSInteger totalOrderCount;

/** 订单总价 */
@property (assign, nonatomic) double totalPrice;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com