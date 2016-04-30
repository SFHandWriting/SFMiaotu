//
//  ageButton2.m
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "ageButton2.h"

@implementation ageButton2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, -1 , 27, 16);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0 , 1.2 , 12,  13);
}
@end
