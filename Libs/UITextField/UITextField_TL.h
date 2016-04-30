//
//  UITextField_TL.h
//  123
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField_TL : UITextField
+(UITextField *)creatTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderstyle tag:(NSInteger)tag placeholder:(NSString *)placehorder clearButtonMode:(UITextFieldViewMode)clearButtonMode secureTextEntry:(BOOL)Issecure font:(NSInteger)font boldFont:(BOOL)bold;
@end
