//
//  MessageCell.h
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *title;
-(void)finish;
@end
