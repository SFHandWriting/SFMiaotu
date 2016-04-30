//
//  FriendItemCell.m
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FriendItemCell.h"
#import "UIImageView+WebCache.h"
#import "PicViewController.h"
#import "PersonalViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation FriendItemCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(FriendItemsModel *)model{
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
    //nickname
    CGRect rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
    self.nickNameLabel.numberOfLines = 1 ;
    self.nickNameLabel.font = [UIFont systemFontOfSize:14];
    self.nickNameLabel.alpha = 0.6;
    [self.contentView addSubview:self.nickNameLabel];
    if(![self.str isEqualToString:@"dongjing"]){
    //age
    self.ageButton = [[ageButton alloc]initWithFrame:CGRectMake(53+rectLength.size.width, 8, 40, 14)];
    if([_model.Gender isEqualToString:@"女"]){
        self.ageButton.backgroundColor = [UIColor redColor];
        [self.ageButton setImage:[UIImage imageNamed:@"icon_girl.png"] forState:UIControlStateNormal];
    }else{
        self.ageButton.backgroundColor = [UIColor blueColor];
        [self.ageButton setImage:[UIImage imageNamed:@"icon_boy.png"] forState:UIControlStateNormal];
    }
    self.ageButton.alpha = 0.3;
    self.ageButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.ageButton.titleLabel.textColor = [UIColor whiteColor];
    self.ageButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.ageButton];
    //感情状态
    if([self.str isEqualToString:@"jing"]){
    self.emotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(100+rectLength.size.width, 8, 60, 14)];
    if([_model.Gender isEqualToString:@"女"]){
        self.emotionLabel.backgroundColor = [UIColor redColor];
    }else{
        self.emotionLabel.backgroundColor = [UIColor blueColor];
    }
    self.emotionLabel.alpha = 0.3;
    self.emotionLabel.font = [UIFont systemFontOfSize:12];
    self.emotionLabel.textColor = [UIColor whiteColor];
    self.emotionLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.emotionLabel];
    }
    if([self.str isEqualToString:@"jing"]){
    //喜欢
    self.likeButton = [FlikeButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [self.likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.likeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.likeButton setImage:[UIImage imageNamed:@"icon_detail_like.png"] forState:UIControlStateNormal];
    self.likeButton.layer.borderWidth = 1;
    self.likeButton.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.likeButton setImage:[UIImage imageNamed:@"icon_together_like_solid.png"] forState:UIControlStateSelected];
    self.likeButton.frame = CGRectMake(SCREENW-50, 5, 40, 20);
    [self.contentView addSubview:self.likeButton];
    }
    }
    //time
    self.wantLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
    self.wantLabel.font = [UIFont systemFontOfSize:12];
    self.wantLabel.alpha = 0.3;
    [self.contentView addSubview:self.wantLabel];
    //dec
    //    NSArray *decArray = [_model.Remark componentsSeparatedByString:@"#"];
    //    NSString *str1 = decArray[1];
    //    NSInteger length =str1.length+2;
    
    //    [_model.Remark addAttribute:(NSString *)kCTForegroundColorAttributeName
    //                        value:(id)color.CGColor
    //                        range:NSMakeRange(location, length)];
    CGRect rect;
    if(![self.str isEqualToString:@"dongjing"]){
    rect = [_model.Content boundingRectWithSize:CGSizeMake(SCREENW-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    }else{
      rect = [_model.Remark boundingRectWithSize:CGSizeMake(SCREENW-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    }
    self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    self.decLabel.font = [UIFont systemFontOfSize:13];
    self.decLabel.numberOfLines = 0 ;
    self.decLabel.alpha = 0.6;
    [self.contentView addSubview:self.decLabel];
    if(_model.PicList.count>0){
    //first
    self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstButton.frame = CGRectMake(10, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
    self.firstButton.tag =200;
    [self.firstButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.firstButton];
    }
    if(_model.PicList.count>1){
    //sec
    self.secButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secButton.frame = CGRectMake(20+(SCREENW-40)/3, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
    self.secButton.tag = 201;
    [self.secButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.secButton];
    }
    if(_model.PicList.count>2){
    //third
    self.thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdButton.frame = CGRectMake(30+2*(SCREENW-40)/3, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
    self.thirdButton.tag = 202;
    [self.thirdButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.thirdButton];
    }
    NSInteger s;
    if(_model.PicList.count>0){
        s=45+rect.size.height+(SCREENW-30)/3;
    }else{
        s=45+rect.size.height;
    }
    if(![self.str isEqualToString:@"dongjing"]){
    if([self.str isEqualToString:@"jing"]){
    //距离
    self.distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, s, 200, 30)];
    self.distanceLabel.font = [UIFont systemFontOfSize:10];
    self.distanceLabel.alpha = 0.4;
    
    [self.contentView addSubview:self.distanceLabel];
    //评论
    self.commentButton = [FlikeButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.frame = CGRectMake(SCREENW-50, s, 40, 20);
    [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    self.commentButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.commentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"icon_friend_comment.png"] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(commentButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentButton];
    }else{
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-90, s, 80, 30)];
        label.text = [NSString stringWithFormat:@"喜欢%d人 评论%d人",_model.LikeList.count,_model.ReplyList.count];
        label.textColor = [UIColor grayColor];
        label.alpha = 0.8;
        
        label.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:label];
    }
    }
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.FatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}

-(void)finishCellWithModel:(FriendItemsModel *)model{
    NSMutableArray *myPicArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in _model.PicList){
        [myPicArray addObject:[dic objectForKey:@"Url"]];
    }
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    [self.ageButton setTitle:[NSString stringWithFormat:@"%@岁",model.Age] forState:UIControlStateNormal];
    self.emotionLabel.text = model.MaritalStatus;
    if(![self.str isEqualToString:@"dongjing"]){
    self.wantLabel.text = [NSString stringWithFormat:@"想去 %@",model.WantGo];
    }else{
        self.wantLabel.text = [NSString stringWithFormat:@"%@ 距您 %@km",_model.Created,_model.Distance];
    }
    if(![self.str isEqualToString:@"dongjing"]){
    self.decLabel.text = model.Content;
    }else{
        self.decLabel.text = model.Remark;
    }
    self.decLabel.numberOfLines = 0;
    if(model.PicList.count >0){
        UIImageView *firstView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [firstView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[0]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [self.firstButton addSubview:firstView];
    }
    if(model.PicList.count>1){
        UIImageView *secView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [secView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[1]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [self.secButton addSubview:secView];
    }
    if(model.PicList.count>2){
        UIImageView *thirdView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [thirdView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[2]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [self.thirdButton addSubview:thirdView];
    }
    self.distanceLabel.text = [NSString stringWithFormat:@"%@km  %@",model.Distance,model.Created];
}
-(void)imageclick:(UIButton *)button{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=2;
    picVC.picArray = _model.PicList;
    [self.FatherVC presentViewController:picVC animated:YES completion:^{
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
