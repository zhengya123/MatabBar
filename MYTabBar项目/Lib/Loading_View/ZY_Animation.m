//
//  ZY_Animation.m
//  MYTabBar项目
//
//  Created by dqong on 16/6/6.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ZY_Animation.h"


@interface ZY_Animation()

@property (nonatomic, weak)UIImageView *loadingImage;

@end

@implementation ZY_Animation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *loadingImage = [[UIImageView alloc] init];
        loadingImage.image = [UIImage imageNamed:@"loading"];
        self.loadingImage = loadingImage;
        [self addSubview:loadingImage];
        
    }
    return self;
}

//创建动画
-(void)createRotating{
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.byValue = @(M_PI * 2);
    anim.duration = 1;
    anim.repeatCount = CGFLOAT_MAX;
    [self.loadingImage.layer addAnimation:anim forKey:nil];
    
}
/**
 *  移除动画
 */
-(void)remoRotating{
    
    [self.loadingImage.layer removeAllAnimations];
    self.loadingImage.hidden = YES;
    
}

//开始动画
- (void)startRotating {
    [self createRotating];
    self.loadingImage.hidden = NO;
}


//停止动画
- (void)stopRotating {
    [self.layer removeAnimationForKey:@"rotating"];
    [self remoRotating];
}

//设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat loadingX = (self.frame.size.width - 50) * 0.5;
    CGFloat loadingY = (self.frame.size.height - 50) * 0.5;
    self.loadingImage.frame = CGRectMake(loadingX, loadingY, 50, 50);
}



@end
