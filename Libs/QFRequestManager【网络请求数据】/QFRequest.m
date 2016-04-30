//
//  QFRequest.m
//  web1_(NSURLConnection封装)
//
//  Created by 朱磊 on 15-8-31.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import "QFRequest.h"
//MD5加密方式
#import "NSString+Hashing.h"
@implementation QFRequest

//初始化方法
-(id)init{
    
    if (self = [super init]) {
        //在初始化方法里 初始化data
        _myData = [[NSMutableData alloc]init];
    }
    return self;
}
//执行.h方法
-(void)startRequest{
        //先判断一下 是否用缓存，缓存里有没有数据
    if (self.isCache) {
        
        //先把缓存的路径找到
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/%@",[self.url MD5Hash]];
        
        //再判断当前路径下 是否有文件
        NSFileManager *manger = [NSFileManager defaultManager];
        //如果文件存在于path目录下
        if ([manger fileExistsAtPath:path]) {
            
            //用path生成一个data对象 然后返回给finishBlock 然后return
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            self.finishBlock(data);
            
            return;
        }
    }
    
    //如果没有使用缓存 或者缓存里没数据 那么进行网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
//收到请求后 作出的响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downdata" object:@"start"];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [_myData appendData:data];
}
//请求结束后，返回了所有的请求数据
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downfinished" object:@"finish"];
    //先判断是否需要做缓存
    //如果需要缓存的话，把所有返回的数据存储到沙盒目录下
    if (self.isCache) {
        
        //先找到缓存路径
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/%@",[self.url MD5Hash]];
        //把所有的数据 写入路径里
        [_myData writeToFile:path atomically:YES];
    }
    
    //还要把_myData 传给用到数据的类里面
    self.finishBlock(_myData);
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"网络请求失败");
}
@end
