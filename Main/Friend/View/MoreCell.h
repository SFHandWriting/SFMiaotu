//
//  MoreCell.h
//  妙途
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleModel.h"
@interface MoreCell : UITableViewCell
@property (nonatomic,assign)NSInteger state;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIViewController *fatherVC;
@property (nonatomic,strong)DoubleModel *model;
@end
