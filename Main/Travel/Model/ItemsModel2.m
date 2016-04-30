//
//  ItemsModel2.m
//  妙途
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "ItemsModel2.h"

@implementation ItemsModel2
- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
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
