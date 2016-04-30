//
//  TabBar.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBar : UITabBar
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,copy)void(^buttonIndex)(NSInteger index);
@end
