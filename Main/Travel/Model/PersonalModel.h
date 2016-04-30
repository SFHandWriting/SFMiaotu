//
//  PersonalModel.h
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalModel : NSObject
@property (nonatomic,copy)NSString *Url;
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *Created;
@property (nonatomic,copy)NSNumber *Sid;
@property (nonatomic,copy)NSNumber *StateReplyCount;
@property (nonatomic,copy)NSNumber *StateLikeCount;
@property (nonatomic,assign)Boolean *IsLike;
+ (id)initWithDict:(NSDictionary *)dict;
@end
