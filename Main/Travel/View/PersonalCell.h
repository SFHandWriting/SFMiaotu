//
//  PersonalCell.h
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel2.h"
#import "PersonalModel.h"
@interface PersonalCell : UITableViewCell
{
    UIButton *thirdButton;
    NSMutableArray *urlArray;
}
@property (nonatomic,copy)NSMutableArray *itemsArray;
@property (nonatomic,copy)NSArray *array;
@property (nonatomic,copy)PersonModel2 *model;
@property (nonatomic,strong)UIViewController *fVC;
@property (nonatomic,copy)NSDictionary *dic;
@end
