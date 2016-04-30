//
//  CommendCell.h
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"
#import "ItemsModel2.h"
@interface CommendCell : UITableViewCell
@property(nonatomic,strong)UIViewController *fatherVC;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,strong)CommendModel *model;
@property (nonatomic,strong)ItemsModel2 *model2;
-(void)finishCellWithModel2:(ItemsModel2 *)model;
-(void)finishCellWithModel:(CommendModel *)model;
@end
