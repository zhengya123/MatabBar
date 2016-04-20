//
//  OneTableViewCell.h
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *huifu;
@property (weak, nonatomic) IBOutlet UILabel *discribe;

@end
