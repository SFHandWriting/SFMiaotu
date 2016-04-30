//
//  FriendViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "FriendViewController.h"
#import "QFRequestManger.h"
#import "FriendItemsModel.h"
#import "FriendItemCell.h"
#import "MJRefresh.h"
#import "Friend_neiDetailViewController.h"
#define url @"http://api.miaotu.com/v1.1/users?token=%@=&latitude=%@&longitude=%@&num=%@&type=%@"
#define  url2 @"http://api.miaotu.com/v1.1/users?token=%@&page=&latitude=%@&longitude=%@&num=%@&type=%@"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface FriendViewController ()
{
    BOOL _isPull;//判断下拉还是上啦
    NSInteger _num;
    NSString *_numStr;
    NSInteger _num2;
    BOOL _selected;
    NSString *_num2Str;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray2;
    NSMutableArray *_myArray;
    UITableView *_tableView;
    FriendItemCell *cell;
    UIActivityIndicatorView *ac;
}
@end

@implementation FriendViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _selected = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _numStr = @"30";
    _num2Str = @"30";
    _dataArray = [[NSMutableArray alloc]init];
    _dataArray2 = [[NSMutableArray alloc]init];
    [self creatMyNav];
    [self creatActivity];
    [self addObserver];
    [self creatData];
    [self creatTableView];
    [self creatRefresh];
    // Do any additional setup after loading the view.
}
//添加观察者
-(void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(start) name:@"downdata" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finish) name:@"downfinished" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(load) name:@"load" object:nil];
}
-(void)load{
    _isPull = YES;
    [self creatData];

}
-(void)start{
    //开始转
    [ac startAnimating];
    
    [self.view addSubview:ac];
    
    //让状态栏的菊花同步转
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(void)finish{
    //停止转动
    [ac stopAnimating];
    //状态栏上的菊花也停止转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//创建菊花
-(void)creatActivity{
    ac = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    ac.tag = 100;
    //设置 位置
    ac.center = self.view.center;
    ac.color = [UIColor orangeColor];
}

-(void)creatRefresh{
    //加头
    [_tableView addHeaderWithTarget:self action:@selector(pullRefresh)];
    //加尾
    [_tableView addFooterWithTarget:self action:@selector(pushRefresh)];
}
-(void)pullRefresh{
    
    if(self.selectedButton.tag == 101){
       _numStr = @"30";
    }else{
        _num2Str = @"30";
    }
    [self creatData];
    //当数据请求结束后 结束下拉刷新的过程
    [_tableView headerEndRefreshing];
}
-(void)pushRefresh{
    //因为每次调用这个方法 都是在改变网址的num参数 而且每次都是num参数+10，所以给全局的_num+10；
    if(self.selectedButton.tag == 101){
        _num = _num + 30;
        _numStr = [NSString stringWithFormat:@"%d",_num];
    }else if(self.selectedButton.tag == 102){
        _num2 = _num2 + 30;
        _num2Str = [NSString stringWithFormat:@"%d",_num2];
    }
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
    if(self.selectedButton.tag == 101){
    return _dataArray.count;
    }else{
        return _dataArray2.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [[FriendItemCell alloc]init];
    FriendItemsModel *model;
    if(self.selectedButton.tag == 101){
     model = _dataArray[indexPath.row];
    }else{
        model = _dataArray2[indexPath.row];
    }
    cell.str = @"jing";
    cell.model = model;
    cell.FatherVC = self;
    [cell finishCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendItemsModel *model;
    if(self.selectedButton.tag == 101){
    model = _dataArray[indexPath.row];
    }else{
        model = _dataArray2[indexPath.row];
    }
    CGRect rect = [model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    if(model.PicList.count>0){
        return 75+rect.size.height+(SCREENW-30)/3;
    }else{
        return 75+rect.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Friend_neiDetailViewController *neiVC = [[Friend_neiDetailViewController alloc]init];
    neiVC.hidesBottomBarWhenPushed = YES;
    FriendItemsModel *modeli;
    if(self.selectedButton.tag == 101){
    modeli = _dataArray[indexPath.row];
    }else{
        modeli = _dataArray2[indexPath.row];
    }
    neiVC.model = modeli;
    neiVC.Sid = [NSString stringWithFormat:@"%@",modeli.Sid];
    [self.navigationController pushViewController:neiVC animated:YES];
}
//创造数据
-(void)creatData{
    NSString *s;
    if(self.selectedButton.tag == 101){
    s = [NSString stringWithFormat:url,@"98aa550d-6758-11e5-bb24-00163e002e59&page",@"40.113643",@"116.25177",_numStr,@"nearby"];
    }else{
        s = [NSString stringWithFormat:url2,@"98aa550d-6758-11e5-bb24-00163e002e59&page",@"40.113643",@"116.25177",_num2Str,@"like"];
    }
    [QFRequestManger requestWithUrl:s IsCache:YES finish:^(NSData *data) {
        [_dataArray removeAllObjects];
                [_dataArray2 removeAllObjects];
                [_myArray removeAllObjects];
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *ItemsArray = [rootDic objectForKey:@"Items"];
        for(NSDictionary *dic in ItemsArray){
            FriendItemsModel *model = [FriendItemsModel initWithDict:dic];
            if(self.selectedButton.tag == 101){
            [_dataArray addObject:model];
            }else{
            [_dataArray2 addObject:model];
            }
        }
        NSArray *RecommentUserArray = [rootDic objectForKey:@"RecommentUser"];
        for(NSDictionary *dic in RecommentUserArray){
            FriendItemsModel *model = [FriendItemsModel initWithDict:dic];
            [_myArray addObject:model];
        }
        [_tableView reloadData];
    } failed:^{
        
    }];
}
//自定义导航栏
-(void)creatMyNav{
    UIView *navBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 64)];
    navBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBackView];
    //闹铃
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(18, 33, 24, 24);
    searchButton.tag = 100;
    searchButton.alpha = 0.7;
    [searchButton setImage:[UIImage imageNamed:@"icon_topic_message.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    [navBackView addSubview:searchButton];
    //一起去和妙旅团
    NSArray *btnNameArray = @[@"身旁",@"好友"];
    for(int i=0;i<2;i++){
        UIButton *buutton = [UIButton buttonWithType:UIButtonTypeCustom];
        buutton.frame = CGRectMake(SCREENW/2-60+68*i, 30, 60, 25);
        buutton.titleLabel.font = [UIFont systemFontOfSize:18];
        buutton.tag = 101+i;
        buutton.alpha = 0.5;
        [buutton setTitle:btnNameArray[i] forState:UIControlStateNormal];
        [buutton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [buutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [buutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //加装饰_按钮底部
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW/2-60+68*i, 62, 60, 2)];
        label.backgroundColor = [UIColor orangeColor];
        label.tag = 201+i;
        label.alpha = 0;
        if(i==0){
            buutton.selected = YES;
            buutton.alpha = 1;
            self.selectedButton = buutton;
            label.alpha = 1;
            self.selectedlabel = label;
        }
        [navBackView addSubview:label];
        [navBackView addSubview:buutton];
    }
}
//闹铃
-(void)message{
    
}
//身旁   好友
-(void)click:(UIButton *)button{
    self.selectedButton.selected = NO;
    self.selectedButton.alpha = 0.5;
    self.selectedButton = button;
    button.alpha = 1;
    button.selected = YES;
    self.selectedlabel.alpha = 0;
    self.selectedlabel = (UILabel *)[self.view viewWithTag:button.tag+100];
    self.selectedlabel.alpha = 1;
    [self creatData];
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
