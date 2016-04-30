//
//  PersonModel2.h
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel2 : NSObject
@property (nonatomic,assign)Boolean *IsLike;
@property (nonatomic,copy)NSString *AboutMe;
@property (nonatomic,copy)NSString *Hobbies;
@property (nonatomic,copy)NSString *WorkArea;
@property (nonatomic,copy)NSString *FreeTime;
@property (nonatomic,copy)NSString *LifeArea;
@property (nonatomic,copy)NSString *Phone;
@property (nonatomic,copy)NSString *Uid;
@property (nonatomic,copy)NSString *Nickname;
@property (nonatomic,copy)NSString *Gender;
@property (nonatomic,copy)NSString *Birthday;
@property (nonatomic,copy)NSString *Country;
@property (nonatomic,copy)NSString *Province;
@property (nonatomic,copy)NSString *City;
@property (nonatomic,copy)NSString *Email;
@property (nonatomic,copy)NSString *HeadUrl;
@property (nonatomic,copy)NSString *Education;
@property (nonatomic,copy)NSString *GraduateSchool;
@property (nonatomic,copy)NSString *PicUrl;
@property (nonatomic,copy)NSString *MaritalStatus;
@property (nonatomic,copy)NSString *Work;
@property (nonatomic,copy)NSString *Tags;
@property (nonatomic,copy)NSString *WantGo;
@property (nonatomic,copy)NSString *Home;
@property (nonatomic,copy)NSNumber *Id;
@property (nonatomic,copy)NSNumber *Age;
@property (nonatomic,copy)NSNumber *LikeCount;
@property (nonatomic,copy)NSNumber *LikedCount;
@property (nonatomic,copy)NSMutableArray *PhotoList;
+ (id)initWithDict:(NSDictionary *)dict;
@end
