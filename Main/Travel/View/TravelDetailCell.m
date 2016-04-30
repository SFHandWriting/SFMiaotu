//
//  TravelDetailCell.m
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TravelDetailCell.h"
#import "TravelDetailModel.h"
#import "DoubleModel.h"
#import "PicViewController.h"
#import "CommendViewController.h"
#import "MoreViewController.h"
#import "PersonalViewController.h"
#import "UIImageView+WebCache.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation TravelDetailCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(TravelDetailModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    commentArray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
//头像
self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
self.headerButton.frame = CGRectMake(10, 5, 30, 30);
[self.headerButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
self.headerButton.layer.cornerRadius = 15;
self.headerButton.layer.masksToBounds = YES;
[self.contentView addSubview:self.headerButton];
//nickname
CGRect rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
self.nickNameLabel.font = [UIFont systemFontOfSize:16];
self.nickNameLabel.numberOfLines = 1 ;
self.nickNameLabel.alpha = 0.6;
[self.contentView addSubview:self.nickNameLabel];
//age
self.ageButton = [[ageButton alloc]initWithFrame:CGRectMake(58+rectLength.size.width, 8, 40, 14)];
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
//time
self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
self.timeLabel.font = [UIFont systemFontOfSize:12];
self.timeLabel.alpha = 0.3;
    [self.contentView addSubview:self.timeLabel];

  CGRect rect = [_model.Remark boundingRectWithSize:CGSizeMake(SCREENW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
   self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
  self.decLabel.font = [UIFont systemFontOfSize:16];
  self.decLabel.numberOfLines = 0 ;
  self.decLabel.alpha = 0.5;
[self.contentView addSubview:self.decLabel];
    NSInteger y=45+rect.size.height;
    //first
    firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(10, y+5, (SCREENW-40)/3, (SCREENW-30)/3);
    firstButton.tag =200;
    [firstButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:firstButton];
    //sec
    secButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secButton.frame = CGRectMake(20+(SCREENW-40)/3, y+5, (SCREENW-40)/3, (SCREENW-30)/3);
    secButton.tag = 201;
    [secButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:secButton];
    //third
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(30+2*(SCREENW-40)/3, y+5, (SCREENW-40)/3, (SCREENW-30)/3);
    thirdButton.tag = 202;
    [thirdButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:thirdButton];
    y1 = y+5+(SCREENW-30)/3;
    //更多
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(SCREENW-40, y1+42.5, 30, 30);
    [moreButton setImage:[UIImage imageNamed:@"icon_caim.png"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    moreButton.layer.cornerRadius = 15;
    moreButton.layer.masksToBounds = YES;
    moreButton.layer.borderWidth = 1;
    moreButton.alpha = 0.5;
    moreButton.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.contentView addSubview:moreButton];
    //scroll
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(180, y1+10, SCREENW, 30)];
    btnView.backgroundColor = [UIColor grayColor];
    btnView.alpha = 0.3;
    [self.contentView addSubview:btnView];
    NSArray *array = @[@"喜欢",@"评论",@"已入伙"];
    NSArray *numArray = @[_model.YueyouLikeCount,_model.YueyouReplyCount,_model.YueyouJoinCount];
    for(int i=0;i<3;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*60, y1+10, 60, 30);
        [btn setTitle:[NSString stringWithFormat:@"%@%@",array[i],numArray[i]] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.alpha = 0.3;
        btn.tag = 200+i;
        if(i==0){
            self.selectedButton = btn;
            self.selectedButton.selected = YES;
            [self.selectedButton setBackgroundColor:[UIColor whiteColor]];
            self.listArray = _model.LikeList;
            for(NSDictionary *dic in self.listArray){
                DoubleModel *model = [DoubleModel initWithDict:dic];
                [_dataArray addObject:model];
            }
            moreButton.alpha = 0.5;
        }
        UILabel *li = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 2)];
        li.backgroundColor = [UIColor grayColor];
        li.alpha = 1;
        [btn addSubview:li];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:btn];
    }
    [self creatScrollView];
    NSArray *array1 = @[@"出发时间",@"返回时间",@"出发地",@"目的地",@"截止时间",@"费用说明",@"约伴要求"];
    NSArray *array2 = @[_model.StartDate,_model.EndDate,_model.From,_model.Destination,_model.EndDate,_model.MoneyType,_model.Require];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, y1+78, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [self.contentView addSubview:line];
    for(int i=0;i<7;i++){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, y1+80+i*40, SCREENW-10, 40)];
        label.text = [NSString stringWithFormat:@"%@: %@",array1[i],array2[i]];
        label.textColor = [UIColor blueColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:15];
        //line
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(70, 39.5, SCREENW-100, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.8;
        [label addSubview:line];
        [self.contentView addSubview:label];
    }
    //评论
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, y1+370, SCREENW, 50)];
    [self.contentView addSubview:commentView];
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENW-10, 50)];
    la.text = @"评论";
    la.textColor = [UIColor grayColor];
    [commentView addSubview:la];
    UILabel *route = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-60, 15, 70, 20)];
    route.text = @"举报路线";
    route.textColor = [UIColor grayColor];
    route.font = [UIFont systemFontOfSize:12];
    route.layer.borderWidth = 2;
    route.layer.borderColor = [[UIColor grayColor]CGColor];
    route.layer.cornerRadius = 5;
    route.layer.masksToBounds = YES;
    [la addSubview:route];
    
    if(_model.ReplyList.count<4){
        k=_model.ReplyList.count;
    }else{
        k=3;
    }
    for(NSDictionary *dic in _model.ReplyList){
        DoubleModel *model = [DoubleModel initWithDict:dic];
        [commentArray addObject:model];
    }
    h=0;
    CGRect rect2;
    for(int i=0;i<k;i++){
        DoubleModel *model = commentArray[i];
        rect2 = [model.Content boundingRectWithSize:CGSizeMake(SCREENW-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        View = [[UIView alloc]initWithFrame:CGRectMake(0, y1+420+h, SCREENW, 105+rect2.size.height)];
        //头像
        UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        headerButton.frame = CGRectMake(10, 5, 30, 30);
        [headerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        headerButton.layer.cornerRadius = 15;
        headerButton.layer.masksToBounds = YES;
        headerButton.tag = 500+i;
        UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
        [headerButton addSubview:headerView];
        [View addSubview:headerButton];
        //名字
        CGRect rectLength = [model.Content boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        UILabel *nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
        nickNameLabel.text = model.Nickname;
        nickNameLabel.font = [UIFont systemFontOfSize:16];
        nickNameLabel.numberOfLines = 1 ;
        nickNameLabel.alpha = 0.6;
        [View addSubview:nickNameLabel];
        //time
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.alpha = 0.3;
        
        [View addSubview:timeLabel];
        //评论
        CGRect rect = [model.Content boundingRectWithSize:CGSizeMake(SCREENW-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        UILabel *decLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 45, SCREENW-60, rect.size.height)];
        decLabel.font = [UIFont systemFontOfSize:15];
        decLabel.numberOfLines = 0 ;
        decLabel.alpha = 0.5;
        decLabel.text = model.Content;
        [View addSubview:decLabel];
        //xian
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(50, 55+rect.size.height, SCREENW-50, 0.2)];
        line.backgroundColor = [UIColor grayColor];
        
        [View addSubview:line];
        [self.contentView addSubview:View];
        h=h+rect2.size.height+45+10;
    }
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    otherButton.frame = CGRectMake(0, 55+rect2.size.height, SCREENW, 50);
    NSString *str = [NSString stringWithFormat:@"点击查看，全部%d条评论",_model.ReplyList.count];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, SCREENW-150, 30)];
    label.text = str;
    label.alpha = 0.5;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    [otherButton addSubview:label];
    [otherButton addTarget:self action:@selector(other) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-115, 18, 10, 14)];
    view.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
    [otherButton addSubview:view];
    UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-108, 18, 10, 14)];
    view2.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
    [otherButton addSubview:view2];
    [View addSubview:otherButton];
}
-(void)buttonClick:(UIButton *)button{
    DoubleModel *model = commentArray[button.tag-500];
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}
-(void)imageclick:(UIButton *)button{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=2;
    picVC.picArray = _model.PicList;
    [self.fatherVC presentViewController:picVC animated:YES completion:^{
        
    }];
}
-(void)other{
    CommendViewController *commendVC = [[CommendViewController alloc]init];
    commendVC.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    commendVC.yid = self.yid;
    commendVC.type = @"yueyou";
    commendVC.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:commendVC animated:YES completion:^{
        
    }];
}
-(void)creatScrollView{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, y1+40, SCREENW-50, 35)];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    for(int i=0;i<self.listArray.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30+i*60, 2.5, 30, 30);
        DoubleModel *model = _dataArray[i];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [view sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
        [button addSubview:view];
        button.layer.cornerRadius = 15;
        button.layer.masksToBounds = YES;
        button.tag = 300+i;
        [button addTarget:self action:@selector(againClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
    }
    scrollView.contentSize = CGSizeMake(_dataArray.count*60, 30);
    scrollView.contentOffset = CGPointZero;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:scrollView];
}
-(void)againClick:(UIButton *)button{
    DoubleModel *model = _dataArray[button.tag-300];
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.fatherVC presentViewController:personal animated:YES completion:^{
        
    }];}
-(void)headerClick{
        PersonalViewController *personal = [[PersonalViewController alloc]init];
        personal.uid = _model.Uid;
        personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        personal.hidesBottomBarWhenPushed = YES;
        [self.fatherVC presentViewController:personal animated:YES completion:^{
            
        }];

}
-(void)more{
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    moreVC.dataArray = _dataArray;
    [self.fatherVC presentViewController:moreVC animated:YES completion:^{
        
    }];
}
-(void)click:(UIButton *)button{
    self.selectedButton.selected = NO;
    [self.selectedButton setBackgroundColor:[UIColor grayColor]];
    button.selected = YES;
    [button setBackgroundColor:[UIColor whiteColor]];
    self.selectedButton = button;
    [self.selectedButton setBackgroundColor:[UIColor whiteColor]];
    [_dataArray removeAllObjects];
    [scrollView removeFromSuperview];
    if(button.tag == 200){
        moreButton.alpha = 0.5;
        self.listArray = _model.LikeList;
        for(NSDictionary *dic in self.listArray){
            DoubleModel *model = [DoubleModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        [self creatScrollView];
    }else if (button.tag == 201){
        moreButton.alpha = 0;
        self.listArray = _model.ReplyList;
        for(NSDictionary *dic in self.listArray){
            DoubleModel *model = [DoubleModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        [self creatScrollView];
    }else if (button.tag == 202){
        moreButton.alpha = 0;
        self.listArray = _model.JoinList;
        for(NSDictionary *dic in self.listArray){
            DoubleModel *model = [DoubleModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        [self creatScrollView];
    }
}
-(void)finishCellWithModel:(TravelDetailModel *)model{
    NSMutableArray *myPicArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in model.PicList){
        [myPicArray addObject:[dic objectForKey:@"Url"]];
    }
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    [self.ageButton setTitle:[NSString stringWithFormat:@"%@岁",model.Age] forState:UIControlStateNormal];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 想去%@",model.MaritalStatus,model.WantGo];
    self.decLabel.text = model.Remark;
    self.decLabel.numberOfLines = 0;
    //图片
    if(_model.PicList.count >0){
        UIImageView *firstView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [firstView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[0]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [firstButton addSubview:firstView];
    }
    if(_model.PicList.count>1){
        UIImageView *secView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [secView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[1]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [secButton addSubview:secView];
    }
    if(_model.PicList.count>2){
        UIImageView *thirdView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [thirdView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[2]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [thirdButton addSubview:thirdView];
    }
    if(_model.PicList.count>3){
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, (SCREENW-40)/3, 20)];
        numLabel.text = [NSString stringWithFormat:@"共%d张图片",model.PicList.count];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        //numLabel.backgroundColor = [UIColor blackColor];
        numLabel.font = [UIFont boldSystemFontOfSize:13];
        [thirdButton insertSubview:numLabel atIndex:2];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
