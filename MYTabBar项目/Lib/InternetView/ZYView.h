//
//  ZYView.h
//  MYTabBar项目
//
//  Created by dqong on 16/5/31.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZYView_rebackDelegate <NSObject>

-(void)rebackInternetAgain;


@end

@interface ZYView : UIView

@property (nonatomic,assign) id<ZYView_rebackDelegate>delegate;

@end
