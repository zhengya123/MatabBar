//
//  API.h
//  foodsecurity
//
//  Created by wangweiyi on 15/3/22.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject


+(void)getTheDataWithUrl:(NSString * _Nullable)url
                 getPath:(NSString * _Nullable)path
              parameters:(NSDictionary * _Nullable)parameters
                 success:(nullable void (^)(NSDictionary* _Nonnull data))success;


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  接口文档
 */
#define BASE @""
#define ZHONGJIAN @""
#define ONEINTERFACE_TABLEVIEW @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1445340718396&vc=76&vn=5.3.0&loguid=0&deviceid=haodou865267025865048&uuid=c8fcd4d1ecbc62186735d141cab8e833&channel=huawei_v530&method=Topic.index&virtual=&signmethod=md5&v=2&timestamp=1445343714&nonce=0.41124150521148695&appsign=9ad9da9bf43517383b0bebf5dbe35093"
#define FENGHUANG_BASE @"http://api.tool.chexun.com/"
#define FENGHUANG_GETBUTCAR @"mobile/buyCarCompare.do"

//商品列表登陆接口
//#define SHANGPIN_LOGIN @"http://i.hiamily.com/login"
#define SHANGPIN_LOGIN @"http://i.hiamily.com/beijing/"

//高度
#define NAVIGATIONITEM_HIGH 0
#define FRAME ([[UIScreen mainScreen] bounds])

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
//是否是ios7以后的系统
#define IOS7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) ? YES:NO)
//适配比例
#define PROPORTION [UIScreen mainScreen].bounds.size.width/320
#define PROPORTION_HEIGHT [UIScreen mainScreen].bounds.size.height/568

//触感动画
#define TOUCH_COLOR [UIColor greenColor]
//颜色

#define TOOLBAR_COLOR [UIColor colorWithRed:0/255.0 green:112/255.0 blue:134/255.0 alpha:1.0]
#define BG_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0]
#define PRESS_MOLV_COLOR [UIColor colorWithRed:0 green:64/255.0 blue:64/255.0 alpha:1.0]

@end
