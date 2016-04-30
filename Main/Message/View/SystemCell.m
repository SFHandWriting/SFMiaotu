//
//  SystemCell.m
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SystemCell.h"

@implementation SystemCell
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(MessageModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    NSString *s = [NSString stringWithFormat:@"%@",_model.Status];
    if([s isEqualToString:@"0"]){
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        view.image = [UIImage imageNamed:@"icon_remind_msg.png"];
        [self.contentView addSubview:view];
    }
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 150, 20)];
    self.titleLabel.text = _model.Title;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.alpha = 0.7;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    //time
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-160,15, 150, 20)];
    self.timeLabel.text = _model.Created;
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.alpha = 0.5;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
    //content
    NSString *conten = [_model.Content objectForKey:@"Content"];
    CGRect rect = [conten boundingRectWithSize:CGSizeMake(SCREENW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 45, SCREENW-40, rect.size.height)];
    self.contentLabel.text = conten;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.alpha = 0.3;
    [self.contentView addSubview:self.contentLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
