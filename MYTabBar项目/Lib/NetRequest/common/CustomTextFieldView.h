//
//  CustomTextFieldView.h
//  foodsecurity
//
//  Created by fuyang on 15/4/15.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextFieldView : UIView
@property(nonatomic,strong)UITextField *textField;

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;
@end
