//
//  commonModel.h
//  foodsecurity
//
//  Created by wangweiyi on 15/3/26.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol commonConnectDelegate;


@interface commonModel : NSObject


-(id)initWithUrl:(NSString *)url getPath:(NSString *)path parameters:(NSDictionary *)parameters;
-(id)initWithUrl:(NSString *)url postpath:(NSString *)path parameters:(NSDictionary *)parameter;
-(void)reGetWithParameters:(NSDictionary *)parameters;

-(void)cancelRequest:(NSString *)method path:(NSString *)path;
//*************************************通用方法**************************
//md5
+(NSString *)md5:(NSString *)str;
//字符串utf8转化
+(NSString *)utf8:(NSString *)str;
//字符串是不是为空类型
+(NSString *)isEmpty:(NSString *)str;

+ (UIImage *)imageWithColor:(UIColor *)color;

@property(nonatomic,weak)id<commonConnectDelegate> delegate;
@property(nonatomic,copy)NSString *baseUrl;
@property(nonatomic,copy)NSString *basePath;
@property(nonatomic,copy)NSString *error;
@end


@protocol commonConnectDelegate <NSObject>

@optional
-(void)gotTheData:(NSArray *)dataDic and:(commonModel *)connect;
-(void)gotTheDataWX:(NSDictionary *)dataDic and:(commonModel *)connect;
-(void)gotTheErrorMessage:(NSString *)errorMessage and:(commonModel *)connect;

-(void)connectError:(commonModel *)connect;

@end