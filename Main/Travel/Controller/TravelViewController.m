//
//  TravelViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#import "QFRequestManger.h"
#import "MJRefresh.h"
#import "TravelCell.h"
#import "adViewController.h"
#import "TeamCell.h"
#import "TopicModel.h"
#import "BannerModel.h"
#import "ItemsModel.h"
#import "ItemsModel2.h"
#import "SearchViewController.h"
#import "myTabBarButton.h"
#import "AFNetworking.h"
#import "TravelDetailViewController.h"
#import "TravelViewController.h"
#import "SendViewController.h"
#import "UIView_advertisement.h"
#define degreeTOradians(x) (M_PI * (x)/180)
#define url1 @"http://api.miaotu.com/v1.1/yueyou/list?token=98aa550d-6758-11e5-bb24-00163e002e59&page=%d&num=10&latitude=40.113621&longitude=116.251748&filter=%@"
#define url2 @"http://api.miaotu.com/v1.1/activity/list?token=98aa550d-6758-11e5-bb24-00163e002e59&city=&page=%d&num=12"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface TravelViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray2;
    NSMutableArray *_adArray;
    NSMutableArray *_TopicArray;
    NSInteger _cellHeight;
    BOOL _isPull;//判断下拉还是上啦
    NSInteger _page;
    NSInteger _page2;
    NSMutableArray *piarray;
    UIView *cornView;
    UIView *chooseView;
    UIButton *chooseBuutton;
    NSString *_questStr;
    UIActivityIndicatorView *ac;
    BOOL _selected;
    TravelCell *cell;
    UIButton *addButton;
    UIButton *sendButton;
}
@end
@implementation TravelViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _selected = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _page2 = 1;
    _questStr = @"";
    _selected = NO;
    _dataArray = [[NSMutableArray alloc]init];
    _dataArray2 = [[NSMutableArray alloc]init];
    _adArray = [[NSMutableArray alloc]init];
    _TopicArray = [[NSMutableArray alloc]init];
    [self creatMyNav];
    [self creatActivity];
    [self addObserver];
    [self creatData];
    [self creatTableView];
    [self creatRefresh];
    //添加发起
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(SCREENW-40, SCREENH-89, 35, 35);
    [addButton setImage:[UIImage imageNamed:@"icon_publish.png"] forState:UIControlStateNormal];
    addButton.alpha = 0.9;
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
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
    //cell.dataArray = _dataArray;
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
    
    _isPull = YES;
    _questStr = @"";
    if(self.selectedButton.tag == 101){
        _page=1;
    }else{
        _page2=1;
    }
    [self creatData];
    //当数据请求结束后 结束下拉刷新的过程
    [_tableView headerEndRefreshing];
}
-(void)pushRefresh{
    
    _isPull = NO;
    //因为每次调用这个方法 都是在改变网址的page参数 而且每次都是page参数+1，所以给全局的_page++；
    if(self.selectedButton.tag == 101){
        _page ++;
    }else if(self.selectedButton.tag == 102){
        _page2++;
    }
    [self creatData];
    [_tableView footerEndRefreshing];
}
//创建tableview
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-49-64) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
//实现tableview的两个代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selectedButton.tag == 101){
    return _dataArray.count;
    }else{
        return _dataArray2.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedButton.tag == 101){
    //广告栏
    UIView_advertisement *adView = [[UIView_advertisement alloc]initWithFramex:0 y:64 width:SCREENW height:150 toTableView:nil Auto:YES time:4 circle:YES PictureNameArray:nil pictureUrlArray:piarray scrollViewFramex:0 y:0 width:SCREENW height:150 pageControlFramex:SCREENW/2-10 y:110 width:10 height:50 labelFrame:CGRectMake(0, 0, 0, 0) labelBackGroundColor:nil textFont:0 modelArray:_adArray];
    _tableView.tableHeaderView = adView;
    adView.fatherVC = self;
     cell = [[TravelCell alloc]initWithFrame:CGRectMake(0, 300*indexPath.row, 320, 300)];
    cell.FatherVC = self;
    cell.num =1;
    ItemsModel *model = _dataArray[indexPath.row];
    cell.row = indexPath.row;
    cell.topicArray = _TopicArray;
    cell.dataArray = _dataArray;
    cell.model = model;
    [cell finishCellWithModel:model];
        return cell;
    }else{
        TeamCell *cell2 = [[TeamCell alloc]initWithFrame:CGRectMake(0, indexPath.row*300, SCREENW, 300)];
        ItemsModel2 *model = _dataArray2[indexPath.row];
        cell2.model = model;
        cell2.fatherVC = self;
        return cell2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedButton.tag == 101){
    ItemsModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.Remark boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    if(indexPath.row == 0){
        return rect.size.height+255+80;
    }else{
    return rect.size.height+255;
    }
    }else{
        return 280;
    }
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.3 animations:^{
        sendButton.frame = CGRectMake(SCREENW-110, SCREENH-89, 70, 35);
    } completion:^(BOOL finished) {
        sendButton.alpha = 0;
        addButton.alpha = 0.9;
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectedButton.tag == 101){
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cornView removeFromSuperview];
    [chooseView removeFromSuperview];
    _selected = !_selected;
        TravelDetailViewController *travelVC = [[TravelDetailViewController alloc]init];
        ItemsModel *model = _dataArray[indexPath.row];
        travelVC.Yid = model.Yid;
        travelVC.myModel = model;
        travelVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:travelVC animated:YES];
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
//创建数据
-(void)creatData{
    if(self.selectedButton.tag == 101){//一起去
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:url1,_page,_questStr] IsCache:NO finish:^(NSData *data) {
        if(_isPull == YES){
            [_dataArray removeAllObjects];
            [_adArray removeAllObjects];
            [_TopicArray removeAllObjects];
        }
        //主页显示
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *itemsArray = [rootDic objectForKey:@"Items"];
        for (NSDictionary *dic in  itemsArray) {
            ItemsModel *model = [ItemsModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        if(_page == 1){
        //广告栏
        piarray = [[NSMutableArray alloc]init];
        NSArray *BannerArray = [rootDic objectForKey:@"Banner"];
            for(NSDictionary *dicp in BannerArray){
                BannerModel *model = [BannerModel initWithDict:dicp];
                [piarray addObject:model.PicUrl];
                [_adArray addObject:model];
            }
        //话题
        
        NSArray *TopicArray = [rootDic objectForKey:@"Topic"];
        for(NSDictionary *dic in TopicArray){
            TopicModel *model = [TopicModel initWithDict:dic];
            [_TopicArray addObject:model];
        }
    }
        [_tableView reloadData];
   } failed:^{
        
    }];
    }else{//秒旅团
        [QFRequestManger requestWithUrl:[NSString stringWithFormat:url2,_page2] IsCache:NO finish:^(NSData *data) {
            if (_isPull == YES) {
                [_dataArray2 removeAllObjects];
            }
            //主页显示
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            id objc = [rootDic objectForKey:@"Items"];
            if([objc isKindOfClass:[NSArray class]]){
            for (NSDictionary *dic in  objc) {
                ItemsModel2 *model = [ItemsModel2 initWithDict:dic];
                [_dataArray2 addObject:model];
            }
            }
            [_tableView reloadData];
            _tableView.tableHeaderView = nil;
     } failed:^{
            
        }];
    }
}
//自定义导航栏
-(void)creatMyNav{
    UIView *navBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 64)];
    navBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBackView];
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(18, 33, 24, 24);
    searchButton.tag = 100;
    searchButton.alpha = 0.7;
    [searchButton setImage:[UIImage imageNamed:@"icon_search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [navBackView addSubview:searchButton];
    //一起去和妙旅团
    NSArray *btnNameArray = @[@"一起去"];
    UIButton *buutton = [UIButton buttonWithType:UIButtonTypeCustom];
    buutton.frame = CGRectMake(SCREENW/2, 30, 60, 25);
    buutton.center = CGPointMake(SCREENW/2, 42);
    buutton.titleLabel.font = [UIFont systemFontOfSize:18];
    buutton.tag = 101;
    buutton.alpha = 0.5;
    [buutton setTitle:btnNameArray[0] forState:UIControlStateNormal];
    [buutton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [buutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [buutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    buutton.selected = YES;
    buutton.alpha = 1;
    self.selectedButton = buutton;
    [navBackView addSubview:buutton];
    
    //筛选
    chooseBuutton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBuutton.frame = CGRectMake(SCREENW-60, 32, 60, 20);
    chooseBuutton.titleLabel.font = [UIFont systemFontOfSize:14];
    chooseBuutton.tag = 103;
    chooseBuutton.alpha = 0.4;
    [chooseBuutton setTitle:@"筛选" forState:UIControlStateNormal];
    [chooseBuutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [chooseBuutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navBackView addSubview:chooseBuutton];
    //加装饰_导航底部
    UILabel *lengLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 62, SCREENW, 3)];
    lengLabel.backgroundColor = [UIColor orangeColor];
    lengLabel.alpha = 0.2;
    [navBackView addSubview:lengLabel];
    
    
}
-(void)add{
     addButton.alpha = 0;
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.backgroundColor = [UIColor orangeColor];
    [sendButton setTitle:@"发起约游" forState:UIControlStateNormal];
    sendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sendButton.frame = CGRectMake(SCREENW-75, SCREENH-89, 70, 35);
    sendButton.layer.cornerRadius = 35/2;
    sendButton.alpha = 1;
    sendButton.layer.masksToBounds = YES;
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    [UIView animateWithDuration:0.1 animations:^{
        sendButton.frame = CGRectMake(SCREENW-110, SCREENH-89, 70, 35);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
          sendButton.frame = CGRectMake(SCREENW-75, SCREENH-89, 70, 35);
        }];
    }];
}
-(void)send{
    SendViewController *sendVC = [[SendViewController alloc]init];
    [self.navigationController pushViewController:sendVC animated:YES];
}
//触摸弹回
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [cornView removeFromSuperview];
    [chooseView removeFromSuperview];
    _selected = !_selected;
    [UIView animateWithDuration:0.3 animations:^{
        sendButton.frame = CGRectMake(SCREENW-110, SCREENH-89, 70, 35);
    } completion:^(BOOL finished) {
        sendButton.alpha = 0;
        addButton.alpha = 0.9;
    }];
}
//筛选功能
-(void)choose:(UIButton *)button{
    _selected = !_selected;
    if(_selected){
    cornView = [[UIView alloc]initWithFrame:CGRectMake(SCREENW-25, 67.5, 5, 5)];
    cornView.backgroundColor = [UIColor whiteColor];
    cornView.transform = CGAffineTransformIdentity;
    cornView.transform = CGAffineTransformMakeRotation(degreeTOradians(45));
    [self.view addSubview:cornView];
    chooseView = [[UIView alloc]initWithFrame:CGRectMake(SCREENW-80, 70, 77, 100)];
    chooseView.backgroundColor = [UIColor whiteColor];
    chooseView.layer.cornerRadius = 3;
    chooseView.layer.masksToBounds = YES;
    NSArray *array = @[@"默认排序",@"按距离",@"按人气"];
    for(int i=0;i<3;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*33, 77, 33);
        //装饰
        if(i<2){
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 32, 57, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.5;
        [button addSubview:line];
        }
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.tag = 50+i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.alpha = 0.6;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(range:) forControlEvents:UIControlEventTouchUpInside];
        [chooseView addSubview:button];
    }
    [self.view addSubview:chooseView];
    }else{
        [cornView removeFromSuperview];
        [chooseView removeFromSuperview];
    }
}
//排序
-(void)range:(UIButton *)button{
    if(button.tag == 50){//默认排序
        _page = 1;
        _questStr = @"";
        _isPull = YES;
        [chooseBuutton setTitle:@"筛选" forState:UIControlStateNormal];
        [self creatData];
    }else if (button.tag == 51){//按距离
        _page = 1;
        _questStr = @"dis";
        _isPull = YES;
        [chooseBuutton setTitle: @"按距离" forState:UIControlStateNormal];
        [self creatData];
    }else if (button.tag == 52){//按人气
        _page = 1;
        _isPull = YES;
        _questStr = @"hot";
        [chooseBuutton setTitle:@"按人气" forState:UIControlStateNormal];
        [self creatData];
    }
}
//一起去，妙旅团
-(void)click:(UIButton *)button{
    self.selectedButton.selected = NO;
    self.selectedButton.alpha = 0.5;
    self.selectedButton = button;
    self.selectedButton.alpha = 1;
    self.selectedButton.selected = YES;
    self.selectedlabel.alpha = 0;
    self.selectedlabel = (UILabel *)[self.view viewWithTag:button.tag+100];
    self.selectedlabel.alpha = 1;
    _isPull = YES;
    if(button.tag == 101){
        _page = 1;
        chooseBuutton.alpha = 0.4;
        [self creatData];
    }else{
        _page2 = 1;
        chooseBuutton.alpha = 0;
        [self creatData];
        
    }
    
}
//导航栏搜索功能
-(void)search{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [cornView removeFromSuperview];
    [chooseView removeFromSuperview];
    _selected = !_selected;
    [UIView animateWithDuration:0.3 animations:^{
        sendButton.frame = CGRectMake(SCREENW-110, SCREENH-89, 70, 35);
    } completion:^(BOOL finished) {
        sendButton.alpha = 0;
        addButton.alpha = 0.9;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
