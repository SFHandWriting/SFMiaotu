
//
//  PicViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "PicViewController.h"
#import "UIView_advertisement.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface PicViewController ()
{
    UICollectionView *_collectionView;
}
@end

@implementation PicViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self creatNav];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
    blackView.backgroundColor = [UIColor whiteColor];
    UIView *stateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 20)];
    stateView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:stateView];
    [self.view addSubview:blackView];
    NSMutableArray *pics = [[NSMutableArray alloc]init];
    if(self.k==2){
    [pics removeAllObjects];
    for(NSDictionary *dic in self.picArray){
        [pics addObject:[dic objectForKey:@"Url"]];
    }
    }
    if(self.k==0){
        [pics removeAllObjects];
        [pics addObject:self.picUrl];
    }
    if(self.k==1){
        [pics removeAllObjects];
        pics = self.urlArray;
    }
    UIView_advertisement *adView =[[UIView_advertisement alloc]initWithFramex:0 y:84 width:SCREENW height:SCREENH-84-49 toTableView:nil Auto:NO time:0 circle:NO PictureNameArray:nil pictureUrlArray:pics scrollViewFramex:0 y:0 width:SCREENW height:SCREENH-84-49 pageControlFramex:9999 y:9999 width:0 height:0 labelFrame:CGRectMake(SCREENW-50, -50  , 50 , 20) labelBackGroundColor:[UIColor grayColor] textFont:18 modelArray:nil];
    [self.view addSubview:adView];
    }
-(void)creatNav{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
    navView.backgroundColor = [UIColor grayColor];
    navView.alpha = 0.7;
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 10, 20, 24);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
}
//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
