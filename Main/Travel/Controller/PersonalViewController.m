//
//  PersonalViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "PersonalViewController.h"
#define focusUrl @"http://api.miaotu.com/v1.1/user/like"
#define picsUrl @"http://api.miaotu.com/v1.1/user/photos?token=%@&uid=%@&page=1&num=50"
#define personalUrl @"http://api.miaotu.com/v1.1/user?token=%@&uid=%@"
#import "QFRequestManger.h"
#import "AFNetworking.h"
#import "TravelDetailModel.h"
#import "PersonalCell.h"
#import "PersonalModel.h"
#import "chatButton.h"
#import "PersonModel2.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface PersonalViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *_oneArray;
    UITableView *_tableView;
    NSMutableArray *array;
    UILabel *label;
}
@end

@implementation PersonalViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self creatData];
    [self creatTableView];
    [self creatTabBar];
    // Do any additional setup after loading the view.
}
-(void)creatTabBar{
    UIView *tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH-49, SCREENW, 49)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    NSArray *array3 = @[@"icon_add.png",@"mine_chat.png",@"关注",@"聊天"];
   
    for(int i=0;i<2;i++){
        chatButton *button = [[chatButton alloc]initWithFrame:CGRectMake(i*SCREENW/2, 0, SCREENW/2, 49)];
        [button setImage:[UIImage imageNamed:array3[i]] forState:UIControlStateNormal];
        [button setTitle:array3[i+2] forState:UIControlStateNormal];
        if(i==0){
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.titleLabel.alpha = 1;
        button.tag = 100+i;
        [button addTarget:self action:@selector(chatsee:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0){
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW/2, 49)];
        label.text = @"取消关注";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor whiteColor];
        [button addSubview:label];
        }
        if(self.IsLike){
            label.alpha = 1;
        }else{
            label.alpha = 0;
        }
        [tabBarView addSubview:button];
    }
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [tabBarView addSubview:line];
    UILabel *shu = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW/2, 5, 0.5, 39)];
    shu.backgroundColor = [UIColor grayColor];
    shu.alpha = 0.4;
    [tabBarView addSubview:shu];
    [self.view addSubview:tabBarView];
}
-(void)chatsee:(UIButton *)button{
    if(button.tag == 100){
        NSDictionary *dica = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",self.uid,@"to_uid", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:focusUrl parameters:dica success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.IsLike = !self.IsLike;
            if(!self.IsLike){
                label.alpha = 0;
                [self creatData];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消关注成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }else{
                label.alpha = 1;
                [self creatData];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"关注成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else if (button.tag == 101){
        
    }
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    _oneArray = [[NSMutableArray alloc]init];
    //关于滑动照片的
    NSString *myUrl = [NSString stringWithFormat:picsUrl,self.token,self.uid];
    [QFRequestManger requestWithUrl:myUrl IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *items = [rootDic objectForKey:@"Items"];
        array = [[NSMutableArray alloc]initWithArray:items];
        for(NSDictionary *dicq in items){
            PersonalModel *model = [PersonalModel initWithDict:dicq];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failed:^{
        
    }];
    //关于主页内容的
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:personalUrl,self.token,self.uid]IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        dic = [rootDic objectForKey:@"Items"];
        PersonModel2 *model = [PersonModel2 initWithDict:dic];
        [_oneArray addObject:model];
        [_tableView reloadData];
    } failed:^{
        
    }];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _oneArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonModel2 *model = _oneArray[indexPath.row];
    PersonalCell *cell = [[PersonalCell alloc]init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.itemsArray = _dataArray;
    cell.dic = dic;
    cell.array = array;
    cell.fVC = self;
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *name = [[NSMutableArray alloc]initWithObjects:@"Country",@"Province",@"City",@"Home",@"LifeArea",@"WorkArea",@"FreeTime",@"Hobbies",@"AboutMe",@"Work",@"Birthday",@"Phone",@"Email",@"Education",@"GraduateSchool",@"Tags", @"Hobbies",nil];
    NSInteger y=(SCREENW-30)/3+570;
    for(int i=0;i<16;i++){
        y =y+40;
        if([[dic objectForKey:name[i]]isEqualToString:@""]){
            y=y-40;
            continue;
        }
    }
    return y;
}
-(void)creatNav{
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
    titleLable.text = @"个人主页";
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
