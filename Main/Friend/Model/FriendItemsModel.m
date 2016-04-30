//
//  FriendItemsModel.m
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FriendItemsModel.h"

@implementation FriendItemsModel
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
