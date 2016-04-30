//
//  chatButton.m
//  妙途
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "chatButton.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation chatButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(SCREENW/6+25, 10 , 40, 25);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake( SCREENW/6, 12   , 20,  22);
}
@end
