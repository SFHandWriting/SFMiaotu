//
//  TabBarController.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TabBarController.h"
#import "TravelViewController.h"
#import "FriendViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"
#import "TabBar.h"
@interface TabBarController ()
@property (nonatomic,strong)TabBar *MyTabBar;
@end

@implementation TabBarController
//在页面出现的时候将系统的tabBar上的子view移除，重新加载自己定义的tabBar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!_MyTabBar){
        for(UIView *view in self.tabBar.subviews){
            [view removeFromSuperview];
        }
        TabBar *tabBar = [[TabBar alloc]initWithFrame:self.tabBar.bounds];
        _MyTabBar = tabBar;
        tabBar.buttonIndex = ^(NSInteger index){
            self.selectedIndex = index;
        };
        [self.tabBar addSubview:tabBar];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
}
//创建子页面
-(void)creatViewControllers{
    [self creatChildVCWithClassName:[TravelViewController class]];
    [self creatChildVCWithClassName:[FriendViewController class]];
    [self creatChildVCWithClassName:[MessageViewController class]];
    [self creatChildVCWithClassName:[MyViewController class]];
}
//创建子页面的方法封装
-(void)creatChildVCWithClassName:(Class)class{
    UIViewController *VC = [[class alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:VC];
    [self addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
