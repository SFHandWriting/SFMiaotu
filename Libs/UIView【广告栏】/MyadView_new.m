//
//  MyadView_new.m
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "MyadView_new.h"
#import "topicViewController.h"
#import "UIView_adNew.h"
#import "PicViewController.h"
#import "UIView_advertisement.h"
#import "UIImageView+WebCache.h"
//#import "NewsModel.h"//接受数据模型
//#import "DetailViewController.h"
@implementation MyadView_new
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    CGFloat _myWidth;
    NSTimer *_timer;
    NSInteger _time;
    CGFloat _y;
    NSMutableArray *array;
    BOOL _circle;
    UILabel *_label;
    NSInteger _num;
    NSInteger _total;
    NSMutableArray *myModelArray;
    NSInteger myFont;
}
-(id)initWithFramex:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height Auto:(BOOL)autoAction time:(NSInteger)time circle:(BOOL)circle PictureNameArray:(NSMutableArray *)pictureNameArray pictureUrlArray:(NSMutableArray *)pictureUrlArray scrollViewFramex:(CGFloat)s_x y:(CGFloat)s_y width:(CGFloat)s_width height:(CGFloat)s_height pageControlFramex:(CGFloat)p_x y:(CGFloat)p_y width:(CGFloat)p_width height:(CGFloat)p_height labelFrame:(CGRect)frame labelBackGroundColor:(UIColor *)labelBackGroundColor textFont:(NSInteger)font modelArray:(NSMutableArray *)modelArray{
    self = [super init];
    if(self){
        myModelArray = modelArray;
        if(pictureNameArray == nil){
            _total = pictureUrlArray.count;
            array = pictureUrlArray;
        }else{
            _total = pictureNameArray.count;
            array = pictureNameArray;
        }
        _circle = circle;
        myFont = font;
        _myWidth = s_width;
        _time = time;
        _y = s_y;
        _num = 1;
        self.frame = CGRectMake(x, y, width, height);
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(s_x, s_y, s_width, s_height)];
        if(pictureUrlArray == nil){
            for(NSInteger i=0;i<pictureNameArray.count;i++){
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",pictureNameArray[i]]];
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*s_width, s_y, s_width, s_height)];
                imageV.image = image;
                [_scrollView addSubview:imageV];
            }
        }else{
            for(NSInteger i=0;i<pictureUrlArray.count;i++){
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(2+i*100, 7, 95, s_height-14)];
                [imageV sd_setImageWithURL:[NSURL URLWithString:pictureUrlArray[i]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
                //                NewsModel *model = modelArray[i];
                //                _label.text = model.title;
                _label.textColor = [UIColor whiteColor];
                //_label.text = [NSString stringWithFormat:@"%d/%d",_num,array.count];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(2+i*100, 7, 95, s_height-14);
                button.tag = 201+i;
                [button addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
                
                [_scrollView addSubview:imageV];
            }
        }
        if(autoAction == YES){
            //_timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(loop:) userInfo:nil repeats:YES];
            UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(array.count*_myWidth, _y, _myWidth, s_height)];
            if(pictureUrlArray.count == 0){
                [IV setImage:[UIImage imageNamed:pictureNameArray[0]]];
            }else{
                [IV sd_setImageWithURL:[NSURL URLWithString:pictureUrlArray[0]]];
            }
            [_scrollView addSubview:IV];
            
            _scrollView.contentSize = CGSizeMake((array.count+1)*_myWidth, s_height);
            
        }else{
            _scrollView.showsHorizontalScrollIndicator = NO;
            _scrollView.contentSize = CGSizeMake(100*array.count, s_height);
        }
        if(circle == YES){
            UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(array.count*_myWidth, _y, _myWidth, s_height)];
            if(pictureUrlArray.count == 0){
                [IV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",array[0]]]];
            }else{
                [IV sd_setImageWithURL:[NSURL URLWithString:pictureUrlArray[0]]];
            }
            [_scrollView addSubview:IV];
            
            _scrollView.contentSize = CGSizeMake((array.count+1)*_myWidth, s_height);
        }
        _scrollView.tag = 100;
        _scrollView.contentOffset = CGPointZero;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }return self;
}
#pragma ***广告栏的点击事件***
-(void)detail:(UIButton *)button{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=2;
    picVC.picArray = myModelArray;
    [self.fVC presentViewController:picVC animated:YES completion:^{
        
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        if(_circle == YES){
            if(_scrollView.contentOffset.x == array.count*_myWidth){
                _scrollView.contentOffset = CGPointMake(0, _y);
                _pageControl.currentPage = 0;
                
                // _label.text = [NSString stringWithFormat:@"1/%d",_total];
            }
        }
        NSInteger page = scrollView.contentOffset.x/320;
        
        _pageControl.currentPage = page;
        // _label.text = [NSString stringWithFormat:@"%d/%d",page+1,_total];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
