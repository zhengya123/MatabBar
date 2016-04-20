//
//  ZYTabBarButton.h
//  Application
//
//  Created by MS on 15-10-13.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTabBarButton : UIView

/**
 这个是自定义的TabBar上得按钮,可以定义选中图片,非选中的图片和标题
 */

@property (nonatomic, retain) UIImage * unselectedImage;
@property (nonatomic, retain) UIImage * selectedImage;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) BOOL selected;

/**
 按钮的初始化方法
 */
- (id)initWithFrame:(CGRect)frame unselectedImage:(UIImage *)unselectedImage selectedImage:(UIImage *)selectedImage title:(NSString *)title;

/**
 给按钮添加点击事件
 */
- (void)setClickEventTarget:(id)target action:(SEL)action;
@end
