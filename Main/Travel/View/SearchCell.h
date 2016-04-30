//
//  SearchCell.h
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemsModel.h"
@interface SearchCell : UITableViewCell
@property (nonatomic,strong)NSString *keywords;
@property (nonatomic,strong)UIViewController *fatherVC;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,strong)ItemsModel *model;
@property (nonatomic,strong)UIImageView *headView;
@property (nonatomic,strong)UILabel *nickLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *remarkLabel;
@end
