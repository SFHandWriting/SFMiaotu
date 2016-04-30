//
//  likeButton.m
//  妙途
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "likeButton.h"

@implementation likeButton
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
    return CGRectMake(8, 18 , 20, 15);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(5 ,0   , 20,  20);
}

@end
