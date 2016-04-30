//
//  TabBar.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#import "TabBar.h"
#import "TabBarButton.h"
@implementation TabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTabBarItems];
    }
    return self;
}
-(void)creatTabBarItems{
    NSArray *nameArray = @[@"旅行",@"妙友",@"消息",@"我的"];
    NSArray *picArray = @[@"icon_tab_first_unselected.png",@"icon_tab_community_unselected.png",@"icon_tab_message_unselected.png",@"icon_tab_mine_unselected.png",@"icon_start_city.png",@"icon_tab_community_selected.png",@"icon_tab_message_selected.png",@"icon_tab_mine_selected.png"];
    for(NSInteger i=0;i<4;i++){
        TabBarButton *button = [[TabBarButton alloc]initWithFrame:CGRectMake(i*SCREENW/4, 0, SCREENW/4+1, 49)];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:picArray[i+4]] forState:UIControlStateSelected];
        button.tag = 100+i;
        if(i==0){
            button.selected = YES;
            self.selectedButton = button;
            button.alpha = 1;
        }
        [button setAdjustsImageWhenHighlighted:NO];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)click:(UIButton *)button{
    self.selectedButton.selected = NO;
    self.selectedButton.alpha = 0.8;
    button.selected = YES;
    self.selectedButton = button;
    button.alpha = 1;
    self.buttonIndex(button.tag-100);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
