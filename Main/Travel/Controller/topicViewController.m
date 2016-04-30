//
//  topicViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "topicViewController.h"
#import "TabBar.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define url @"http://m.miaotu.com/App32/theme/?token=%@&tid=%@"
@interface topicViewController ()

@end

@implementation topicViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    //创建导航栏
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW,64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    //创建标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, SCREENW-40, 30)];
    titleLable.text = @"专题";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, SCREENW, SCREENH - 44)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:url,self.token,self.tid]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //加载一个request
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}
//分享
-(void)share{
   
}
//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
