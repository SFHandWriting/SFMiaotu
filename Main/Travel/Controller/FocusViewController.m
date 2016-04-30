//
//  FocusViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FocusViewController.h"
#import "QFRequestManger.h"
#import "FocusCell.h"
#import "CommendModel.h"
#define url @"http://api.miaotu.com/v1.1/user/%@?token=%@&uid=%@&page=1&num=100000"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface FocusViewController ()
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@end

@implementation FocusViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatMyNav];
     _dataArray = [[NSMutableArray alloc]init];
    [self creatData];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW-200)/2, 100, 200, 300)];
        imageV.image = [UIImage imageNamed:@"icon_empty_fans.png"];
        imageV.backgroundColor = [UIColor whiteColor];
        
        [view addSubview:imageV];
        [self.view addSubview:view];

}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell){
        cell = [[FocusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    CommendModel *model = _dataArray[indexPath.row];
    cell.fatherVC = self;
    [cell finishCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)creatData{
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:url,self.type,self.token,self.Uid] IsCache:NO finish:^(NSData *data) {
        [_dataArray removeAllObjects];
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        id objc = [rootDic objectForKey:@"Items"];
        if([objc isKindOfClass:[NSArray class]]){
            for(NSDictionary *dic in objc){
                CommendModel *model = [CommendModel initWithDict:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        if(_dataArray.count == 0){
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104)];
            view.backgroundColor = [UIColor whiteColor];
            
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW-200)/2, 100, 200, 300)];
            imageV.image = [UIImage imageNamed:@"icon_empty_fans.png"];
            imageV.backgroundColor = [UIColor whiteColor];
            
            [view addSubview:imageV];
            [self.view addSubview:view];
        }
        
    } failed:^{
        
    }];
}
-(void)creatMyNav{
    //创建导航栏
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW,64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //装饰
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREENW, 1)];
    label2.backgroundColor = [UIColor grayColor];
    label2.alpha = 0.3;
    [navView addSubview:label2];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    //创建标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREENW-40, 30)];
    titleLable.text = @"关注与粉丝";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    //创建button
    NSArray *array = @[@"关注",@"粉丝"];
    for(int i=0;i<2;i++){
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREENW/2, 66, SCREENW/2, 38);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*SCREENW/2, 64, SCREENW/2, 2)];
        label.backgroundColor  =[UIColor grayColor];
        label.alpha = 0.4;
        label.tag = 200+i;
        [self.view addSubview:label];
        [button setBackgroundColor:[UIColor grayColor]];
        button.alpha = 0.4;
        if(i==self.state){
            button.selected = YES;
            [button setBackgroundColor:[UIColor whiteColor]];
            self.selectedButton = button;
            label.backgroundColor = [UIColor orangeColor];
            label.alpha = 0.7;
        }
        [button addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)focus:(UIButton *)button{
    //UI效果
    [self.selectedButton  setBackgroundColor:[UIColor grayColor]];
    UILabel *label = (UILabel *)[self.view viewWithTag:self.selectedButton.tag+100];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.4;
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    button.selected = YES;
    [button setBackgroundColor:[UIColor whiteColor]];
    UILabel *label3 = (UILabel *)[self.view viewWithTag:button.tag+100];
    label3.backgroundColor = [UIColor orangeColor];
    label3.alpha = 0.7;
    [view removeFromSuperview];
    if(button.tag == 100){
      self.type = @"like";
        [self creatData];
    }else{
       self.type = @"liked";
        [self creatData];
    }
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
