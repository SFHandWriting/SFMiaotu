//
//  FlikeButton.m
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FlikeButton.h"

@implementation FlikeButton
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
    return CGRectMake(17, 0 , 25, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(2 ,4   , 12,  12);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
