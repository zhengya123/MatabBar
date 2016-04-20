//
//  IsLogin.m
//  foodsecurity
//
//  Created by 赵鹏 on 15-5-9.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "IsLogin.h"

@implementation IsLogin


static IsLogin *instance = nil;
+(IsLogin *)shareLogin
{
    
    @synchronized(self){
        if(instance == nil){
            instance = [[self alloc] init];
            instance.isLogin=NO;
        }
    }
    return instance;
}


@end
