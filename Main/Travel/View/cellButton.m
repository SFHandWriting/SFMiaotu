//
//  cellButton.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "cellButton.h"

@implementation cellButton
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
    return CGRectMake(65, 5 , 30, 15);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(45 , 5   , 15,  15);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
