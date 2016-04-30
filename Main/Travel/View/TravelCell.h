//
//  TravelCell.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemsModel.h"
#import "TopicModel.h"
#import "ageButton.h"
#import "TravelViewController.h"
@interface TravelCell : UITableViewCell
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,strong)ItemsModel *model;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)ageButton *ageButton;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,strong)UILabel *requestLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UIButton *firstButton;
@property (nonatomic,strong)UIButton *secButton;
@property (nonatomic,strong)UIButton *thirdButton;
@property (nonatomic,strong)UIButton *likeButton;
@property (nonatomic,strong)UIButton *markButton;
@property (nonatomic,strong)UIButton *joinButton;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic,copy)NSString *sub2;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,strong)UIViewController *FatherVC;
@property (nonatomic,strong)NSMutableArray *topicArray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIButton *selectedButton1;
-(void)finishCellWithModel:(ItemsModel *)model;
@end
