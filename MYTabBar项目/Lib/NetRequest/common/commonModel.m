//
//  commonModel.m
//  foodsecurity
//
//  Created by wangweiyi on 15/3/26.
//  Copyright (c) 2015年 com.zsgj. All rights reserved.
//

#import "commonModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import <CommonCrypto/CommonDigest.h>



@implementation commonModel


//get
-(id)initWithUrl:(NSString *)url getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        [self getTheDataWithUrl:url getPath:path parameters:parameters];
        self.baseUrl = url;
        self.basePath = path;
    }
    return self;
    
}


-(void)getTheDataWithUrl:(NSString *)url getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSURL* baseUrl = [NSURL URLWithString:url];
    AFHTTPSessionManager* sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];

    [sessionManager GET:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self handleResponse:responseObject];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self handleError:error];
    }];
}


//post
-(id)initWithUrl:(NSString *)url postpath:(NSString *)path parameters:(NSDictionary *)parameter
{
    if (self = [super init]) {
        [self postTheDataWithUrl:url path:path parameters:parameter];
        self.baseUrl = url;
        self.basePath = path;
    }
    return self;
}

-(void)postTheDataWithUrl:(NSString *)url path:(NSString *)path parameters:(NSDictionary *)parameter
{
    NSURL* baseUrl = [NSURL URLWithString:url];
    AFHTTPSessionManager* sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
    AFJSONRequestSerializer* serializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    [sessionManager setRequestSerializer:serializer];
    [sessionManager POST:path parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self handleResponse:responseObject];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self handleError:error];
    }];
}

-(void)reGetWithParameters:(NSDictionary *)parameters
{
    [self getTheDataWithUrl:_baseUrl getPath:_basePath parameters:parameters];
}

-(void)handleResponse:(id _Nonnull) responseObject {
    if ([[responseObject objectForKey:@"Data"] isKindOfClass:[NSNull class]]) {
        NSData *errorData = [[responseObject objectForKey:@"ResponseInstance"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
        NSString *errorMessage=[[NSString alloc]init];
        if ([[errorDic objectForKey:@"BusinessExceptionInstance"] isKindOfClass:[NSNull class]]) {
            errorMessage = @"";
        }
        else
        {
            errorMessage = [[errorDic objectForKey:@"BusinessExceptionInstance"] objectForKey:@"Message"];
        }
        
        [self.delegate gotTheErrorMessage:errorMessage and:self];
    }else{
        NSData *data = [[responseObject objectForKey:@"Data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.delegate gotTheData:dataDic and:self];
    }
}

-(void)handleError:(NSError* _Nonnull) error {
    NSLog(@"get error%@",error);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

    self.error=[NSString stringWithFormat:@"%@",error];
    [self.delegate connectError:self];
}



//取消当前请求（待定）
-(void)cancelRequest:(NSString *)method path:(NSString *)path
{
//    NSURL *baseURL = [NSURL URLWithString:self.baseUrl];
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
//    [client cancelAllHTTPOperationsWithMethod:method path:path];
}


//md5
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString *resultStr =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
                            ];
    NSString *reStr = [resultStr substringWithRange:NSMakeRange(8, 16)];
    return [reStr uppercaseString];
}

//字符串utf8转化
+(NSString *)utf8:(NSString *)str
{
    if (![str isKindOfClass:[NSNull class]]) {
        str=[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else
    {
        str=@"";
    }
    return str;
}

//字符串是不是为空类型
+(NSString *)isEmpty:(NSString *)str
{
    if (![str isKindOfClass:[NSNull class]]) {
    }else
    {
        str=@"";
    }
    return str;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
