//
//  MoneyButton.m
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "MoneyButton.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation MoneyButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//自定义tabBarButton上文字和图片的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(15, 0 , 55, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 6 , 10, 12);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
