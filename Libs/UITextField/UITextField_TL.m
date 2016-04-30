//
//  UITextField_TL.m
//  123
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import "UITextField_TL.h"

@implementation UITextField_TL

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(UITextField *)creatTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderstyle tag:(NSInteger)tag placeholder:(NSString *)placehorder clearButtonMode:(UITextFieldViewMode)clearButtonMode secureTextEntry:(BOOL)Issecure font:(NSInteger)font boldFont:(BOOL)bold{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.borderStyle = borderstyle;
    textField.textColor = [UIColor blackColor];
    textField.alpha = 0.6;
    textField.tag = tag;
    textField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    textField.placeholder = placehorder;
    textField.clearButtonMode = clearButtonMode;
    textField.secureTextEntry = Issecure;
    if(bold){
        textField.font = [UIFont boldSystemFontOfSize:font];
    }else{
        textField.font = [UIFont systemFontOfSize:font];
    }
    return textField;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
