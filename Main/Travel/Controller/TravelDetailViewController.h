//
//  TravelDetailViewController.h
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "BaseViewController.h"
#import "TravelDetailModel.h"
#import "ItemsModel.h"
@interface TravelDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
   NSInteger myHeight;
    UIImageView *popView;
}
@property (nonatomic,copy)NSString *Yid;
@property (nonatomic,assign)NSInteger s;
@property (nonatomic,assign)NSInteger f;
@property (nonatomic,assign)NSInteger p1;
@property (nonatomic,assign)NSInteger l1;
@property (nonatomic,strong)ItemsModel *myModel;
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)TravelDetailModel *model;
@end
