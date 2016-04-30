//
//  FriendItemsModel.h
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendItemsModel : NSObject
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *Yid;
@property (nonatomic,copy)NSString *Remark;
@property (nonatomic,copy)NSString *Created;
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSString *Gender;
@property (nonatomic,copy)NSString *MaritalStatus;
@property (nonatomic,copy)NSString *WantGo;
@property (nonatomic,copy)NSNumber *Sid;
@property (nonatomic,copy)NSNumber *Distance;
@property (nonatomic,copy)NSNumber *Age;
@property (nonatomic,assign)Boolean *IsLike;
@property (nonatomic,copy)NSArray *PicList;
@property (nonatomic,copy)NSArray *LikeList;
@property (nonatomic,copy)NSArray *ReplyList;
+ (id)initWithDict:(NSDictionary *)dict;
@end
