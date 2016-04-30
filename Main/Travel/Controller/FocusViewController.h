//
//  FocusViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *view;
}
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,assign)NSInteger state;
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UILabel *selectedLabel;
@end
