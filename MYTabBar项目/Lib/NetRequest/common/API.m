//
//  API.m
//  foodsecurity
//
//  Created by wangweiyi on 15/3/22.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "API.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@implementation API

+(void)getTheDataWithUrl:(NSString *)url getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary* _Nonnull data))success
{
    NSURL* baseUrl = [NSURL URLWithString:url];
    AFHTTPSessionManager* sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
    
    [sessionManager GET:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self handleResponse:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self handleError:error];
    }];
}


+(void)handleResponse:(id _Nonnull) responseObject success:(void (^)(NSDictionary* _Nonnull data))success{
    if ([[responseObject objectForKey:@"Data"] isKindOfClass:[NSNull class]]) {
        NSData *errorData = [[responseObject objectForKey:@"ResponseInstance"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
        NSString *errorMessage=[[NSString alloc]init];
        if ([[errorDic objectForKey:@"BusinessExceptionInstance"] isKindOfClass:[NSNull class]]) {
            errorMessage = @"未知错误";
        }
        else
        {
            errorMessage = [[errorDic objectForKey:@"BusinessExceptionInstance"] objectForKey:@"Message"];
        }
        
        [self showError:errorMessage];
    }else{
        NSData *data = [[responseObject objectForKey:@"Data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dataDic);
        }
    }
}

+(void)handleError:(NSError* _Nonnull) error {
    [self showError:error.localizedDescription];
}

+(void)showError:(NSString*)error {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
