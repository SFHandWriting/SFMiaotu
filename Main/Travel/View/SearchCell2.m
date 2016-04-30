//
//  SearchCell2.m
//  妙途
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SearchCell2.h"
#import "FindpeopleViewController.h"
#import "UIImageView+WebCache.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation SearchCell2
-(void)setModel:(ItemsModel2 *)model{
    _model = model;
    [self creatUI];
}
-(void)creatUI{
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.contentView addSubview:self.headView];
    
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 100, 15)];
    self.nickLabel.textColor = [UIColor grayColor];
    self.nickLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nickLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 28, SCREENW-75, 10)];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.alpha = 0.8;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview: self.timeLabel];
    
    CGRect rect = [_model.Title boundingRectWithSize:CGSizeMake(SCREENW-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 45, SCREENW-75, rect.size.height)];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor grayColor];
    
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.titleLabel];
    
    if(self.row == 2){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 55+rect.size.height, SCREENW, 30);
        [button addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, (SCREENW-200), 30)];
        label.text = @"查看更多普通约游";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor orangeColor];
        label.font = [UIFont systemFontOfSize:12];
        label.alpha = 0.7;
        [button addSubview:label];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, SCREENW, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.5;
        [button addSubview:line];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-135 , 10, 10, 10)];
        view.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
        [button addSubview:view];
        UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-130, 10, 10, 10)];
        view2.image = [UIImage imageNamed:@"icon_publish_together_go.png"];
        [button addSubview:view2];
        [self.contentView addSubview:button];
    }
}
-(void)more{
    FindpeopleViewController *findVC = [[FindpeopleViewController alloc]init];
    findVC.text = @"妙旅团搜索结果";
    findVC.keywords = self.keywords;
    [self.fatherVC presentViewController:findVC animated:YES completion:^{
        
    }];
}
-(void)finishCellWithModel:(ItemsModel2 *)model{
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    self.headView.layer.cornerRadius = 15;
    self.headView.layer.masksToBounds = YES;
    
    self.nickLabel.text = model.Nickname;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.StartDate];
    self.titleLabel.text = model.Title;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
