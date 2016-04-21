//
//  GoodsModel.m
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "GoodsModel.h"
#import "MJExtension.h"

@implementation GoodsModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"goodsID"             : @"id",
             @"goodsIcon"           : @"icon",
             @"goodsName"           : @"name",
             @"goodsOriginalPrice"  : @"originalPrice",
             @"goodsSalePrice"      : @"salePrice",
             @"goodsStock"          : @"stock",
             @"goodsDesc"           : @"desc",
             @"orderCount"          : @"orderCount"
             };
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com