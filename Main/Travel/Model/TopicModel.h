//
//  TopicModel.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property (nonatomic,copy)NSNumber *Tid;
@property (nonatomic,copy)NSString *PicUrl;
+initWithDict:(NSDictionary *)dict;
@end
