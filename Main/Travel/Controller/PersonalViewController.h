//
//  PersonalViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PersonalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *dic;
}
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,assign)Boolean IsLike;
@end
