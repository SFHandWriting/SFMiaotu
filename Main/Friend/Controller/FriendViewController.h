//
//  FriendViewController.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "BaseViewController.h"

@interface FriendViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UILabel *selectedlabel;
@end
