//
//  CommendModel.m
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "CommendModel.h"

@implementation CommendModel
- (id)initWithDict:(NSDictionary *)dict
{
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (id)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

// 容错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if ([key isEqualToString:@"id"]) {
    //        self.idStr = value;
    //    }
}
@end
