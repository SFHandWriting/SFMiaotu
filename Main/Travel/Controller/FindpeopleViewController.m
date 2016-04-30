//
//  FindpeopleViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#import "AFHTTPRequestOperationManager.h"
#import "FindpeopleViewController.h"
#import "FriendItemsModel.h"
#import "TravelDetailViewController.h"
#import "FriendItemCell.h"
#import "adViewController.h"
#import "CommendCell.h"
#import "ItemsModel2.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define url1 @"http://api.miaotu.com/v1.1/yueyou/search"
#define url2 @"http://api.miaotu.com/v1.1/activity/search"
@interface FindpeopleViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray2;
    UITableView *_tableView;
}
@end

@implementation FindpeopleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self creatData];
    [self creatTableView];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(![self.text isEqualToString:@"妙旅团搜索结果"]){
        return _dataArray.count;
    }else{
        return _dataArray2.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(![self.text isEqualToString:@"妙旅团搜索结果"]){
        FriendItemCell *cell = [[FriendItemCell alloc]init];
    FriendItemsModel *model = _dataArray[indexPath.row];
    cell.str = @"dongjing";
    cell.model = model;
    cell.FatherVC = self;
    [cell finishCellWithModel:model];
    return cell;
    }else{
        CommendCell *cell = [[CommendCell alloc]init];
        ItemsModel2 *model = _dataArray2[indexPath.row];
        cell.fatherVC = self;
        cell.model2 = model;
        [cell finishCellWithModel2:model];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![self.text isEqualToString:@"妙旅团搜索结果"]){
    FriendItemsModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.Remark boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    if(model.PicList.count>0){
        return 55+rect.size.height+(SCREENW-30)/3;
    }else{
        return 55+rect.size.height;
    }
    }else{
        return 240;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![self.text isEqualToString:@"妙旅团搜索结果"]){
    TravelDetailViewController *travelVC = [[TravelDetailViewController alloc]init];
    FriendItemsModel *model = _dataArray[indexPath.row];
    travelVC.Yid = model.Yid;
    travelVC.myModel = nil;
    travelVC.p1 = model.LikeList.count;
    travelVC.l1 = model.ReplyList.count;
    travelVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:travelVC animated:YES completion:^{
        
    }];
    }else{
        ItemsModel2 *model = _dataArray2[indexPath.row];
        adViewController *adV = [[adViewController alloc]init];
        adV.Title = model.Title;
        adV.url = [NSString stringWithFormat:@"http://m.miaotu.com/App32/detail/?aid=%@&token=98aa550d-6758-11e5-bb24-00163e002e59&uid=%@",model.Aid,model.Uid];
        adV.hidesBottomBarWhenPushed = YES;
        [self presentViewController:adV animated:YES completion:^{
            
        }];

    }
   
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    _dataArray2 = [[NSMutableArray alloc]init];
    NSDictionary *dic;
    NSString *s;
    if(![self.text isEqualToString:@"妙旅团搜索结果"]){
    dic = @{@"token":@"98aa550d-6758-11e5-bb24-00163e002e59",@"keywords":self.keywords,@"latitude":@"40.113693",@"longitude":@"116.251741",@"page":@"1",@"num":@"1000"};
        s=url1;
    }else{
        dic = @{@"token":@"98aa550d-6758-11e5-bb24-00163e002e59",@"keywords":self.keywords,@"page":@"1",@"num":@"1000"};
        s=url2;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:s parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = [responseObject objectForKey:@"Items"];
        for(NSDictionary *dic in array){
            if(![self.text isEqualToString:@"妙旅团搜索结果"]){
                FriendItemsModel *model = [FriendItemsModel initWithDict:dic];
            [_dataArray addObject:model];
            }else{
                ItemsModel2 *model = [ItemsModel2 initWithDict:dic];
                [_dataArray2 addObject:model];
            }
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
    }];
}
//创建导航栏
-(void)creatNav{
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
    titleLable.text = self.text;
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
