//
//  TeamCell.m
//  妙途
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TeamCell.h"
#import "likeButton.h"
#import "ThreeButton.h"
#import "MoneyButton.h"
#import "AFNetworking.h"
#import "adViewController.h"
#import "CommendViewController.h"
#import "UIImageView+WebCache.h"
#define likeUrl @"http://api.miaotu.com/v1.1/activity/like"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation TeamCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(ItemsModel2 *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    //图片(包含许多小控件)
    self.PicVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREENW , 150)];
    self.PicVIew.userInteractionEnabled = YES;
    //1.加喜欢
    likeButton *button = [likeButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENW-40, 10, 30, 40);
    [button setTitle:[NSString stringWithFormat:@"%@",_model.ActivityLikeCount] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    if(_model.IsLike){
      [button setImage:[UIImage imageNamed:@"icon_like.png"] forState:UIControlStateNormal];
    }else{
      [button setImage:[UIImage imageNamed:@"icon_bglike.png"] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self.PicVIew sd_setImageWithURL:[NSURL URLWithString:_model.PicUrl] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
    [self.PicVIew addSubview:button];
    //2.加title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 120, 100, 20)];
    titleLabel.text = _model.Destination;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.PicVIew addSubview:titleLabel];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 122, 13, 15)];
    titleView.image = [UIImage imageNamed:@"icon_custom_location.png"];
    [self.PicVIew addSubview:titleView];
    //3.加价格
    MoneyButton *moneyButton = [[MoneyButton alloc]initWithFrame:CGRectMake(SCREENW-65, 100, 50, 20)];
    [moneyButton setTitle:[NSString stringWithFormat:@"%@",_model.MtPrice] forState:UIControlStateNormal];
    [moneyButton setImage:[UIImage imageNamed:@"icon_custom_rmb.png"] forState:UIControlStateNormal];
    [self.PicVIew addSubview:moneyButton];
    //4.加nickname
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-70, 128, 30, 15)];
    fromLabel.text = @"From";
    fromLabel.alpha = 0.8;
    fromLabel.textColor = [UIColor whiteColor];
    fromLabel.font = [UIFont systemFontOfSize:8];
    [self.PicVIew addSubview:fromLabel];
    UILabel *nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-45, 125, 40, 20)];
    nickNameLabel.text = _model.Nickname;
    nickNameLabel.font = [UIFont systemFontOfSize:10];
    nickNameLabel.textColor =[UIColor whiteColor];
    [self.PicVIew addSubview:nickNameLabel];
    [self.contentView addSubview:self.PicVIew];
    //简介
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREENW, 150)];
    [self.contentView addSubview:label];
    //1.加titlelong
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    view.image = [UIImage imageNamed:@"logo_loading_bg.png"];
    [label addSubview:view];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 30)];
    self.titleLabel.alpha = 0.8;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = _model.Title;
    [label addSubview:self.titleLabel];
    //2.加日期
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 250, 20)];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    NSString *startDate = [_model.StartDate substringToIndex:10];
    NSString *endDate = [_model.EndDate substringToIndex:10];
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@  %@",startDate,endDate,_model.Duration];
    self.timeLabel.textColor = [UIColor blueColor];
    self.timeLabel.alpha = 0.7;
    [label addSubview:self.timeLabel];
    //3.加评论
    self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 42, SCREENW-80, 60)];
    self.remarkLabel.font = [UIFont systemFontOfSize:14];
    self.remarkLabel.numberOfLines = 0;
    self.remarkLabel.alpha = 0.8;
    self.remarkLabel.text = _model.Remark;
    [label addSubview:self.remarkLabel];
    label.userInteractionEnabled = YES;
    //4.加button
    NSArray *array = @[@"icon_custom_share.png",@"icon_together_comment.png",@""];
    for(int i=0;i<3;i++){
        ThreeButton *button = [[ThreeButton alloc]initWithFrame:CGRectMake(i*SCREENW/3, 100, SCREENW/3, 30)];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW/3, 8, 1, 14)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.2;
        [button addSubview:line];
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        if(i==0){
            [button setTitle:[NSString stringWithFormat:@"%@",_model.ShareCount] forState:UIControlStateNormal];
        }else if (i==1){
            [button setTitle:[NSString stringWithFormat:@"%@",_model.ActivityReplyCount] forState:UIControlStateNormal];
        }else if(i==2){
//            [button setTitle:[NSString stringWithFormat:@"报名 %@",_model.ActivityJoinCount] forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW/3, 30)];
            label.text = [NSString stringWithFormat:@"报名 %@",_model.ActivityJoinCount];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14];
            [button addSubview:label];
        }
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textColor = [UIColor grayColor];
        button.tag = 400+i;
        [button addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
        [label addSubview:button];
    }
    //加装饰
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 98, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [label addSubview:line];
}
//三按钮点击事件
-(void)click2:(UIButton *)button{
    if(button.tag == 400){
      //跳到微信分享页面
    }else if (button.tag == 401){
        CommendViewController *commendVC = [[CommendViewController alloc]init];
        commendVC.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        commendVC.yid =  _model.Yid;
        commendVC.aid = _model.Aid;
        commendVC.type = @"activity";
        commendVC.hidesBottomBarWhenPushed = YES;
        [self.fatherVC presentViewController:commendVC animated:YES completion:^{
            
        }];
    }else if(button.tag == 402){
        adViewController *adV = [[adViewController alloc]init];
        adV.Title = _model.Title;
        adV.url = [NSString stringWithFormat:@"http://m.miaotu.com/App32/detail/?aid=%@&token=98aa550d-6758-11e5-bb24-00163e002e59&uid=%@",_model.Aid,_model.Uid];
        adV.hidesBottomBarWhenPushed = YES;
        [self.fatherVC presentViewController:adV animated:YES completion:^{
            
        }];
    }
}
//喜欢
-(void)like{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",_model.Aid,@"aid", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:likeUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
