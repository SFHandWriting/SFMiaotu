//
//  DoubleModel.h
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubleModel : NSObject
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSString *Created;
@property (nonatomic,copy)NSString *Content;
+ (id)initWithDict:(NSDictionary *)dict;
@end
