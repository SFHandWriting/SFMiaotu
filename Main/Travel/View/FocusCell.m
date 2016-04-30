//
//  FocusCell.m
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FocusCell.h"
#import "UIImageView+WebCache.h"
#import "PersonalViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation FocusCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}
-(void)creatUI{
    //头像
    self.headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headButton.frame = CGRectMake(10, 10, 40, 40);
    [self.headButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.headButton];
    //nick
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 100, 25)];
    self.nickNameLabel.font  =[UIFont systemFontOfSize:14];
    self.nickNameLabel.textColor = [UIColor blackColor];
    self.nickNameLabel.alpha = 0.8;
    [self.contentView addSubview:self.nickNameLabel];
    //remark
    self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 45, SCREENW-120, 15)];
    
    self.remarkLabel.textColor  =[UIColor grayColor];
    self.remarkLabel.alpha = 0.6;
    self.remarkLabel.font  =[UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.remarkLabel];
    //图片
    self.yellowView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-50, 15, 30, 30)];
    
    [self.contentView addSubview:self.yellowView];
}
-(void)finishCellWithModel:(CommendModel *)model{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [view sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    view.layer.cornerRadius = 20;
    view.layer.masksToBounds = YES;
    [self.headButton addSubview:view];
    self.model = model;
    self.nickNameLabel.text = model.Nickname;
    self.remarkLabel.text = model.State;
    self.yellowView.image = [UIImage imageNamed:@"mine_guanzhu.png"];
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
