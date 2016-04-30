//
//  QFRequest.h
//  web1_(NSURLConnection封装)
//
//  Created by 朱磊 on 15-8-31.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QFRequest : NSObject<NSURLConnectionDataDelegate>{
    
    //用来接收返回的数据
    NSMutableData *_myData;
}

//先写做网络请求需要的属性

//网络请求的接口
@property (nonatomic,copy)NSString *url;
//是否缓存
@property (nonatomic,assign)BOOL isCache;
//网络请求结束后调用的block
@property (nonatomic,copy)void(^finishBlock)(NSData *data);
//网络请求失败后调用的block
@property (nonatomic,copy)void(^failedBlock)();
//开始网络请求
-(void)startRequest;

@end
