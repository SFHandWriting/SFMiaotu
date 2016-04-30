//
//  SubCell.m
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SubCell.h"
#import "PersonalViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#import "UIImageView+WebCache.h"
@implementation SubCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(DoubleModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    //头像
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.frame = CGRectMake(10, 5, 30, 30);
    [self.headerButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    self.headerButton.layer.cornerRadius = 15;
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headView sd_setImageWithURL:[NSURL URLWithString:_model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headView];
    self.headerButton.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerButton];
    //nickname
    CGRect rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
    self.nickNameLabel.font = [UIFont systemFontOfSize:16];
    self.nickNameLabel.numberOfLines = 1 ;
    self.nickNameLabel.text = _model.Nickname;
    self.nickNameLabel.alpha = 0.6;
    [self.contentView addSubview:self.nickNameLabel];
    //time
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.alpha = 0.3;
    self.timeLabel.text = _model.Created;
    [self.contentView addSubview:self.timeLabel];
    //dec
    
    
    //    NSArray *decArray = [_model.Remark componentsSeparatedByString:@"#"];
    //    NSString *str1 = decArray[1];
    //    NSInteger length =str1.length+2;
    
    //    [_model.Remark addAttribute:(NSString *)kCTForegroundColorAttributeName
    //                        value:(id)color.CGColor
    //                        range:NSMakeRange(location, length)];
    CGRect rect = [_model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    self.decLabel.font = [UIFont systemFontOfSize:16];
    self.decLabel.numberOfLines = 0 ;
    self.decLabel.text = _model.Content;
    self.decLabel.alpha = 0.5;
    [self.contentView addSubview:self.decLabel];
 
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
//    [self. presentViewController:personal animated:YES completion:^{
//        
//    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
