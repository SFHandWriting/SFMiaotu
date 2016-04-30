//
//  Btn.m
//  妙途
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "Btn.h"

@implementation Btn
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(10, 0 , 15, 10);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(2 , 0 , 10,  10);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
