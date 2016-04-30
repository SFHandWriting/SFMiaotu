//
//  foButton.m
//  妙途
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "foButton.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation foButton
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake((SCREENW/3-60)/2, 20 , 60, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((SCREENW/3-20)/2 , 3 , 20,  20);
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
