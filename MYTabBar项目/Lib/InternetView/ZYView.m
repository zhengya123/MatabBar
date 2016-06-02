//
//  ZYView.m
//  MYTabBar项目
//
//  Created by dqong on 16/5/31.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ZYView.h"


@interface ZYView ()

/**
 *  显示的图片
 */
@property (nonatomic, weak) UIImageView * iconImageView;


/**
 *  显示的文字
 */
@property (nonatomic,weak) UILabel * nameLabel;


/**
 *  重新加载的按钮
 */
@property (nonatomic,weak) UIButton * rebackButton;

@end

@implementation ZYView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        UIImageView * iconImageView = [[UIImageView alloc]init];
        iconImageView.image = [UIImage imageNamed:@"notInternet"];
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"网络好像没有了，请检查网络";
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(rebackClick:) forControlEvents:UIControlEventTouchUpInside];
        self.rebackButton = btn;
        [self addSubview:btn];
        
    }

    return self;


}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    /**
     *  图片的位置坐标
     */
    CGFloat iconImageViewX = self.bounds.size.width/4;
    CGFloat iconImageViewY = 0;
    CGFloat iconImageViewW = self.bounds.size.width/2;
    CGFloat iconImageViewH = 150;
    self.iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewH);


    /**
     *  文字的位置坐标
     */
    CGFloat nameLabelX = 0;
    CGFloat nameLabelY = iconImageViewH;
    CGFloat nameLabelW = self.bounds.size.width;
    CGFloat nameLabelH = self.bounds.size.height - iconImageViewH;
    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);


    /**
     *  重新加载的按钮的位置
     */
    
    CGFloat rebackButtonX = 0;
    CGFloat rebackButtonY = 180;
    CGFloat rebackButtonW = self.bounds.size.width;
    CGFloat rebackButtonH = 50;
    self.rebackButton.frame = CGRectMake(rebackButtonX, rebackButtonY, rebackButtonW, rebackButtonH);
    
    
}

/**
 *  按钮的点击方法
 */
-(void)rebackClick:(UIButton *)button{

//    [self.delegate rebackInternetAgain];

    if([self.delegate respondsToSelector:@selector(rebackInternetAgain)]){
    
        [self.delegate rebackInternetAgain];
    
    
    }


}
//-(void)rebackInternetAgain{
//
//    NSLog(@"在代理方法里点击了");
//
//
//}
@end
