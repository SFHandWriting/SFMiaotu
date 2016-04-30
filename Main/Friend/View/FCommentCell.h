//
//  FCommentCell.h
//  妙途
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"
@interface FCommentCell : UITableViewCell
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,copy)CommendModel *model;
@property (nonatomic,strong)UIViewController *fatherVC;
-(void)finishCellWithModel:(CommendModel *)model;
@end
