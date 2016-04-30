//
//  CommendViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#define myUrl @"http://api.miaotu.com/v1.1/%@/reply?token=%@&%@=%@&page=1&num=1000"
#import "CommendViewController.h"
#import "QFRequestManger.h"
#import "CommendModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "CommendCell.h"
#import "UITextField_TL.h"
#define commendUrl @"http://api.miaotu.com/v1.1/%@/reply"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface CommendViewController ()
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSInteger _height;
    UIView *tabBarView;
    UITextView *myTextView;
}
@end

@implementation CommendViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _height = 0;
    [self creatNav];
    [self creatTabBar];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatTabBar{
    tabBarView = [[UIView alloc]init];
    tabBarView.frame = CGRectMake(0, SCREENH-49, SCREENW, 79);
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, SCREENW, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [tabBarView addSubview:line];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, SCREENW, 1)];
    line2.backgroundColor = [UIColor grayColor];
    line2.alpha = 0.2;
    [tabBarView addSubview:line2];
    UIImageView *myHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 20, 20)];
    myHeaderView.image = [UIImage imageNamed:@"icon_default_head_photo.png"];
    myHeaderView.layer.cornerRadius = 10;
    myHeaderView.layer.masksToBounds = YES;
    [tabBarView addSubview:myHeaderView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 49 , SCREENW, 30)];
    label.backgroundColor = [UIColor whiteColor];
    [tabBarView addSubview:label];
   myTextView = [[UITextView alloc]initWithFrame:CGRectMake(50, 12 , SCREENW-100, 25)];
    //修改字号
    myTextView.font = [UIFont systemFontOfSize:14];
    //设置字体颜色
    myTextView.textColor = [UIColor blackColor];
    //设置光标从头开始显示 默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    //因为没有placeholder属性 所以先设置文本
    myTextView.text = @"在这里说点什么吧";
    myTextView.alpha = 0.6;
    //使用代理方法 来清除textView.text
    
    myTextView.delegate = self;
    [tabBarView addSubview:myTextView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENW-30, 18, 19, 17);
    [button setImage:[UIImage imageNamed:@"icon_list_comment.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:button];
}
-(void)comment{
    self.string = myTextView.text;
    NSString *encode = [NSString stringWithString:[self.string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *dic;
    if([self.type isEqualToString:@"yueyou"]){
     dic = [NSDictionary dictionaryWithObjectsAndKeys:self.token,@"token",self.yid,@"yid",@"",@"rid",encode,@"content",nil];
    }else{
        dic = [NSDictionary dictionaryWithObjectsAndKeys:self.token,@"token",self.aid,@"aid",@"",@"yrid",encode,@"content",nil];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *s = [NSString stringWithFormat:commendUrl,self.type];
    [manager POST:s parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       myTextView.text = nil;
       [self creatData];
       [self creatTableView];
       [self.view endEditing:YES];
       _tableView.frame = CGRectMake(0, 64, SCREENW, SCREENH-64-49);
       tabBarView.frame = CGRectMake(0, SCREENH-49, SCREENW, 69);
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发表评论成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"load" object:@"YES"];
       [alert show];
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   }];
    
}
//在这个touch方法里 收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _tableView.frame = CGRectMake(0, 64, SCREENW, SCREENH-64-49);
    tabBarView.frame = CGRectMake(0, SCREENH-49, SCREENW, 69);
    [self.view endEditing:YES];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (self.string.length == 0) {
        textView.text = @"";
        
    }else{
        
        textView.text = self.string;
    }
    [UIView animateWithDuration:0.24 animations:^{
        tabBarView.frame = CGRectMake(0, SCREENH-288, SCREENW, 69);
        _tableView.frame = CGRectMake(0, 64, SCREENW, SCREENH-350);
    } completion:^(BOOL finished) {
            }];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    self.string = textView.text;
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    //当结束编辑的时候,记录一次输入框里输入的文本
    if (self.string.length == 0) {
        textView.text = @"在这里说点什么吧";
        
    }
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
    if(_dataArray.count){
    titleLable.text = [NSString stringWithFormat:@"评论%d",_dataArray.count];
    }else{
     titleLable.text = @"评论";
    }
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
   [self dismissViewControllerAnimated:YES completion:^{
       
   }];
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    NSString *s;
    if([self.type isEqualToString:@"yueyou"]){
        s = [NSString stringWithFormat:myUrl,self.type,self.token,@"yid",self.yid];
    }else{
       s = [NSString stringWithFormat:myUrl,self.type,self.token,@"aid",self.aid];
    }
    [QFRequestManger requestWithUrl:s IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        id objc = [rootDic objectForKey:@"Items"];
        
        if([objc isKindOfClass:[NSArray class]]){
        NSArray *items = [rootDic objectForKey:@"Items"];
        for(NSDictionary *dic in items){
            CommendModel *model = [CommendModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        }else{
            self.view.backgroundColor = [UIColor whiteColor];
            [_tableView removeFromSuperview];
            UIView *nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-49-64)];
            nilView.backgroundColor = [UIColor grayColor];
            nilView.alpha = 0.3;
            [self.view addSubview:nilView];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW-100)/2, SCREENH/2-100, 100, 100)];
            imageView.image = [UIImage imageNamed:@"icon_default_comment.png"];
            [self.view addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-100)/2, SCREENH/2, 100, 50)];
            label.text = @"暂无评论!";
            label.alpha = 0.4;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:18];
            [self.view addSubview:label];
        }
    } failed:^{
        
    }];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64-49) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommendCell *cell = [[CommendCell alloc]initWithFrame:CGRectMake(0, 300*indexPath.row, 320, 300)];
    CommendModel *model = _dataArray[indexPath.row];
    cell.fatherVC = self;
    cell.model = model;
    [cell finishCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommendModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    //_height = _height+rect.size.height+50;
    return rect.size.height+50;
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
