//
//  EndViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface EndViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy)NSString *string;
@property (nonatomic,strong)FirstModel *model;
@end
