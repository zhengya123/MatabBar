//
//  LPCTools.m
//  UIGestureRecognizer
//
//  Created by 神丶宁静致远 on 15/9/1.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "LPCTools.h"

@implementation LPCTools

//工厂模式
//创建按钮
+ (UIButton *)createButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor tag:(NSInteger)tag action:(SEL)action vc:(id)vc image:(UIImage *)imagess
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = bgColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:imagess forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//创建标签
+ (UILabel *)createLabel:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor tag:(NSInteger)tag
{
    UILabel * label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.tag = tag;
    
    return label ;
}


+(UIView * )View:(CGRect)frame {

    UIView *  View = [[UIView alloc]initWithFrame:frame];
    View.backgroundColor = [UIColor redColor];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-40, 5, 40, 40);
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
   // [button addTarget:self action:@selector(clickssss) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:button];
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width-50, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"账号与密码相同";
    label.textColor = [UIColor blackColor];
    [View addSubview:label];
    
    return View;

}
//View上面的X的点击事件


@end
