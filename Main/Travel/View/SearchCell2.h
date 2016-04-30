//
//  SearchCell2.h
//  妙途
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemsModel2.h"
@interface SearchCell2 : UITableViewCell
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,strong)UIViewController *fatherVC;
@property (nonatomic,strong)ItemsModel2 *model;
@property (nonatomic,strong)UIImageView *headView;
@property (nonatomic,strong)UILabel *nickLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *titleLabel;
-(void)finishCellWithModel:(ItemsModel2 *)model;
@end
