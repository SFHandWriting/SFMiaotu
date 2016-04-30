//
//  CommendViewController.h
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic,copy)NSString *type;//判断从哪进入的评论界面
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *yid;
@property (nonatomic,copy)NSString *aid;
@property (nonatomic,copy)NSString *num;
@property (nonatomic,copy)NSString *page;
@property (nonatomic,copy)NSString *string;
@end
