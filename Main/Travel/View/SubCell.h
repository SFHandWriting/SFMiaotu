//
//  SubCell.h
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleModel.h"
@interface SubCell : UITableViewCell
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,copy)UIViewController *fatherVC;
@property (nonatomic,copy)DoubleModel *model;
@end
