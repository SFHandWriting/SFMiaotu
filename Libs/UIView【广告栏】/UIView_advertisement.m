//
//  UIView_advertisement.m
//  123
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 朱磊. All rights reserved.
//
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#import "UIView_advertisement.h"
#import "UIImageView+WebCache.h"
#import "BannerModel.h"
#import "adViewController.h"
@implementation UIView_advertisement
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
    NSMutableArray *_myArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFramex:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height toTableView:(UITableView *)tableview Auto:(BOOL)autoAction time:(NSInteger)time circle:(BOOL)circle PictureNameArray:(NSMutableArray *)pictureNameArray pictureUrlArray:(NSMutableArray *)pictureUrlArray scrollViewFramex:(CGFloat)s_x y:(CGFloat)s_y width:(CGFloat)s_width height:(CGFloat)s_height pageControlFramex:(CGFloat)p_x y:(CGFloat)p_y width:(CGFloat)p_width height:(CGFloat)p_height labelFrame:(CGRect)frame labelBackGroundColor:(UIColor *)labelBackGroundColor textFont:(NSInteger)font modelArray:(NSMutableArray *)modelArray{
    self = [super init];
    if(self){
        if(pictureNameArray == nil){
            _total = pictureUrlArray.count;
            array = pictureUrlArray;
        }else{
        _total = pictureNameArray.count;
            array = pictureNameArray;
        }
        tableview.tableHeaderView = self;
        _circle = circle;
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
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*s_width, s_y, s_width, s_height)];
                if(pictureUrlArray.count == 1){
                imageV.alpha = 0.7;
                }else{
                    imageV.alpha = 1;
                }
                [imageV sd_setImageWithURL:[NSURL URLWithString:pictureUrlArray[i]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
//                UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
//                [singleTapGestureRecognizer setNumberOfTapsRequired:1];
//                [imageV addGestureRecognizer:singleTapGestureRecognizer];
//                
//                UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
//                [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
//                [imageV addGestureRecognizer:doubleTapGestureRecognizer];        [self addSubview:_pageControl];
//                [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
                _myArray = modelArray;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(i*s_width, s_y, s_width, s_height);
                button.tag = 100+i;
                [button addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
                
                [_scrollView addSubview:imageV];
            }
  
        }
        if(autoAction == YES){
            _timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(loop:) userInfo:nil repeats:YES];
            UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(array.count*_myWidth, _y, _myWidth, s_height)];
            if(pictureUrlArray == nil){
            [IV setImage:[UIImage imageNamed:pictureNameArray[0]]];
            }else{
                [IV sd_setImageWithURL:[NSURL URLWithString:pictureUrlArray[0]]];
            }
            [_scrollView addSubview:IV];
            
            _scrollView.contentSize = CGSizeMake((array.count+1)*_myWidth, s_height);
            
        }else{
            _scrollView.contentSize = CGSizeMake(_myWidth*array.count, s_height);
        }
        if(circle == YES){
            UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(array.count*_myWidth, _y, _myWidth, s_height)];
            if(pictureUrlArray == nil){
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
        
        _label = [[UILabel alloc]initWithFrame:frame];
        _label.text = [NSString stringWithFormat:@"%d/%d",_num,array.count];
        _label.backgroundColor = labelBackGroundColor;
        _label.alpha = 0.5;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(p_x, p_y, p_width, p_height)];
        _pageControl.tag = 200;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.enabled = YES;
        _pageControl.numberOfPages = pictureUrlArray.count;
        _pageControl.currentPage = 0;
        _pageControl.alpha = 0.5;
        [self addSubview:_pageControl];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
    }return self;
}
-(void)detail:(UIButton *)button{
    BannerModel *model = _myArray[button.tag-100];
    adViewController *adVC = [[adViewController alloc]init];
    adVC.url = model.Extend;
    adVC.Title = model.Title;
    adVC.hidesBottomBarWhenPushed = YES;
    [self.fatherVC.navigationController pushViewController:adVC animated:YES];
}
-(void)loop:(NSTimer *)timer{
    NSInteger page = _scrollView.contentOffset.x/_myWidth;
    [UIView animateWithDuration:0.1 animations:^{
        
        _pageControl.currentPage = page+1;
        _label.text = [NSString stringWithFormat:@"%d/%d",page
                       +1,_total];
    }];
    
    CGFloat x = _scrollView.contentOffset.x;
    x+=_myWidth;
    [UIView animateWithDuration:0.1 animations:^{
        _scrollView.contentOffset = CGPointMake(x, _y);
    } completion:^(BOOL finished) {
        if(_scrollView.contentOffset.x == array.count*_myWidth){
            _scrollView.contentOffset = CGPointMake(0, _y);
            _pageControl.currentPage = 0;
            _label.text = [NSString stringWithFormat:@"1/%d",_total];
        }
    }];
   
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        if(_circle == YES){
            if(_scrollView.contentOffset.x == array.count*_myWidth){
                _scrollView.contentOffset = CGPointMake(0, _y);
                _pageControl.currentPage = 0;
                _label.text = [NSString stringWithFormat:@"1/%d",_total];            }
        }
        NSInteger page = scrollView.contentOffset.x/320;
        
        _pageControl.currentPage = page;
        _label.text = [NSString stringWithFormat:@"%d/%d",page+1
                       ,_total];    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
