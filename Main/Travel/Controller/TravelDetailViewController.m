//
//  TravelDetailViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "TravelDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "QFRequestManger.h"
#import "CommendViewController.h"
#import "TravelDetailModel.h"
#import "TravelDetailCell.h"
#import "DoubleModel.h"
#import "myTabBarButton.h"
#define likeUrl @"http://api.miaotu.com/v1.1/yueyou/like"
#define joinUrl @"http://api.miaotu.com/v1.1/yueyou/join"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define travelDetailUrl @"http://api.miaotu.com/v1.1/yueyou/?token=98aa550d-6758-11e5-bb24-00163e002e59&yid=%@"
@interface TravelDetailViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL _pop;
    UIView *tabBarView;
    NSString *w;
    NSString *e;
    BOOL _is;
    BOOL _isjoin;
}
@end

@implementation TravelDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pop = NO;
    _is = NO;
    [self creatNav];
    [self creatTabBar];
    [self creatData];
    [self creatTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(load:) name:@"load" object:nil];
}
-(void)load:(NSNotification *)noti{
    if([noti.object isEqual:@"YES"]){
        [tabBarView removeFromSuperview];
        [self creatData];
        NSInteger p = [e integerValue]+1;
        e = [NSString stringWithFormat:@"%d",p];
        _is = YES;
        [self creatTabBar];
    }else if([noti.object isEqualToString:@"NO"]){
      [self creatData];
    }else{
        [tabBarView removeFromSuperview];
        [self creatData];
        if(self.myModel.IsLike){
            NSInteger p = [w integerValue]-1;
            w = [NSString stringWithFormat:@"%d",p];
        }else{
            NSInteger p=[ w integerValue]+1;
            w = [NSString stringWithFormat:@"%d",p];
        }
        self.myModel.IsLike = !self.myModel.IsLike;
        _is = YES;
        [self creatTabBar];
  
    }
}
-(void)creatTabBar{
    tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH-49, SCREENW, 49)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [tabBarView addSubview:line];
    if(_is == NO){
    w = [NSString stringWithFormat:@"%@",self.myModel.YueyouLikeCount];
   e = [NSString stringWithFormat:@"%@",self.myModel.YueyouReplyCount];
    if(self.myModel == nil){
        w= [NSString stringWithFormat:@"%d",self.p1];
        e = [NSString stringWithFormat:@"%d",self.l1];
    }
    }
    NSArray *array = @[@"icon_detail_like.png",@"icon_detail_comment.png",w,e];
    for(int i=0;i<2;i++){
        myTabBarButton *button = [[myTabBarButton alloc]initWithFrame:CGRectMake(i*(SCREENW/6), 0, SCREENW/6, 49)];
        if(i==0){
            if(self.myModel.IsLike){
                [button setImage:[UIImage imageNamed:@"icon_together_like_solid.png"] forState:UIControlStateNormal];
            }else{
                [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
            }
        }else{
            [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        }
        [button setTitle:array[i+2] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(left2:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [tabBarView addSubview:button];
    }

    NSArray *array2 = @[@"聊天",@"立即入伙"];
    for(int i=0;i<2;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREENW/3*(i+1), 0, SCREENW/3, 49);
        [button setTitle:array2[i] forState:UIControlStateNormal];
        if(i==0){
        [button setBackgroundColor:[UIColor brownColor]];
            button.alpha = 0.5;
        }else{
            [button setBackgroundColor:[UIColor orangeColor]];
        }
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(right2:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 102+i;
        [tabBarView addSubview:button];
    }
    
    [self.view addSubview:tabBarView];
}
-(void)left2:(UIButton *)button{
    if(button.tag == 100){
        [popView removeFromSuperview];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",self.myModel.Yid,@"yid", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:likeUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];

    }else if (button.tag == 101 ){
        [popView removeFromSuperview];
        CommendViewController *commendVC = [[CommendViewController alloc]init];
        commendVC.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        commendVC.yid = self.myModel.Yid;
        commendVC.type = @"yueyou";
        commendVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:commendVC animated:YES completion:^{
            
        }];
 
    }
}
-(void)right2:(UIButton *)button{
    if(button.tag == 102){//气泡
        _pop = !_pop;
        if(_pop){
        popView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW/3+10, SCREENH-49-120, SCREENW/3-20, 120)];
        popView.image = [UIImage imageNamed:@"bg_popup_above.png"];
        NSArray *array3 = @[@"私信",@"群聊"];
        for(int i=0;i<2;i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, i*60, SCREENW/3-40, 60);
            [button setTitle:array3[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.tag = 104+i;
            button.alpha = 0.7;
            [button addTarget:self action:@selector(chat2:) forControlEvents:UIControlEventTouchUpInside];
            [popView addSubview:button];
        }
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, SCREENW/3-60, 0.3)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.7;
        [popView addSubview:line];
        [self.view addSubview:popView];
        }else{
            [popView removeFromSuperview];
        }
    }else if (button.tag == 103){
        [popView removeFromSuperview];
        if(self.myModel.IsJoin){
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经入伙了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else{
            NSString *encode = [NSString stringWithString:[@"" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",self.myModel.Yid,@"yid",encode,@"name",@"1",@"phone", nil];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST:joinUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:@"NO"];
                //ruhuo success share
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
 
        }
    }
}
-(void)chat2:(UIButton *)button{
    if(button.tag == 104){
        
    }else if (button.tag == 105){
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [popView removeFromSuperview];
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:travelDetailUrl,self.Yid] IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic = [rootDic objectForKey:@"Items"];
        TravelDetailModel *model = [TravelDetailModel initWithDict:dic];
        [_dataArray addObject:model];
        [_tableView reloadData];
    } failed:^{
        
    }];
   }
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-49-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //计算cell高度
    TravelDetailModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.Remark boundingRectWithSize:CGSizeMake(SCREENW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    NSInteger k;
    NSMutableArray *commentArray = [[NSMutableArray alloc]init];
    if(model.ReplyList.count<4){
        k=model.ReplyList.count;
    }else{
        k=3;
    }
    for(NSDictionary *dic in model.ReplyList){
        DoubleModel *model = [DoubleModel initWithDict:dic];
        [commentArray addObject:model];
    }
    NSInteger h=0;
    for(int i=0;i<k;i++){
        DoubleModel *model2 = commentArray[i];
        CGRect rect2 = [model2.Content boundingRectWithSize:CGSizeMake(SCREENW-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        h=h+rect2.size.height+55;
    }
    myHeight = h+rect.size.height+(SCREENW-30)/3+520;
    TravelDetailCell *cell = [[TravelDetailCell alloc]init];
    cell.model = model;
    cell.yid = self.Yid;
    cell.fatherVC = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell finishCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return myHeight;
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
    titleLable.text = @"线路详情";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    //分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"icon_share_friend_default.png"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(SCREENW-60, 38, 15, 15);
    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:shareButton];
    //moreshare
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(SCREENW-35, 43, 20, 5);
    [moreBtn setImage:[UIImage imageNamed:@"icon_share_more_default.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(sharemore) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:moreBtn];
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, SCREENW, 1)];
//    line.backgroundColor = [UIColor blackColor];
//    line.alpha = 1;
//    [self.view addSubview:line];
}
//分享
-(void)share{
    
}
//更多分享
-(void)sharemore{
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [popView removeFromSuperview];
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
