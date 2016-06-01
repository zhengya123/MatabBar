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


}
@end
