//
//  TravelCell.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define likeUrl @"http://api.miaotu.com/v1.1/yueyou/like"
#define joinUrl @"http://api.miaotu.com/v1.1/yueyou/join"
#import "TravelCell.h"
#import "AFNetworking.h"
#import "PersonalViewController.h"
#import "cellButton.h"
#import "PicViewController.h"
#import "UIImageView+WebCache.h"
#import "UIView_adNew.h"
#import "CommendViewController.h"
@implementation TravelCell
{
    NSMutableArray *titleArray;
}
- (void)awakeFromNib {

}

-(void)setModel:(ItemsModel *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    //推荐
    if(_model.IsTop){
    UIImageView *oraView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-30, 0, 30, 30)];
    oraView.image = [UIImage imageNamed:@"icon_top.png"];
    [self.contentView addSubview:oraView];
    }
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
    //dec
    CGRect rect = [_model.Remark boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    self.decLabel.font = [UIFont systemFontOfSize:16];
    self.decLabel.numberOfLines = 0 ;
    self.decLabel.alpha = 0.5;
    [self.contentView addSubview:self.decLabel];
    
    //建一个view来放dec下面的UI，因为下面的不变了
    UIView *view = [[UIView alloc]init];
    if(self.row == 0){
    view.frame = CGRectMake(0, 45+rect.size.height, SCREENW, 290);
    }else{
        view.frame = CGRectMake(0, 45+rect.size.height, SCREENW, 210);
    }
    [self.contentView addSubview:view];
    //间隔
    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, SCREENW, 10)];
    colorLabel.backgroundColor = [UIColor grayColor];
    colorLabel.alpha = 0.2;
    [view addSubview:colorLabel];
    //request
    self.requestLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENW-15, 20)];
    self.requestLabel.font = [UIFont systemFontOfSize:12];
    self.requestLabel.textColor = [UIColor blueColor];
    self.requestLabel.alpha = 0.7;
    [view addSubview:self.requestLabel];
    //money
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREENW-50, 20)];
    self.moneyLabel.font = [UIFont systemFontOfSize:12];
    self.moneyLabel.textColor = [UIColor blueColor];
    self.moneyLabel.alpha = 0.7;
    [view addSubview:self.moneyLabel];
    if(_model.PicList.count>0){
        //first
        self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.firstButton.frame = CGRectMake(10, 45, (SCREENW-40)/3, (SCREENW-30)/3);
        self.firstButton.tag =200;
        [self.firstButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.firstButton];
    }
    if(_model.PicList.count>1){
        //sec
        self.secButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.secButton.frame = CGRectMake(20+(SCREENW-40)/3, 45, (SCREENW-40)/3, (SCREENW-30)/3);
        self.secButton.tag = 201;
        [self.secButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.secButton];
    }
    if(_model.PicList.count>2){
        //third
        self.thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.thirdButton.frame = CGRectMake(30+2*(SCREENW-40)/3, 45, (SCREENW-40)/3, (SCREENW-30)/3);
        self.thirdButton.tag = 202;
        [self.thirdButton addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.thirdButton];
    }    //line
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+55, SCREENW, 0.3)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [view addSubview:line];
    //button
    NSArray *array = @[@"icon_together_like.png",@"icon_together_comment.png",@""];
    titleArray = [[NSMutableArray alloc]init];
    [titleArray addObject:[NSString stringWithFormat:@"%@",_model.YueyouLikeCount]];
    [titleArray addObject:[NSString stringWithFormat:@"%@",_model.YueyouReplyCount]];
    [titleArray addObject:@"入伙"];
    for(int i=0;i<3;i++){
        cellButton *button = [cellButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*(SCREENW-30)/3,(SCREENW-30)/3+55 , (SCREENW-30)/3, 30);
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.alpha = 0.7;
        if(i==2){
            if(_model.IsJoin){
                [button setTitle:@"已入伙" forState:UIControlStateNormal];
            }else{
                [button setTitle:titleArray[i] forState:UIControlStateNormal];
            }
        }else{
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        }
        if(i==0){
            if(_model.IsLike){
                [button setImage:[UIImage imageNamed:@"icon_together_like_solid.png"] forState:UIControlStateNormal];
            }else{
                [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
            }
        }else{
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if(i!=2){
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-30)/3+5, 5, 0.5, 20)];
        lineLabel.backgroundColor = [UIColor grayColor];
        lineLabel.alpha = 0.5;
        [button addSubview:lineLabel];
        }
        [view addSubview:button];
    }
    if(self.num==1){
    //加专题
    if(self.row == 0){
        NSMutableArray *urlArray = [[NSMutableArray alloc]init];
        NSMutableArray *tidArray = [[NSMutableArray alloc]init];
        for(TopicModel *model in self.topicArray){
            [urlArray addObject:model.PicUrl];
            [tidArray addObject:model.Tid];
        }
        UIView_adNew *adView = [[UIView_adNew alloc]initWithFramex:10 y:210 width:SCREENW-10 height:80 Auto:NO time:0 circle:NO PictureNameArray:nil pictureUrlArray:urlArray scrollViewFramex:0 y:0 width:SCREENW-10 height:80 pageControlFramex:0 y:0 width:0 height:0 labelFrame:CGRectMake(0, 0, 0, 0) labelBackGroundColor:nil textFont:0 modelArray:nil];
        adView.tidArray = tidArray;
        adView.fVC = self.FatherVC;
        [view addSubview:adView];
    }
    }
}
//点击图片
-(void)imageclick:(UIButton *)button{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=2;
    picVC.picArray = _model.PicList;
    [self.FatherVC presentViewController:picVC animated:YES completion:^{
        
    }];
}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.IsLike = _model.IsLike;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self.FatherVC presentViewController:personal animated:YES completion:^{
        
    }];
}
-(void)finishCellWithModel:(ItemsModel *)model{
    NSMutableArray *myPicArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in _model.PicList){
        [myPicArray addObject:[dic objectForKey:@"Url"]];
    }
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [self.headerButton addSubview:headerView];
    self.nickNameLabel.text = model.Nickname;
    [self.ageButton setTitle:[NSString stringWithFormat:@"%@岁",model.Age] forState:UIControlStateNormal];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ | %@km",model.Created,model.Distance];
    self.decLabel.text = model.Remark;
    self.decLabel.font = [UIFont systemFontOfSize:13];
    self.decLabel.numberOfLines = 0;
    self.requestLabel.text = [NSString stringWithFormat:@"* %@",model.Require];
    self.moneyLabel.text = [NSString stringWithFormat:@"* 费用: %@",model.MoneyType];
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
    if(model.PicList.count>3){
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, (SCREENW-40)/3, 20)];
        numLabel.text = [NSString stringWithFormat:@"共%d张图片",model.PicList.count];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        //numLabel.backgroundColor = [UIColor blackColor];
        numLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.thirdButton insertSubview:numLabel atIndex:2];
    }
}
-(void)click:(cellButton *)button{
    //喜欢--评论--入伙
    if(button.tag == 100){
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",_model.Yid,@"yid", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:likeUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:nil];   
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        }else if (button.tag == 101){
        CommendViewController *commendVC = [[CommendViewController alloc]init];
        commendVC.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        commendVC.yid =  _model.Yid;
        commendVC.type = @"yueyou";
        commendVC.hidesBottomBarWhenPushed = YES;
        [self.FatherVC presentViewController:commendVC animated:YES completion:^{
            
        }];
    }else if (button.tag == 102){
        if(self.model.IsJoin){
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经入伙了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else{
        NSString *encode = [NSString stringWithString:[@"" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",_model.Yid,@"yid",encode,@"name",@"1",@"phone", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:joinUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:@"NO"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        }
    }else{
     
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
