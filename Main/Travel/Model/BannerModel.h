//
//  BannerModel.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,strong)NSString *Extend;
@property (nonatomic,strong)NSString *PicUrl;
+ (id)initWithDict:(NSDictionary *)dict;
@end
