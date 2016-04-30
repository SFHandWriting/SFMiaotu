//
//  ItemsModel.h
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsModel : NSObject
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSNumber *Age;
@property (nonatomic,copy)NSString *Created;
@property (nonatomic,copy)NSNumber *Distance;
@property (nonatomic,copy)NSString *Yid;
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *Require;
@property (nonatomic,copy)NSString *MoneyType;
@property (nonatomic,copy)NSNumber *YueyouLikeCount;
@property (nonatomic,copy)NSNumber *YueyouReplyCount;
@property (nonatomic,copy)NSString *Remark;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSArray *PicList;
@property (nonatomic,assign)Boolean IsTop;
@property (nonatomic,assign)Boolean IsLike;
@property (nonatomic,assign)Boolean IsJoin;
@property (nonatomic,copy)NSString *Gender;
+ (id)initWithDict:(NSDictionary *)dict;
@end
