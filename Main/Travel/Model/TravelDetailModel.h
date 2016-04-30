//
//  TravelDetailModel.h
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelDetailModel.h"
@interface TravelDetailModel : NSObject
@property (nonatomic,copy)NSString *MaritalStatus;
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSNumber *Age;
@property (nonatomic,copy)NSString *WantGo;
@property (nonatomic,copy)NSNumber *Distance;
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *Require;
@property (nonatomic,copy)NSString *MoneyType;
@property (nonatomic,copy)NSNumber *YueyouLikeCount;
@property (nonatomic,copy)NSNumber *YueyouReplyCount;
@property (nonatomic,copy)NSNumber *YueyouJoinCount;
@property (nonatomic,copy)NSString *Remark;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSArray *PicList;
@property (nonatomic,copy)NSMutableArray *LikeList;
@property (nonatomic,copy)NSMutableArray *JoinList;
@property (nonatomic,copy)NSMutableArray *ReplyList;
@property (nonatomic,copy)NSString *StartDate;
@property (nonatomic,copy)NSString *EndDate;
@property (nonatomic,copy)NSString *EndTime;
@property (nonatomic,copy)NSString *Destination;
@property (nonatomic,copy)NSString *From;
@property (nonatomic,assign)Boolean IsTop;
@property (nonatomic,assign)Boolean IsLike;
@property (nonatomic,assign)Boolean IsJoin;
@property (nonatomic,copy)NSString *Yid;
@property (nonatomic,copy)NSString *Gender;

+ (id)initWithDict:(NSDictionary *)dict;
@end
