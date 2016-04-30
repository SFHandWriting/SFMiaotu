//
//  MessageCell.m
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "MessageCell.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)finish{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    view.image = [UIImage imageNamed:self.image];
    [self.contentView addSubview:view];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 100, 20)];
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:16];
    label.alpha = 0.5;
    [self.contentView addSubview:label];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
