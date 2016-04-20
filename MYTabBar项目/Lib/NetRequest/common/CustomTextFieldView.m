//
//  CustomTextFieldView.m
//  foodsecurity
//
//  Created by fuyang on 15/4/15.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "CustomTextFieldView.h"

@implementation CustomTextFieldView

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        [self createContent:placeholder];
    }
    return self;
}

-(void)createContent:(NSString *)placeholder
{
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=1;
    self.layer.cornerRadius=5;
    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-50, self.frame.size.height-20)];
    self.textField.placeholder=placeholder;
    self.textField.secureTextEntry=YES;
    [self addSubview:self.textField];
    
    UIButton *isSecureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    isSecureButton.frame=CGRectMake(self.frame.size.width-50, 10, 30, 30);
    isSecureButton.selected=NO;
    [isSecureButton setBackgroundImage:[UIImage imageNamed:@"lookpwd_norm"] forState:UIControlStateNormal];
    [isSecureButton setBackgroundImage:[UIImage imageNamed:@"lookpwd"] forState:UIControlStateSelected];
    [isSecureButton addTarget:self action:@selector(isSecureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:isSecureButton];
}

-(void)isSecureButtonClicked:(UIButton *)button
{
    if (button.selected==NO) {
      
        button.selected=YES;
        self.textField.secureTextEntry=NO;
 
    }else
    {
        button.selected=NO;
        self.textField.secureTextEntry=YES;
    }
}

@end
