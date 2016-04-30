//
//  CommendCell.m
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "CommendCell.h"
#import "UIImageView+WebCache.h"
#import "PersonalViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation CommendCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(CommendModel *)model{
     _model = model;
    [self creatUI];
}
-(void)setModel2:(ItemsModel2 *)model2{
    _model2 = model2;
    [self creatUI];
}
-(void)creatUI{
    //头像
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.frame = CGRectMake(10, 5, 30, 30);
    [self.headerButton addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    self.headerButton.layer.cornerRadius = 15;
    self.headerButton.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerButton];
    //名字
    CGRect rectLength;
    if(_model2 == nil){
       rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    }else{
      rectLength = [_model2.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    }
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
    if(_model2 == nil){
    self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    }else{
      self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 45, SCREENW-15, 20)];
    }
    self.decLabel.font = [UIFont systemFontOfSize:15];
    self.decLabel.numberOfLines = 0 ;
    self.decLabel.alpha = 0.5;
    [self.contentView addSubview:self.decLabel];
}
-(void)headClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];}
-(void)finishCellWithModel:(CommendModel *)model{
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.Created];
    self.decLabel.text = model.Content;
    self.decLabel.numberOfLines = 0;
}
-(void)finishCellWithModel2:(ItemsModel2 *)model{
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 70, 280, 150)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model2.PicUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.contentView addSubview:imageView];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.StartDate];
    self.decLabel.text = model.Title;
    self.decLabel.numberOfLines = 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
