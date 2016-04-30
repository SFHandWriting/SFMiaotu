//
//  SystemViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SystemViewController.h"
#import "QFRequestManger.h"
#import "MessageModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "SystemCell.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define url @"http://api.miaotu.com/v1.1/user/msg/system?token=98aa550d-6758-11e5-bb24-00163e002e59&type=system&value=&page=1&num=100000"
@interface SystemViewController ()
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    BOOL _state;
    UIButton *clearButton;
}
@end

@implementation SystemViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _state = NO;
    [self creatData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
    
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SystemCell *cell = [[SystemCell alloc]init];
    MessageModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = _dataArray[indexPath.row];
    NSString *content = [model.Content objectForKey:@"Content"];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(SCREENW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return rect.size.height+60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = _dataArray[indexPath.row];
    model.Status = (NSNumber *)@"1";
    [_dataArray removeAllObjects];
    [_dataArray addObject:model];
    [_tableView reloadData];
    _state = !_state;
    clearButton.alpha = 0;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",model.Id,@"id", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://api.miaotu.com/v1.1/user/msg" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    [QFRequestManger requestWithUrl:url IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *items = [rootDic objectForKey:@"Items"];
        for(NSDictionary *dic in items){
            MessageModel *model = [MessageModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        if(_dataArray.count == 0){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有系统消息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        [_tableView reloadData];
    } failed:^{
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)creatNav{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 10, 20, 24);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    //qingkong
     clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(SCREENW-60, 10, 50, 24);
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:clearButton];
    //
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-100)/2, 5, 100, 34)];
    label.text = @"系统消息";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:label];
    //
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.3;
    [navView addSubview:line];
}
-(void)clear{
    if(_dataArray.count==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有系统消息，无需清空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",@"sysytem",@"type",@"",@"value" ,nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://api.miaotu.com/v1.1/user/msg/delete/system" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [_tableView removeFromSuperview];
    } 
}
//返回
-(void)back{
    if(_state){
        [self creatData];
        _state = !_state;
        clearButton.alpha = 1;
    }else{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
    }
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
