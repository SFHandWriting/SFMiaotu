//
//  MyadView_new.h
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyadView_new : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) UIViewController *fatherViewcontroller;
@property (nonatomic,strong) UIViewController *fVC;
@property(nonatomic,strong)NSMutableArray *tidArray;
-(id)initWithFramex:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height Auto:(BOOL)autoAction time:(NSInteger)time circle:(BOOL)circle PictureNameArray:(NSMutableArray *)pictureNameArray pictureUrlArray:(NSMutableArray *)pictureUrlArray scrollViewFramex:(CGFloat)s_x y:(CGFloat)s_y width:(CGFloat)s_width height:(CGFloat)s_height pageControlFramex:(CGFloat)p_x y:(CGFloat)p_y width:(CGFloat)p_width height:(CGFloat)p_height labelFrame:(CGRect)frame labelBackGroundColor:(UIColor *)labelBackGroundColor textFont:(NSInteger)font modelArray:(NSMutableArray *)modelArray;
@end
