//
//  PersonalCell.m
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "PersonalCell.h"
#import "ageButton2.h"
#import "MyadView_new.h"
#import "AllPicsViewController.h"
#import "PicViewController.h"
#import "DongViewController.h"
#import "Yue_ViewController.h"
#import "FocusViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define yueUrl @"http://api.miaotu.com/v1.1/user/yueyou/owner?token=%@&uid=%@&type=owner&page=1&num=20"
#import "UIImageView+WebCache.h"
@implementation PersonalCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(PersonModel2 *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
   //背景图
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 200)];
    if([_model.PicUrl isEqualToString:@""]){
    backView.image = [UIImage imageNamed:@"icon_default_background1.png"];
    }else{
        [backView sd_setImageWithURL:[NSURL URLWithString:_model.PicUrl] placeholderImage:[UIImage imageNamed:@"icon_default_background1.png"]];
    }
    backView.userInteractionEnabled = YES;
    backView.alpha = 0.8;
    //1.头像
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = CGRectMake((SCREENW-50)/2, 50, 50, 50);
    headButton.layer.cornerRadius = 25;
    headButton.layer.masksToBounds = YES;
    [headButton addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW-50)/2, 50, 50, 50)];
    headView.layer.cornerRadius = 25;
    headView.layer.masksToBounds = YES;
    [headView sd_setImageWithURL:[NSURL URLWithString:_model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [backView addSubview:headView];
    [backView addSubview:headButton];
    //2.age
    ageButton2 *ageBtn= [[ageButton2 alloc]initWithFrame:CGRectMake((SCREENW-50)/2+30, 90, 30, 14)];
    if([_model.Gender isEqualToString:@"女"]){
        ageBtn.backgroundColor = [UIColor redColor];
        [ageBtn setImage:[UIImage imageNamed:@"icon_girl.png"] forState:UIControlStateNormal];
    }else{
        ageBtn.backgroundColor = [UIColor blueColor];
        [ageBtn setImage:[UIImage imageNamed:@"icon_boy.png"] forState:UIControlStateNormal];
    }
    ageBtn.alpha = 0.7;
    [ageBtn setTitle:[NSString stringWithFormat:@"%@",_model.Age] forState:UIControlStateNormal];
    ageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    ageBtn.titleLabel.textColor = [UIColor whiteColor];
    ageBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:ageBtn];
    //3.nickname
    UILabel *nickName = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-50)/2-25, 110, 100, 30)];
    nickName.text = _model.Nickname;
    nickName.textAlignment = NSTextAlignmentCenter;
    nickName.font = [UIFont systemFontOfSize:14];
    nickName.textColor = [UIColor whiteColor];
    [backView addSubview:nickName];
    [self.contentView addSubview:backView];
    //四项
    UIView *fourView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREENW, 40)];
    NSArray *array = @[@"关注",@"粉丝",@"情感",@"想去"];
    for(int i=0;i<4;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREENW/4, 0, SCREENW/4, 40);
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW/4, 20)];
        label1.text = array[i];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor orangeColor];
        label1.font = [UIFont systemFontOfSize:12];
        label1.alpha = 0.7;
        [button addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREENW/4, 20)];
        if(i==0){
            label2.text = [NSString stringWithFormat:@"%@",_model.LikeCount];
        }else if (i==1){
            label2.text = [NSString stringWithFormat:@"%@",_model.LikedCount];
        }else if (i==2){
            label2.text = _model.MaritalStatus;
        }else if (i==3){
            label2.text = _model.WantGo;
        }
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor blackColor];
        label2.font = [UIFont systemFontOfSize:10];
        label2.alpha = 0.6;
        [button addSubview:label2];
        if(i==0 || i==1){
            [button addTarget:self action:@selector(left2:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100+i;
        }
        [fourView addSubview:button];
    }
    [self.contentView addSubview:fourView];
    //图片墙
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, 240, SCREENW, 40)];
    picView.backgroundColor = [UIColor grayColor];
    picView.alpha = 0.4;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text = @"图片墙";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [picView addSubview:label];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, SCREENW, 0.5)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.4;
    [picView addSubview:line];
    [self.contentView addSubview:picView];
    //图片
    urlArray = [[NSMutableArray alloc]init];
    for(PersonalModel *model in self.itemsArray){
        [urlArray addObject:model.Url];
    }
    if(urlArray.count>0){
    MyadView_new *adView = [[MyadView_new alloc]initWithFramex:0 y:280 width:SCREENW height:(SCREENW-30)/3+10 Auto:NO time:0 circle:NO PictureNameArray:nil pictureUrlArray:urlArray scrollViewFramex:0 y:0 width:SCREENW height:(SCREENW-30)/3+10 pageControlFramex:0 y:0 width:0 height:0 labelFrame:CGRectMake(0, 0, 0, 0) labelBackGroundColor:nil textFont:0 modelArray:self.array];
    adView.fVC = self.fVC;
    [self.contentView addSubview:adView];
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.frame = CGRectMake(SCREENW-150, 10, 140, 20);
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 20)];
        label3.text = @"查看全部";
        label3.textColor = [UIColor orangeColor];
        label3.font = [UIFont systemFontOfSize:15];
        label3.textAlignment = NSTextAlignmentCenter;
        [otherButton addSubview:label3];
        [otherButton addTarget:self action:@selector(other) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(110, 4, 10, 10)];
        view.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
        [otherButton addSubview:view];
        UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 4, 10, 10)];
        view2.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
        [otherButton addSubview:view2];
        [picView addSubview:otherButton];
        [self.contentView addSubview:picView];
    }else{
        UIView *nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, SCREENW, (SCREENW-30)/3+10)];
        nilView.backgroundColor = [UIColor grayColor];
        nilView.alpha = 0.4;
        UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREENW-50, 50)];
        message.text = @"TA发布的照片动态将会显示在这里~";
        message.textColor = [UIColor blackColor];
        message.textAlignment = NSTextAlignmentCenter;
        message.font = [UIFont systemFontOfSize:14];
        [nilView addSubview:message];
        [self.contentView addSubview:nilView];
    }
    
    
    
    //约游
    
    UIView *togetherView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+290, SCREENW, 40)];
    UILabel *lib = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 0.5)];
    lib.backgroundColor = [UIColor blackColor];
    lib.alpha = 0.3;
    [togetherView addSubview:lib];
    togetherView.backgroundColor = [UIColor grayColor];
    togetherView.alpha = 0.4;
    UILabel *taLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    taLabel.text = @"TA的约游";
    taLabel.textColor = [UIColor blackColor];
    taLabel.font = [UIFont systemFontOfSize:12];
    [togetherView addSubview:taLabel];
    [self.contentView addSubview:togetherView];
    //3GE
    UIView *viewd = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+330, SCREENW, 120)];
    NSArray *arrays = @[@"mine_faqide.png",@"mine_yibaomingde.png",@"mine_xihuande.png",@"TA发起的约游",@"TA报名的约游",@"TA喜欢的约游"];
    for(int i=0;i<3;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*40, SCREENW, 40);
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, SCREENW, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.4;
        [button addSubview:line];
        [button addTarget:self action:@selector(TA:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200+i;
        [button setBackgroundColor:[UIColor whiteColor]];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        view.image = [UIImage imageNamed:arrays[i]];
        [button addSubview:view];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 20)];
        label.text = arrays[i+3];
        label.alpha = 0.4;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        [button addSubview:label];
        UIImageView *v = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-20, 15, 10, 10)];
        v.image = [UIImage imageNamed:@"icon_together_publish_location_select.png"];
        [button addSubview:v];
        [viewd addSubview:button];
    }
    [self.contentView addSubview:viewd];
    //动态
    UIView *moveView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+450, SCREENW, 40)];
    moveView.backgroundColor = [UIColor grayColor];
    moveView.alpha = 0.4;
    UILabel *taLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    taLabel6.text = @"动态";
    taLabel6.textColor = [UIColor blackColor];
    taLabel6.font = [UIFont systemFontOfSize:12];
    [moveView addSubview:taLabel6];
    [self.contentView addSubview:moveView];
    
    UIView *viewr = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+490, SCREENW, 40)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREENW, 40);
    btn.tag = 203;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(TA:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *view0 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    view0.image = [UIImage imageNamed:@"mine_dongtai.png"];
    [btn addSubview:view0];
    UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 20)];
    label0.text = @"TA的动态";
    label0.textColor = [UIColor blackColor];
    label0.alpha = 0.4;
    label0.font = [UIFont systemFontOfSize:15];
    [btn addSubview:label0];
    UIImageView *v0 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-20, 15, 10, 10)];
    v0.image = [UIImage imageNamed:@"icon_together_publish_location_select.png"];
    [btn addSubview:v0];
    [viewr addSubview:btn];
    [self.contentView addSubview:viewr];
    //个人资料
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREENW-30)/3+530, SCREENW, 40)];
    myView.backgroundColor = [UIColor grayColor];
    myView.alpha = 0.4;
    UILabel *taLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    taLabel7.text = @"个人资料";
    taLabel7.textColor = [UIColor blackColor];
    taLabel7.font = [UIFont systemFontOfSize:12];
    [myView addSubview:taLabel7];
    [self.contentView addSubview:myView];
    //个人zl详情
    NSMutableArray *name = [[NSMutableArray alloc]initWithObjects:@"Country",@"Province",@"City",@"Home",@"LifeArea",@"WorkArea",@"FreeTime",@"Hobbies",@"AboutMe",@"Work",@"Birthday",@"Phone",@"Email",@"Education",@"GraduateSchool",@"Tags", @"Hobbies",nil];
    NSMutableArray *word = [[NSMutableArray alloc]initWithObjects:@"国家",@"省份",@"城市",@"家乡",@"生活在",@"工作在",@"有闲",@"爱好",@"自我评价",@"职业",@"生日",@"电话",@"Email",@"学历",@"毕业院校",@"个性签名",@"",nil];
    NSInteger y=(SCREENW-30)/3+530;
    for(int i=0;i<16;i++){
        y =y+40;
        if([[self.dic objectForKey:name[i]]isEqualToString:@""]){
            y=y-40;
            continue;
        }
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREENW, 40)];
    UILabel *labels1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    labels1.text = word[i];
    labels1.textColor = [UIColor blackColor];
        labels1.alpha = 0.4;
    labels1.font = [UIFont systemFontOfSize:12];
    [views addSubview:labels1];
    UILabel *labels2 = [[UILabel alloc]initWithFrame:CGRectMake(150, 10, 200, 20)];
    labels2.text = [self.dic objectForKey:name[i]];
    labels2.textColor = [UIColor blackColor];
        labels2.alpha = 0.4;
    labels2.font = [UIFont systemFontOfSize:12];
    [views addSubview:labels2];
    
    UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(70, 12, 0.5, 16)];
    lines.backgroundColor = [UIColor grayColor];
    lines.alpha = 0.5;
    [views addSubview:lines];
        UILabel *li = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, SCREENW, 0.5)];
        li.backgroundColor = [UIColor grayColor];
        li.alpha = 0.5;
        [views addSubview:li];
    [self.contentView addSubview:views];
    }
}
-(void)headClick{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k = 0;
    picVC.picUrl = _model.HeadUrl;
    [self.fVC presentViewController:picVC animated:YES completion:^{
        
    }];
}
-(void)left2:(UIButton *)button{
    if(button.tag == 100){
        FocusViewController *focus = [[FocusViewController alloc]init];
        focus.state = 0;
        focus.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.Uid = _model.Uid;
        focus.type = @"like";
        [self.fVC presentViewController:focus animated:YES completion:^{
            focus.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
            focus.Uid = _model.Uid;
        }];
    }else{
        FocusViewController *focus = [[FocusViewController alloc]init];
        focus.state = 1;
        focus.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.Uid = _model.Uid;
        focus.type = @"liked";
        [self.fVC presentViewController:focus animated:YES completion:^{
            
        }];
    }
}
-(void)other{
    AllPicsViewController *allVC = [[AllPicsViewController alloc]init];
    allVC.picUrlArray =urlArray;
    [self.fVC presentViewController:allVC animated:YES completion:^{
        
    }];
}
-(void)TA:(UIButton *)button{
    if(button.tag == 200){
        Yue_ViewController *yue = [[Yue_ViewController alloc]init];
        yue.Uid = _model.Uid;
        yue.title = @"TA发起的约游";
        yue.type = @"owner";
        [self.fVC presentViewController:yue animated:YES completion:^{
            
        }];
    }else if (button.tag == 201){
        Yue_ViewController *yue = [[Yue_ViewController alloc]init];
        yue.Uid = _model.Uid;
        yue.title = @"TA报名的约游";
        yue.type = @"join";
        [self.fVC presentViewController:yue animated:YES completion:^{
            
        }];
    }else if (button.tag == 202){
        Yue_ViewController *yue = [[Yue_ViewController alloc]init];
        yue.Uid = _model.Uid;
        yue.title = @"TA喜欢的约游";
        yue.type = @"like";
        [self.fVC presentViewController:yue animated:YES completion:^{
            
        }];
    }else if (button.tag == 203){
        DongViewController *dong = [[DongViewController alloc]init];
        dong.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        dong.Uid = _model.Uid;
        [self.fVC presentViewController:dong animated:YES completion:^{
            
        }];
    }
}
@end
