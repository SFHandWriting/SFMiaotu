//
//  ItemsModel2.h
//  妙途
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsModel2 : NSObject
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *Aid;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *Destination;
@property (nonatomic,copy)NSNumber *MtPrice;
@property (nonatomic,copy)NSString *StartDate;
@property (nonatomic,copy)NSString *EndDate;
@property (nonatomic,copy)NSString *Duration;
@property (nonatomic,copy)NSString *Remark;
@property (nonatomic,copy)NSNumber *ShareCount;
@property (nonatomic,copy)NSNumber *ActivityReplyCount;
@property (nonatomic,copy)NSNumber *ActivityJoinCount;
@property (nonatomic,copy)NSNumber *ActivityLikeCount;
@property (nonatomic,copy)NSString *PicUrl;
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSNumber *IsTop;
@property (nonatomic,assign)Boolean IsLike;
@property (nonatomic,assign)Boolean IsJoin;
@property (nonatomic,copy)NSString *Yid;
+ (id)initWithDict:(NSDictionary *)dict;
@end
