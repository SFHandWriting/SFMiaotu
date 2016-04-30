//
//  FocusCell.h
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"
@interface FocusCell : UITableViewCell
@property (nonatomic,strong)UIButton *headButton;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *remarkLabel;
@property (nonatomic,strong)UIImageView *yellowView;
@property (nonatomic,strong)CommendModel *model;
@property (nonatomic,strong)UIViewController *fatherVC;
-(void)finishCellWithModel:(CommendModel *)model;
@end
