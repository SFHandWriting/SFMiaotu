//
//  FCommentCell.m
//  妙途
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FCommentCell.h"
#import "CommendModel.h"
#import "PersonalViewController.h"
#import "UIImageView+WebCache.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation FCommentCell
- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(CommendModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    //头像
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.frame = CGRectMake(10, 5, 30, 30);
    [self.headerButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    self.headerButton.layer.cornerRadius = 15;
    self.headerButton.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerButton];
    //名字
    CGRect rectLength = [_model.Content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
    self.nickNameLabel.font = [UIFont systemFontOfSize:16];
    self.nickNameLabel.numberOfLines = 1 ;
    self.nickNameLabel.alpha = 0.6;
    [self.contentView addSubview:self.nickNameLabel];
    //time
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.alpha = 0.3;
    [self.contentView addSubview:self.timeLabel];
    //评论
    CGRect rect = [_model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    self.decLabel.font = [UIFont systemFontOfSize:15];
    self.decLabel.numberOfLines = 0 ;
    self.decLabel.alpha = 0.5;
    [self.contentView addSubview:self.decLabel];
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}
-(void)finishCellWithModel:(CommendModel *)model{
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.Created];
    self.decLabel.text = model.Content;
    self.decLabel.numberOfLines = 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
