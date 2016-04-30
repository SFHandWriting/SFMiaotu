
//  PicChooseViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface PicChooseViewController : UIViewController<UITableViewDataSource,UIActionSheetDelegate,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property (nonatomic,strong)NSMutableArray *picArray;
@property (nonatomic,copy)NSString *string;
@property (nonatomic,strong)FirstModel *model;
@end
