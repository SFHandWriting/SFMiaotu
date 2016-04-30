//
//  myTabBarButton.m
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "myTabBarButton.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation myTabBarButton
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake((SCREENW/6-20)/2, 25 , 20, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((SCREENW/6-20)/2 , 10   , 20,  18);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
