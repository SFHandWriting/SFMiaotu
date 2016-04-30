//
//  TravelDetailModel.m
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TravelDetailModel.h"

@implementation TravelDetailModel
- (id)initWithDict:(NSDictionary *)dict
{
    if ([super init]) {
        //self.MaritalStatus = dict[@"MaritalStatus"];
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
   
}
@end
