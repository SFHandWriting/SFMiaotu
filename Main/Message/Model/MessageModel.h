//
//  MessageModel.h
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic,copy)NSNumber *Id;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Created;
@property (nonatomic,copy)NSDictionary *Content;
@property (nonatomic,copy)NSNumber *Status;
+ (id)initWithDict:(NSDictionary *)dict;
@end
