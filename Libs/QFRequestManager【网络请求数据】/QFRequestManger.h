//
//  QFRequestManger.h
//  web1_(NSURLConnection封装)
//
//  Created by 朱磊 on 15-8-31.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFRequest.h"
@interface QFRequestManger : NSObject
+(void)requestWithUrl:(NSString *)url IsCache:(BOOL)isCache finish:(void(^)(NSData *data))finishBlock failed:(void(^)())failedBlock;

@end
