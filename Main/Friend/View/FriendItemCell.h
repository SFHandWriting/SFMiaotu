//
//  FriendItemCell.h
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ageButton.h"
#import "likeButton.h"
#import "FlikeButton.h"
#import "FriendItemsModel.h"
@interface FriendItemCell : UITableViewCell
@property (nonatomic,strong)NSString *str;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)ageButton *ageButton;
@property (nonatomic,strong)UILabel *emotionLabel;
@property (nonatomic,strong)FlikeButton *likeButton;
@property (nonatomic,strong)UIButton *firstButton;
@property (nonatomic,strong)UIButton *secButton;
@property (nonatomic,strong)UIButton *thirdButton;
@property (nonatomic,strong)UILabel *wantLabel;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,strong)UILabel *distanceLabel;
@property (nonatomic,strong)FlikeButton *commentButton;
@property (nonatomic,copy)FriendItemsModel *model;
@property (nonatomic,strong)UIViewController *FatherVC;
-(void)finishCellWithModel:(FriendItemsModel *)model;
@end
