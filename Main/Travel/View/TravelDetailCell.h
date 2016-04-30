//
//  TravelDetailCell.h
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ageButton.h"
#import "TravelDetailModel.h"
@interface TravelDetailCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>{
    NSInteger k;
    NSInteger y1;
    NSInteger h;
    UIButton *firstButton;
    UIButton *secButton;
    UIButton *thirdButton;
    NSMutableArray *_dataArray;
    UIScrollView *scrollView;
    UIButton *moreButton;
    UIView *View;
    NSMutableArray *commentArray;
}
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)NSString *yid;
@property (nonatomic,copy)NSString *MaritalStatus;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)ageButton *ageButton;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UILabel *decLabel;
@property (nonatomic,copy)TravelDetailModel *model;
@property (nonatomic,copy)NSMutableArray *picArray;
@property (nonatomic,copy)NSArray *listArray;
@property (nonatomic,strong)UIViewController *fatherVC;
-(void)finishCellWithModel:(TravelDetailModel *)model;
@end
