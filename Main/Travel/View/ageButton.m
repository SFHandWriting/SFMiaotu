
//
//  ageButton.m
//  妙途
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "ageButton.h"

@implementation ageButton
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(9, -1 , 30, 16);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0 , 1.2 , 12,  13);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
