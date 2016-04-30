//
//  Friend_neiDetailViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "Friend_neiDetailViewController.h"
#import "QFRequestManger.h"
#define commentUrl @"http://api.miaotu.com/v1.1/user/state/reply"
#import "CommendModel.h"
#import "ageButton.h"
#import "FCommentCell.h"
#import "QFRequestManger.h"
#import "PersonalViewController.h"
#import "FlikeButton.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "PicViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface Friend_neiDetailViewController ()
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSInteger _height;
    UIView *tabBarView;
    UITextView *myTextView;

}
@end

@implementation Friend_neiDetailViewController

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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"rid",@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",self.Sid,@"sid",encode,@"content",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:commentUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        myTextView.text = nil;
        [self creatData];
        [self creatTableView];
        [self.view endEditing:YES];
        _tableView.frame = CGRectMake(0, 64, SCREENW, SCREENH-64-49);
        tabBarView.frame = CGRectMake(0, SCREENH-49, SCREENW, 69);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发表评论成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
    titleLable.text = @"动态正文";
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
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-49-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    NSInteger p;
    CGRect rect2 = [_model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    if(_model.PicList.count>0){
        p= 75+rect2.size.height+(SCREENW-30)/3;
    }else{
        p= 75+rect2.size.height;
    }
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, p+30)];
    //头像
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerButton.frame = CGRectMake(10, 5, 30, 30);
    [headerButton addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    headerButton.layer.cornerRadius = 15;
    headerButton.layer.masksToBounds = YES;
    //头像网址
    NSMutableArray *myPicArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in _model.PicList){
        [myPicArray addObject:[dic objectForKey:@"Url"]];
    }
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [headerView sd_setImageWithURL:[NSURL URLWithString:_model.HeadUrl] placeholderImage:[UIImage imageNamed:@"icon_default_head_photo.png"]];
    [headerButton addSubview:headerView];
    [View addSubview:headerButton];
    //nickname
    CGRect rectLength = [_model.Nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    UILabel *nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, rectLength.size.width, 20)];
    nickNameLabel.text = _model.Nickname;
    nickNameLabel.numberOfLines = 1 ;
    nickNameLabel.font = [UIFont systemFontOfSize:14];
    nickNameLabel.alpha = 0.6;
    [View addSubview:nickNameLabel];
    //age
    ageButton *agebutton = [[ageButton alloc]initWithFrame:CGRectMake(53+rectLength.size.width, 8, 40, 14)];
    if([_model.Gender isEqualToString:@"女"]){
        agebutton.backgroundColor = [UIColor redColor];
        [agebutton setImage:[UIImage imageNamed:@"icon_girl.png"] forState:UIControlStateNormal];
    }else{
        agebutton.backgroundColor = [UIColor blueColor];
        [agebutton setImage:[UIImage imageNamed:@"icon_boy.png"] forState:UIControlStateNormal];
    }
    [agebutton setTitle:[NSString stringWithFormat:@"%@岁",_model.Age] forState:UIControlStateNormal];
    agebutton.alpha = 0.3;
    agebutton.titleLabel.font = [UIFont systemFontOfSize:12];
    agebutton.titleLabel.textColor = [UIColor whiteColor];
    agebutton.titleLabel.textAlignment = NSTextAlignmentRight;
    [View addSubview:agebutton];
    //感情状态
    UILabel *emotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(100+rectLength.size.width, 8, 60, 14)];
    if([_model.Gender isEqualToString:@"女"]){
        emotionLabel.backgroundColor = [UIColor redColor];
    }else{
        emotionLabel.backgroundColor = [UIColor blueColor];
    }
    emotionLabel.text = _model.MaritalStatus;
    emotionLabel.alpha = 0.3;
   emotionLabel.font = [UIFont systemFontOfSize:12];
    emotionLabel.textColor = [UIColor whiteColor];
    emotionLabel.textAlignment = NSTextAlignmentCenter;
    [View addSubview:emotionLabel];
    //喜欢
    FlikeButton *likeButton = [FlikeButton buttonWithType:UIButtonTypeCustom];
    [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [likeButton setImage:[UIImage imageNamed:@"icon_detail_like.png"] forState:UIControlStateNormal];
    likeButton.layer.borderWidth = 1;
    likeButton.layer.borderColor = [[UIColor grayColor]CGColor];
    [likeButton setImage:[UIImage imageNamed:@"icon_together_like_solid.png"] forState:UIControlStateSelected];
    likeButton.frame = CGRectMake(SCREENW-50, 5, 40, 20);
    [View addSubview:likeButton];
    //time
    UILabel *wantLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 280, 10)];
    wantLabel.font = [UIFont systemFontOfSize:12];
    wantLabel.alpha = 0.3;
    wantLabel.text = [NSString stringWithFormat:@"想去 %@",_model.WantGo];
    [View addSubview:wantLabel];
    //dec
    //    NSArray *decArray = [_model.Remark componentsSeparatedByString:@"#"];
    //    NSString *str1 = decArray[1];
    //    NSInteger length =str1.length+2;
    
    //    [_model.Remark addAttribute:(NSString *)kCTForegroundColorAttributeName
    //                        value:(id)color.CGColor
    //                        range:NSMakeRange(location, length)];
    CGRect rect = [_model.Content boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    UILabel *decLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREENW-15, rect.size.height)];
    decLabel.text = _model.Content;
    decLabel.numberOfLines = 0;
    decLabel.font = [UIFont systemFontOfSize:13];
    decLabel.numberOfLines = 0 ;
    decLabel.alpha = 0.6;
    [View addSubview:decLabel];
    if(_model.PicList.count>0){
        //first
        UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        firstButton.frame = CGRectMake(10, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
        firstButton.tag =200;
        [firstButton addTarget:self action:@selector(imageclick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *firstView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [firstView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[0]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [firstButton addSubview:firstView];
        [View addSubview:firstButton];
    }
    if(_model.PicList.count>1){
        //sec
        UIButton *secButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secButton.frame = CGRectMake(20+(SCREENW-40)/3, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
        secButton.tag = 201;
        [secButton addTarget:self action:@selector(imageclick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *secView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [secView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[1]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [secButton addSubview:secView];
        [View addSubview:secButton];
    }
    if(_model.PicList.count>2){
        //third
        UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdButton.frame = CGRectMake(30+2*(SCREENW-40)/3, 45+rect.size.height, (SCREENW-40)/3, (SCREENW-30)/3);
        thirdButton.tag = 202;
        [thirdButton addTarget:self action:@selector(imageclick) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *thirdView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREENW-40)/3, (SCREENW-30)/3)];
        [thirdView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",myPicArray[2]]] placeholderImage:[UIImage imageNamed:@"icon_default_bbs_photo.png"]];
        [thirdButton addSubview:thirdView];
        [View addSubview:thirdButton];
    }NSInteger s;
    
    if(_model.PicList.count>0){
        s=45+rect.size.height+(SCREENW-30)/3;
    }else{
        s=45+rect.size.height;
    }
    //距离
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, s, 200, 30)];
    distanceLabel.font = [UIFont systemFontOfSize:10];
    distanceLabel.alpha = 0.4;
    distanceLabel.text = [NSString stringWithFormat:@"%@km  %@",_model.Distance,_model.Created];
    [View addSubview:distanceLabel];
    //评论
    UILabel *comLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, s+30, 200, 30)];
    comLabel.text = @"评论";
    comLabel.textColor = [UIColor grayColor];
    comLabel.alpha = 0.3;
    comLabel.font = [UIFont systemFontOfSize:12];
    [View addSubview:comLabel];
    //线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, s+30, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.3;
    [View addSubview:line];
    _tableView.tableHeaderView = View;
    [self.view addSubview:_tableView];
}
-(void)imageclick{
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.k=2;
    picVC.picArray = _model.PicList;
    [self presentViewController:picVC animated:YES completion:^{
        
    }];}
-(void)headerClick{
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.uid = _model.Uid;
    personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
    personal.hidesBottomBarWhenPushed = YES;
    [self presentViewController:personal animated:YES completion:^{
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FCommentCell *cell = [[FCommentCell alloc]initWithFrame:CGRectMake(0, 300*indexPath.row, 320, 300)];
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

-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    [QFRequestManger requestWithUrl:[NSString stringWithFormat:@"http://api.miaotu.com/v1.1/user/state/reply?token=98aa550d-6758-11e5-bb24-00163e002e59&sid=%@&page=1&num=10",self.model.Sid] IsCache:NO finish:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *objc = [rootDic objectForKey:@"Items"];
        for(NSDictionary *dic in objc){
            CommendModel *model = [CommendModel initWithDict:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        } failed:^{
        
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
