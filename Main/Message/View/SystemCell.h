//
//  SystemCell.h
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface SystemCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)MessageModel *model;
@end
