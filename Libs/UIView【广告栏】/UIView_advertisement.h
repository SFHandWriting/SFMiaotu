//
//  UIView_advertisement.h
//  123
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView_advertisement : UIView<UIScrollViewDelegate>
-(id)initWithFramex:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height toTableView:(UITableView *)tableview Auto:(BOOL)autoAction time:(NSInteger)time circle:(BOOL)circle PictureNameArray:(NSMutableArray *)pictureNameArray pictureUrlArray:(NSMutableArray *)pictureUrlArray scrollViewFramex:(CGFloat)s_x y:(CGFloat)s_y width:(CGFloat)s_width height:(CGFloat)s_height pageControlFramex:(CGFloat)p_x y:(CGFloat)p_y width:(CGFloat)p_width height:(CGFloat)p_height labelFrame:(CGRect)frame labelBackGroundColor:(UIColor *)labelBackGroundColor textFont:(NSInteger)font modelArray:(NSMutableArray *)modelArray;
@property (nonatomic,strong)UIViewController *fatherVC;
@end
