//
//  BadgeView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  购物车脚标视图

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

@property (strong, nonatomic) NSString  *badgeValue;
//@property (strong, nonatomic) UIColor   *textColor;
@property (strong, nonatomic) UILabel   *textLabel;

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com