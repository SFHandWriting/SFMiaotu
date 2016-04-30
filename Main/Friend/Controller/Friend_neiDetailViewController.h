//
//  Friend_neiDetailViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendItemsModel.h"
@interface Friend_neiDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic,strong)FriendItemsModel *model;
@property (nonatomic,copy)NSString *Sid;
@property (nonatomic,copy)NSString *string;
@end
