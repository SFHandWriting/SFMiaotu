//
//  RequestViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface RequestViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate>
{
  
}
@property (nonatomic,copy)NSString *string;
@property (nonatomic,strong)FirstModel *model;
@property (nonatomic,strong)UIButton *selectedButton;
@end
