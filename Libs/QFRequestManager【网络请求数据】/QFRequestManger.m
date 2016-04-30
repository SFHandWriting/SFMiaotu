//
//  QFRequestManger.m
//  web1_(NSURLConnection封装)
//
//  Created by 朱磊 on 15-8-31.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import "QFRequestManger.h"

@implementation QFRequestManger

+(void)requestWithUrl:(NSString *)url IsCache:(BOOL)isCache finish:(void (^)(NSData *))finishBlock failed:(void (^)())failedBlock{
    
    //创建QFRequest对象
    QFRequest *request = [[QFRequest alloc]init];
    
    request.url = url;
    request.isCache = isCache;
    request.finishBlock = finishBlock;
    request.failedBlock = failedBlock;
   
    [request startRequest];
    
    
}
@end
