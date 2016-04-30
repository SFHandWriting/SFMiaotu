//
//  FindpeopleViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindpeopleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *keywords;
@end
