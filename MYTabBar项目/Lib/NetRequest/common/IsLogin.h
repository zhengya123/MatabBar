//
//  IsLogin.h
//  foodsecurity
//
//  Created by 赵鹏 on 15-5-9.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsLogin : NSObject

@property(nonatomic,assign)BOOL isLogin;
+(IsLogin *)shareLogin;
@end
