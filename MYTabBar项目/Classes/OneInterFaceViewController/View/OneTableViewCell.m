//
//  OneTableViewCell.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    
    return self;
    
}
-(void)initLayout{




}
-(void)setIntroductionText:(NSString *)text{
    CGRect frame = [self frame];
    frame.size.height = _titleLabel.frame.origin.x + _name.frame.origin.y + _discribe.frame.origin.y;
    self.frame = frame;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
