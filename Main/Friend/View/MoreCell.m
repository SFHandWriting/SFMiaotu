//
//  MoreCell.m
//  妙途
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "MoreCell.h"
#import "UIImageView+WebCache.h"
#import "PersonalViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation MoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(DoubleModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    //头像
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.frame = CGRectMake(10, 15, 30, 30);
    [self.headerButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    self.headerButton.layer.cornerRadius = 15;
    self.headerButton.layer.masksToBounds = YES;
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:_model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    [self.contentView addSubview:self.headerButton];
    //nickname
    CGRect rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, rectLength.size.width, 30)];
    self.nickNameLabel.numberOfLines = 1 ;
    self.nickNameLabel.font = [UIFont systemFontOfSize:14];
    self.nickNameLabel.alpha = 0.6;
    self.nickNameLabel.text = _model.Nickname;
    [self.contentView addSubview:self.nickNameLabel];
    //
    if(self.state == 0){
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(55+rectLength.size.width, 15, 200, 30)];
    self.label.text = @"喜欢了这个行程";
    self.label.alpha = 0.5;
    self.label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.label];
    }
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}

@end
