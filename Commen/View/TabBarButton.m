//
//  TabBarButton.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.3f];
    }
    return self;
}
//自定义tabBarButton上文字和图片的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, self.frame.size.height * 0.6, self.frame.size.width, self.frame.size.height * 0.4);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(35, self.frame.size.height * 0.1, self.frame.size.width*0.25,  self.frame.size.height * 0.5);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
