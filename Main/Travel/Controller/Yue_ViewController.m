//
//  Yue_ViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/10.
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
#import "myTabBarButton.h"
#import "AFNetworking.h"
#import "TravelDetailViewController.h"
#import "TravelViewController.h"
#import "UIView_advertisement.h"
#define yueUrl @"http://api.miaotu.com/v1.1/user/yueyou/%@?token=%@&uid=%@&type=%@&page=%d&num=12"
#define teamUrl @"http://api.miaotu.com/v1.1/user/activity/%@?token=%@&uid=%@&type=%@&page=%d&num=12"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#import "Yue_ViewController.h"

@interface Yue_ViewController ()
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
}
@end

@implementation Yue_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    _selected = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    _page2 = 1;
    _selected = NO;
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
-(void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(start) name:@"downdata" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finish) name:@"downfinished" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(load) name:@"load" object:nil];
}
-(void)load{
    _isPull = YES;
    [self creatData];
    cell.dataArray = _dataArray;
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
    if(self.selectedButton.tag == 100){
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
    if(self.selectedButton.tag == 100){
        _page ++;
    }else if(self.selectedButton.tag == 101){
        _page2++;
    }
    [self creatData];
    [_tableView footerEndRefreshing];
}
//创建tableview
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
//实现tableview的两个代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selectedButton.tag == 100){
    return _dataArray.count;
    }else{
        return _dataArray2.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectedButton.tag == 100){
    cell = [[TravelCell alloc]initWithFrame:CGRectMake(0, 300*indexPath.row, 320, 300)];
    cell.FatherVC = self;
    cell.num = 0;
    ItemsModel *model = _dataArray[indexPath.row];
    cell.row = indexPath.row;
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
    if(self.selectedButton.tag == 100){
        ItemsModel *model = _dataArray[indexPath.row];
        CGRect rect = [model.Remark boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
                    return rect.size.height+255;
    }else{
        return 280;
    }

}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedButton.tag == 100){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TravelDetailViewController *travelVC = [[TravelDetailViewController alloc]init];
        ItemsModel *model = _dataArray[indexPath.row];
        travelVC.Yid = model.Yid;
        travelVC.myModel = model;
        travelVC.hidesBottomBarWhenPushed = YES;
       [self presentViewController:travelVC animated:YES completion:^{
           
       }];
    }else{
        ItemsModel2 *model = _dataArray2[indexPath.row];
        adViewController *adV = [[adViewController alloc]init];
        adV.Title = model.Title;
        adV.url = [NSString stringWithFormat:@"http://m.miaotu.com/App32/detail/?aid=%@&token=98aa550d-6758-11e5-bb24-00163e002e59&uid=%@",model.Aid,model.Uid];
        adV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adV animated:YES];
    }
}
//创建数据
-(void)creatData{
    if(_isPull == YES){
        [_dataArray removeAllObjects];
        [_dataArray2 removeAllObjects];
    }
    if(self.selectedButton.tag == 100){
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:yueUrl,self.type,@"98aa550d-6758-11e5-bb24-00163e002e59",self.Uid,self.type,_page]] IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        id objc = [rootDic objectForKey:@"Items"];
        if([objc isKindOfClass:[NSArray class]]){
        for(NSDictionary *dic in objc){
            ItemsModel *model = [ItemsModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        }if(_dataArray.count == 0){
            [_tableView removeFromSuperview];
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104)];
            view.backgroundColor = [UIColor grayColor];
            view.alpha = 0.4;

            UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, SCREENW-200, 100)];
            t.text = @"TA还没有发起的‘一起去’,你可以去首页再逛逛哦~";
            t.numberOfLines = 0;
            t.font = [UIFont systemFontOfSize:15];
            t.textAlignment = NSTextAlignmentCenter;
            t.textColor = [UIColor redColor];
            [view addSubview:t];
            [self.view addSubview:view];
        }
        [_tableView reloadData];
    } failed:^{
        NSLog(@"失败");
    }];
    }else if(self.selectedButton.tag == 101){
        [QFRequestManger requestWithUrl:[NSString stringWithFormat:teamUrl,self.type,@"98aa550d-6758-11e5-bb24-00163e002e59",self.Uid,self.type,_page2] IsCache:NO finish:^(NSData *data) {
            //主页显示
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            id objc = [rootDic objectForKey:@"Items"];
            if([objc isKindOfClass:[NSArray class]]){
                for (NSDictionary *dic in  objc) {
                    ItemsModel2 *model = [ItemsModel2 initWithDict:dic];
                    [_dataArray2 addObject:model];
                }
            }

            if(_dataArray2.count == 0){
                [_tableView removeFromSuperview];
                view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104)];
                view2.backgroundColor = [UIColor grayColor];
                view2.alpha = 0.4;
                UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, SCREENW-200, 100)];
                t.text = @"TA还没有发起的‘妙旅团’,你可以去首页再逛逛哦~";
                t.numberOfLines = 0;
                t.font = [UIFont systemFontOfSize:15];
                t.textAlignment = NSTextAlignmentCenter;
                t.textColor = [UIColor redColor];
                [view2 addSubview:t];
                [self.view addSubview:view2];
                
            }
            [_tableView reloadData];
        } failed:^{
            
        }];
        [_tableView reloadData];
    }
    
}
//触摸弹回
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [cornView removeFromSuperview];
    _selected = !_selected;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _selected = !_selected;
}
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
    titleLable.text = self.title;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    //装button
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, 40)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    //button
    NSArray *array = @[@"一起去",@"秒旅团"];
    for(int i=0;i<2;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15+(SCREENW-30)/2*i, 3, (SCREENW-30)/2, 34);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.tag = 100+i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        if(button.tag == 100){
            button.selected = YES;
            [button setBackgroundColor:[UIColor orangeColor]];
            self.selectedButton = button;
       }
        button.layer.borderWidth = 1;
        button.layer.borderColor = [[UIColor orangeColor]CGColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW/2-5, 3, 10, 34)];
        l.backgroundColor = [UIColor orangeColor];
        [backView addSubview:l];
        [backView addSubview:button];
    }
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 104, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [self.view addSubview:line];
}
-(void)go:(UIButton *)button{
    [self.selectedButton setBackgroundColor:[UIColor whiteColor]];
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    button.selected = YES;
    [button setBackgroundColor:[UIColor orangeColor]];
    [_tableView removeFromSuperview];
    if(button.tag == 100){
            _page = 1;
            _isPull = YES;
        [view2 removeFromSuperview];
        [self creatData];
            [self creatTableView];
            [self creatRefresh];
        }else if(button.tag == 101){
            _page2 = 1;
            _isPull = YES;
            [view removeFromSuperview];
            [self creatData];
            [self creatTableView];
            [self creatRefresh];
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
