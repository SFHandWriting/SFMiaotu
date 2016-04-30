//
//  RequestViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "RequestViewController.h"
#import "PicChooseViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface RequestViewController ()
{
    UIView *backView;
    UITextView *textView2;
    UILabel *count;
    NSTimer *_timer;
    UIView *view;
    UIView *view0;
    NSString *num;
    UILabel *numLabel;
}
@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.string = @"";
    num = @"3";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self creatNav];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    backView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 230, SCREENW, 5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [backView addSubview:line];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-200)/2, 90, 200, 30)];
    label.text = @"选择约伴数量";
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.5;
    label.font = [UIFont systemFontOfSize:15];
    [backView addSubview:label];
    
    UIButton *view2 = [[UIButton alloc]initWithFrame:CGRectMake((SCREENW-60)/2, 130, 60, 60)];
    view2.backgroundColor = [UIColor orangeColor];
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 50, 20)];
    numLabel.text = @"1";
    [view2 addTarget:self action:@selector(chooseNum) forControlEvents:UIControlEventTouchUpInside];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor whiteColor];
    numLabel.font = [UIFont systemFontOfSize:20];
    [view2 addSubview:numLabel];
    view2.layer.cornerRadius = 30;
    view2.layer.masksToBounds = YES;
    [backView addSubview:view2];
    
    UILabel *reLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, SCREENW, 30)];
    reLabel.text = @"简述对侣伴的要求";
    reLabel.font = [UIFont systemFontOfSize:16];
    reLabel.alpha = 0.5;
    [backView addSubview:reLabel];
    
    UILabel *li = [[UILabel alloc]initWithFrame:CGRectMake(10, 275, SCREENW-10, 0.5)];
    li.backgroundColor = [UIColor grayColor];
    li.alpha = 0.5;
    [backView addSubview:li];
    
    //uitextview
    textView2 = [[UITextView alloc]initWithFrame:CGRectMake(10, 280, SCREENW-20, 120)];
    textView2.font = [UIFont systemFontOfSize:13];
    //设置字体颜色
    textView2.textColor = [UIColor grayColor];
    textView2.alpha = 0.8;
    //设置光标从头开始显示 默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    //因为没有placeholder属性 所以先设置文本
    textView2.text = @"简述约伴的要求或通过下面的标签快速选择";
    
    //使用代理方法 来清除textView.text
    
    textView2.delegate = self;
    
    [backView addSubview:textView2];
    
    UILabel *k = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, SCREENW-10, 0.5)];
    k.backgroundColor = [UIColor grayColor];
    k.alpha = 0.5;
    [backView addSubview:k];
    //
    count = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-60, 100, 50, 20)];
    count.textAlignment = NSTextAlignmentCenter;
    count.textColor = [UIColor blackColor];
    count.font = [UIFont systemFontOfSize:10];
    count.alpha = 0.4;
    count.text = [NSString stringWithFormat:@"0/10"];
    [textView2 addSubview:count];
    //biaoqian
    NSArray *array = @[@"颜值高",@"技术宅",@"土豪",@"萝莉",@"暖男",@"逗比",@"不限",@"御姐",@"大叔"];
    for(int i=0;i<9;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if(i<5){
        button.frame = CGRectMake(10+70*i, 410, 50, 20);
        }else{
            button.frame = CGRectMake(10+70*(i-5), 440, 50, 20);
        }
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.layer.borderColor = [[UIColor grayColor]CGColor];
        button.tag = 100+i;
        button.alpha = 0.7;
        [button addTarget:self action:@selector(tag:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
    }
    UILabel *h = [[UILabel alloc]initWithFrame:CGRectMake(0, 475, SCREENW, 5)];
    h.backgroundColor = [UIColor grayColor];
    h.alpha = 0.4;
    [backView addSubview:h];
    
    //
    UILabel *reLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 490, SCREENW, 30)];
    reLabel2.text = @"费用说明";
    reLabel2.font = [UIFont systemFontOfSize:16];
    reLabel2.alpha = 0.5;
    [backView addSubview:reLabel2];
    
    UILabel *li2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 525, SCREENW-10, 0.5)];
    li2.backgroundColor = [UIColor grayColor];
    li2.alpha = 0.5;
    [backView addSubview:li2];
    
    NSArray *array2 = @[@"免费",@"线下AA",@"我来买单",@"你请客"];
    for(int i=0;i<4;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+80*i, 540, 60, 30);
        [btn setTitle:array2[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderWidth = 0.5;
        if(i==0){
            self.selectedButton = btn;
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor orangeColor]];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.borderColor = [[UIColor grayColor]CGColor];
        btn.tag = 200+i;
        btn.alpha = 0.7;
        [btn addTarget:self action:@selector(money:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH-200)];
    view0.backgroundColor = [UIColor grayColor];
    view0.alpha = 0;
    [self.view addSubview:view0];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger w = scrollView.contentOffset.y/30;
    NSInteger s = scrollView.contentOffset.y;
    NSInteger q = s%30;
    if(q>15){
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, (w+1)*30);
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, w*30);
        }];
        
    }
        num = [NSString stringWithFormat:@"%d",(int)(scrollView.contentOffset.y/30+1)];
    if([num isEqualToString:@"21"]){
        num = @"无限";
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger w = scrollView.contentOffset.y/30;
    NSInteger s = scrollView.contentOffset.y;
    NSInteger q = s%30;
    if(q>15){
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, (w+1)*30);
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, w*30);
        }];
        
    }
    num = [NSString stringWithFormat:@"%d",(int)(scrollView.contentOffset.y/30+1)];
    if([num isEqualToString:@"21"]){
        num = @"无限";
    }
}
-(void)money:(UIButton *)button{
    [self.selectedButton setBackgroundColor:[UIColor whiteColor]];
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    button.selected = YES;
    [button setBackgroundColor:[UIColor orangeColor]];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)get:(NSTimer *)timer{
    if(textView2.text.length>10){
        textView2.text = [textView2.text substringToIndex:10];
    }
    count.text = [NSString stringWithFormat:@"%d/10",textView2.text.length];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
     _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(get:) userInfo:nil repeats:YES];
    CGPoint center = backView.center;
    NSInteger x = center.x;
    NSInteger y = center.y-45;
    [UIView animateWithDuration:0.25 animations:^{
        backView.center = CGPointMake(x, y);
    }];
    
    if (self.string.length == 0) {
        textView2.text = @"";
        
    }else{
        textView2.text = self.string;
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    CGPoint center = backView.center;
    NSInteger x = center.x;
    NSInteger y = center.y+45;
    [UIView animateWithDuration:0.25 animations:^{
        backView.center = CGPointMake(x, y);
    }];
    self.string = textView2.text;
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    //当结束编辑的时候,记录一次输入框里输入的文本
    if (self.string.length == 0) {
        textView2.text = @"简述约伴的要求或通过下面的标签快速选择";
    }
}
//在这个touch方法里 收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(view0.alpha != 0){
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = backView.center;
        NSInteger x = center.x;
        NSInteger y=center.y+200;
        backView.center = CGPointMake(x, y);
        view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
        view0.alpha = 0;
    }];
    }else{
    [self.view endEditing:YES];
    }
}
-(void)tag:(UIButton *)button{
    NSString *title = button.titleLabel.text;
    NSString *str = textView2.text;
    textView2.text = [str stringByAppendingFormat:@"%@ ",title];
  
}
-(void)finish{
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = backView.center;
        NSInteger x = center.x;
        NSInteger y=center.y+200;
        backView.center = CGPointMake(x, y);
        view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
        view0.alpha = 0;
    }];
    numLabel.text = num;
}
-(void)chooseNum{
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = backView.center;
        NSInteger x = center.x;
        NSInteger y=center.y-200;
        backView.center = CGPointMake(x, y);
        view.frame = CGRectMake(0, SCREENH-200, SCREENW, 200);
        view0.alpha = 0.3;
    }];
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
    navView.userInteractionEnabled = YES;
    //创建标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREENW-40, 30)];
    titleLable.text = @"约伴及费用";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREENW-60, 30, 50, 30);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nextButton];
    
    
    //选择器
    view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH-200, SCREENW, 200)];
    //view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    //
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [view addSubview:line];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(SCREENW-60, 5, 50, 30);
    [button2 setBackgroundColor: [UIColor blueColor]];
    button2.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:1];
    UILabel *labelt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelt.text = @"确定";
    labelt.textColor = [UIColor whiteColor];
    labelt.textAlignment = NSTextAlignmentCenter;
    labelt.font = [UIFont systemFontOfSize:14];
    [button2 addSubview:labelt];
    [button2 addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UILabel *chooseLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 121, SCREENW, 30)];
    chooseLable.backgroundColor = [UIColor redColor];
    chooseLable.alpha = 0.2;
    [view addSubview:chooseLable];
    //加选项
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREENW/3, 60, SCREENW/3, 140)];
       
        scrollView.contentOffset = CGPointMake(0, 60);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate =self;
        scrollView.contentSize = CGSizeMake(SCREENW/3, 30*25);
            for(int i=0;i<24;i++){
                UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW/3-60)/2, i*30, 60, 30)];
                if(i<2){
                    monthLabel.text = @"";
                }else if(i>=2 &&i<22){
                    monthLabel.text = [NSString stringWithFormat:@"%d",i-1];
                }else if(i==22){
                    monthLabel.text=@"无限" ;
                }else{
                    monthLabel.text = @"";
                }
                monthLabel.textColor = [UIColor blackColor];
                monthLabel.alpha = 0.5;
                monthLabel.textAlignment = NSTextAlignmentCenter;
                monthLabel.font = [UIFont systemFontOfSize:12];
                [scrollView addSubview:monthLabel];
                
              [view addSubview:scrollView];
    }
    view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
    
}
-(void)nextPage{
    self.model.number = numLabel.text;
    self.model.require = textView2.text;
    for(int i=200;i<204;i++){
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        if(button.selected == YES){
            self.model.money_type = button.titleLabel.text;
        }else{
            continue;
        }
    }
    PicChooseViewController *picVC = [[PicChooseViewController alloc]init];
    picVC.model = self.model;
    [self.navigationController pushViewController:picVC animated:YES];
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
