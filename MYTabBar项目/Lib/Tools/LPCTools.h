//
//  LPCTools.h
//  UIGestureRecognizer
//
//  Created by 神丶宁静致远 on 15/9/1.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LPCTools : NSObject

//工厂模式
/**
    God想要创建一个Button
 */
+ (UIButton *)createButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor tag:(NSInteger)tag action:(SEL)action vc:(id)vc image:(UIImage *)imagess;

//创建标签
+ (UILabel *)createLabel:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor tag:(NSInteger)tag;

+(UIView * )View:(CGRect)frame tag:(NSUInteger)tag ;



@end