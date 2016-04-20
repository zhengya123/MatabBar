//
//  DetailViewController.h
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWOBASEViewController.h"
@interface DetailViewController : TWOBASEViewController
@property(nonatomic,strong)NSString * TopicId;
@property(nonatomic,strong)UIWebView * webView;
@end
