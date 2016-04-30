//
//  MessageViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//基本信息
//工作经验，

#import "MessageViewController.h"
#import "MessageCell.h"
#import "SystemViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface MessageViewController ()

@end

@implementation MessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 420) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled =NO;
    [self.view addSubview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageCell *cell = [[MessageCell alloc]init];
    NSArray *array = @[@"icon_system_msg.png",@"icon_like_msg.png",@"icon_join_msg.png",@"icon_chat_msg.png",@"icon_like2_msg.png",@"icon_comment_msg.png",@"系统消息",@"喜欢提醒",@"报名提醒",@"聊天",@"关注提醒",@"评论提醒"];
    cell.image = array[indexPath.row];
    cell.title = array[indexPath.row + 6];
    [cell finish];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        SystemViewController *systemVC = [[SystemViewController alloc]init];
        [self presentViewController:systemVC animated:YES completion:^{
            
        }];
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
