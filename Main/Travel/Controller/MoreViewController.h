//
//  MoreViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleModel.h"
@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSMutableArray *dataArray;
@end
