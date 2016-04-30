//
//  TeamCell.h
//  妙途
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemsModel2.h"
@interface TeamCell : UITableViewCell
@property (nonatomic,strong)UIImageView *PicVIew;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *remarkLabel;
@property (nonatomic,copy)ItemsModel2 *model;
@property (nonatomic,strong)UIViewController *fatherVC;
@end
