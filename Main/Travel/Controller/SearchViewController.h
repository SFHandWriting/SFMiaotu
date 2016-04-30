//
//  SearchViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *encode;
}
@property (nonatomic,strong)UIButton *selectedButton;
@end
