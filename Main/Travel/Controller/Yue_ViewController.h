//
//  Yue_ViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Yue_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *view;
    UIView *view2;
}
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *type;
@end
