//
//  DongViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "DongViewController.h"
#import "QFRequestManger.h"
#import "FriendItemsModel.h"
#import "FriendItemCell.h"
#import "MJRefresh.h"
#import "Friend_neiDetailViewController.h"
#define url @"http://api.miaotu.com/v1.1/user/state/list?token=%@&uid=%@&page=%d&num=10"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface DongViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *_myArray;
    UITableView *_tableView;
    NSInteger _page;
    BOOL _isPull;
}
@end

@implementation DongViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    _isPull = NO;
    _dataArray = [[NSMutableArray alloc]init];
    _myArray = [[NSMutableArray alloc]init];
    [self creatMyNav];
    [self creatData];
    [self creatTableView];
    [self creatView];
    [self creatRefresh];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    if(_dataArray.count == 0){
        [_tableView removeFromSuperview];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.4;
        
        UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, SCREENW-200, 100)];
        t.text = @"TA还没有发布动态";
        t.numberOfLines = 0;
        t.font = [UIFont systemFontOfSize:15];
        t.textAlignment = NSTextAlignmentCenter;
        t.textColor = [UIColor redColor];
        [view addSubview:t];
        [self.view addSubview:view];
    }
}
-(void)creatRefresh{
    //加头
    [_tableView addHeaderWithTarget:self action:@selector(pullRefresh)];
    //加尾
    [_tableView addFooterWithTarget:self action:@selector(pushRefresh)];
}
-(void)pullRefresh{
    
    _isPull = YES;
    _page =1;
    [self creatData];
    
    //当数据请求结束后 结束下拉刷新的过程
    [_tableView headerEndRefreshing];
}
-(void)pushRefresh{
    
    _isPull = NO;
    //因为每次调用这个方法 都是在改变网址的page参数 而且每次都是page参数+1，所以给全局的_page++；
    _page++;
    [self creatData];
    [_tableView footerEndRefreshing];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREENW , SCREENH-49-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendItemCell *cell = [[FriendItemCell alloc]initWithFrame:CGRectMake(0, 240*indexPath.row, SCREENW, 240)];
    FriendItemsModel *model = _dataArray[indexPath.row];
    cell.model = model;
    cell.str = @"dong";
    cell.FatherVC = self;
    [cell finishCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendItemsModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    if(model.PicList.count>0){
        return 75+rect.size.height+(SCREENW-30)/3;
    }else{
        return 75+rect.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Friend_neiDetailViewController *neiVC = [[Friend_neiDetailViewController alloc]init];
    neiVC.hidesBottomBarWhenPushed = YES;
    FriendItemsModel *modeli = _dataArray[indexPath.row];
    neiVC.model = modeli;
    neiVC.Sid = [NSString stringWithFormat:@"%@",modeli.Sid];
    [self presentViewController:neiVC animated:YES completion:^{
        
    }];
}
//创造数据
-(void)creatData{
    if(_isPull == YES){
        [_dataArray removeAllObjects];
        [_myArray removeAllObjects];
    }
    NSString *str = [NSString stringWithFormat:url,self.token,self.Uid,_page];
    NSLog(@"%@",str);
    [QFRequestManger requestWithUrl:str IsCache:YES finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        id objc = [rootDic objectForKey:@"Items"];
        if([objc isKindOfClass:[NSArray class]]){
        for(NSDictionary *dic in objc){
            FriendItemsModel *model = [FriendItemsModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        }if(_dataArray.count == 0){
            [_tableView removeFromSuperview];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
            view.backgroundColor = [UIColor grayColor];
            view.alpha = 0.4;
            
            UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, SCREENW-200, 100)];
            t.text = @"TA还没有发布动态";
            t.numberOfLines = 0;
            t.font = [UIFont systemFontOfSize:15];
            t.textAlignment = NSTextAlignmentCenter;
            t.textColor = [UIColor redColor];
            [view addSubview:t];
            [self.view addSubview:view];
        }
        [_tableView reloadData];
    } failed:^{
        
    }];
}
//自定义导航栏
-(void)creatMyNav{
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
    titleLable.text = @"TA的动态";
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
