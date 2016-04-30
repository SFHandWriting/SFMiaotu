//
//  AllPicsViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "AllPicsViewController.h"
#import "UIImageView+WebCache.h"
#import "PicViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface AllPicsViewController ()

@end

@implementation AllPicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    for(int i=0;i<self.picUrlArray.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i%3*(SCREENW-40)/3, 74+i/3*(SCREENW-30)/3, (SCREENW-40)/3-10, (SCREENW-30)/3-10);
        [button addTarget:self action:@selector(picClick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *picView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(SCREENW-40)/3-10, (SCREENW-30)/3-10)];
        [picView sd_setImageWithURL:[NSURL URLWithString:self.picUrlArray[i]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [button addSubview:picView];
        [self.view addSubview:button];
    }
}
-(void)picClick{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=1;
    picVC.urlArray = self.picUrlArray;
    [self presentViewController:picVC animated:YES completion:^{
        
    }];
}
-(void)creatNav{
    //创建导航栏
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW,64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //装饰
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREENW, 1)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.3;
    [navView addSubview:label];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    //创建标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREENW-40, 30)];
    titleLable.text = @"照片墙";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
