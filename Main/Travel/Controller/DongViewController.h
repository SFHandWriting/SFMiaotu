//
//  DongViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DongViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *Uid;

@end
