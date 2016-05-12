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

/**
 * 封装View动画，点击向下慢慢滑出
 */
+(UIView * )View:(CGRect)frame tag:(NSUInteger)tag {

    UIView *  View = [[UIView alloc]initWithFrame:frame];
    View.backgroundColor = [UIColor redColor];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-40, 5, 40, 40);
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickssss:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    [View addSubview:button];
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width-50, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"账号与密码相同:0";
    label.textColor = [UIColor blackColor];
    [View addSubview:label];
    
    return View;

}
-(void)clickssss:(UIButton *)button{
    if (button.tag == 111) {
         NSLog(@"点击了View的X号");
        
    }
   

}
/**
 *  封装View动画
 */

+(UIView *)View:(UIView * )view UIVieAnimation:(NSInteger )time number:(NSInteger)number{

    [UIView beginAnimations:@"newAnimation" context:nil];
    //设置动画的持续时间
    [UIView setAnimationDuration:time];
    //如果设置为YES,代表动画每次重复执行的效果会跟上一次相反
    [UIView setAnimationRepeatAutoreverses:YES];
    //设置动画的运动曲线（线性、先快后慢、先慢后快）
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    UIViewAnimationCurveEaseInOut,         // slow at beginning and end
//    UIViewAnimationCurveEaseIn,            // slow at beginning
//    UIViewAnimationCurveEaseOut,           // slow at end
//    UIViewAnimationCurveLinear
    //动画的重复次数
    [UIView setAnimationRepeatCount:number];
    
    //动画动作定义
    CGRect tmp = view.frame;
    tmp.origin.x += [UIScreen mainScreen].bounds.size.width - view.frame.size.width;
    view.frame = tmp;
    
    //提交动画
    [UIView commitAnimations];
    return view;
}

@end
