//
//  CommendModel.h
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommendModel : NSObject
@property(nonatomic,copy)NSString *Uid;
@property(nonatomic,copy)NSString *HeadUrl;
@property(nonatomic,copy)NSString *Nickname;
@property(nonatomic,copy)NSString *Created;
@property(nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *State;
@property (nonatomic,copy)NSString *Yid;
+ (id)initWithDict:(NSDictionary *)dict;

@end
