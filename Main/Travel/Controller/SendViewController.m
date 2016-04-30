//
//  SendViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SendViewController.h"
#import "UITextField_TL.h"
#import "FirstModel.h"
#import "RequestViewController.h"
@interface SendViewController ()
{
    UIView *fatherView;
    NSString *year;
    NSString *month;
    NSString *day;
    UIView *view;
    FirstModel *model;
}
@end
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@implementation SendViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    year = @"2015";
    month = @"03";
    day = @"03";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatFatherView];
    model = [[FirstModel alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self creatNav];
}
-(void)creatFatherView{
    fatherView.alpha = 0.3;
    fatherView.backgroundColor = [UIColor grayColor];
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    label.text = @"确定";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [button2 addSubview:label];
    [button2 addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UILabel *chooseLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 121, SCREENW, 30)];
    chooseLable.backgroundColor = [UIColor orangeColor];
    chooseLable.alpha = 0.5;
    [view addSubview:chooseLable];
    //加选项
    for(int i=0;i<3;i++){
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(i*SCREENW/3, 60, SCREENW/3, 140)];
        scrollView.tag = 10+i;
        if(i==0){
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            scrollView.contentOffset = CGPointMake(0, 60);
        }
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate =self;
        if(i==0){
            for(int i=0;i<13;i++){
                UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW/3-60)/2, i*30, 60, 30)];
                if(i<2){
                    yearLabel.text = @"";
                }else{
                    yearLabel.text = [NSString stringWithFormat:@"%d",i+2013];
                }
                yearLabel.textColor = [UIColor blackColor];
                yearLabel.alpha = 0.5;
                yearLabel.textAlignment = NSTextAlignmentCenter;
                yearLabel.font = [UIFont systemFontOfSize:12];
                [scrollView addSubview:yearLabel];
            }
            scrollView.contentSize = CGSizeMake(SCREENW/3, 30*15);
        }else if (i==1){
            NSArray *array = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
            for(int i=0;i<14;i++){
                UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW/3-60)/2, i*30, 60, 30)];
                if(i<2){
                    monthLabel.text = @"";
                }else{
                    monthLabel.text = array[i-2];
                }
                monthLabel.textColor = [UIColor blackColor];
                monthLabel.alpha = 0.5;
                monthLabel.textAlignment = NSTextAlignmentCenter;
                monthLabel.font = [UIFont systemFontOfSize:12];
                [scrollView addSubview:monthLabel];
                
            }
            scrollView.contentSize = CGSizeMake(SCREENW/3, 30*16);
        }else{
            for(int i=0;i<33;i++){
                UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW/3-60)/2, i*30, 60, 30)];
                if(i<2){
                    dayLabel.text = @"";
                }else{
                    dayLabel.text = [NSString stringWithFormat:@"%d",i-1];
                }
                dayLabel.textColor = [UIColor blackColor];
                dayLabel.alpha = 0.5;
                dayLabel.textAlignment = NSTextAlignmentCenter;
                dayLabel.font = [UIFont systemFontOfSize:12];
                [scrollView addSubview:dayLabel];
            }
            scrollView.contentSize = CGSizeMake(SCREENW/3, 30*35);
        }
        [view addSubview:scrollView];
    }
    view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
    fatherView.alpha = 0.8;
    fatherView.backgroundColor = [UIColor whiteColor];
}
-(void)creatUI{
    fatherView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, SCREENH-220)];
    fatherView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fatherView];
    NSArray *array = @[@"icon_start_city.png",@"icon_des_city.png",@"",@"icon_start_time.png",@"icon_return_time.png",@"icon_deadline.png"];
    for(int i=0;i<6;i++){
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+i*65, SCREENW-20, 50)];
        backView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];        [fatherView addSubview:backView];
        //加图片
        UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        view2.image = [UIImage imageNamed:array[i]];
        [backView addSubview:view2];
        //加textfield
        NSArray *nameArray = @[@"北京市",@"目的地",@"集合地址（选填）",@"出发时间",@"返回时间",@"报名截止时间（选填）"];
        if(i<2){
            UITextField *field = [UITextField_TL creatTextFieldWithFrame:CGRectMake(35, 10, SCREENW-55, 30) borderStyle:UITextBorderStyleRoundedRect tag:100+i placeholder:nameArray[i] clearButtonMode:UITextFieldViewModeAlways secureTextEntry:NO font:14 boldFont:NO];
            field.layer.cornerRadius = 15;
            field.layer.masksToBounds = YES;
            [backView addSubview:field];
        }
        if(i==2){
            UITextField *field = [UITextField_TL creatTextFieldWithFrame:CGRectMake(10, 10, SCREENW-55, 30) borderStyle:UITextBorderStyleRoundedRect tag:100+i placeholder:nameArray[i] clearButtonMode:UITextFieldViewModeAlways secureTextEntry:NO font:14 boldFont:NO];
            field.layer.cornerRadius = 15;
            field.layer.masksToBounds = YES;
            [backView addSubview:field];
        }if(i>2){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 200+i;
            button.frame = CGRectMake(45, 0, SCREENW-60, 50);
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 180, 30)];
            label.text = nameArray[i];
            label.textColor = [UIColor whiteColor];
            label.alpha = 0.9;
            label.font = [UIFont boldSystemFontOfSize:14];
            [button addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-50, 15, 20, 20)];
            imageView.image = [UIImage imageNamed:@"icon_system_msg_right.png"];
            [backView addSubview:imageView];
            
            UILabel *datalabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENW-130, 10, SCREENW-120, 30)];
            datalabel.text = @"请选择";
            datalabel.tag = 900+i;
            datalabel.textColor = [UIColor whiteColor];
            datalabel.font = [UIFont boldSystemFontOfSize:12];
            [backView addSubview:datalabel];
        }
    }
}
-(void)click:(UIButton *)button{
    [self.view endEditing:YES];
    self.num = button.tag;
    if(button.tag == 204){
        UILabel *label = (UILabel *)[self.view viewWithTag:self.num+699];
        if([label.text isEqualToString:@"请选择"]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" 提示" message:@"请先选择出发时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                view.frame = CGRectMake(0, SCREENH-200, SCREENW, 200);
                fatherView.alpha = 0.3;
                fatherView.backgroundColor = [UIColor grayColor];
            }];
        }
    }else{
    [UIView animateWithDuration:0.25 animations:^{
        view.frame = CGRectMake(0, SCREENH-200, SCREENW, 200);
        fatherView.alpha = 0.3;
        fatherView.backgroundColor = [UIColor grayColor];
    }];
    }
}
-(void)alert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"返回时间必须大于出发时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
-(void)yes{
    [UIView animateWithDuration:0.25 animations:^{
        view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
        fatherView.alpha = 1;
        fatherView.backgroundColor = [UIColor whiteColor];
    }];
    NSString *dataStr = [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
    UILabel *label = (UILabel *)[self.view viewWithTag:self.num+700];
    label.text = dataStr;
    if(self.num == 203){
        model.startDate = label.text;
    }else if (self.num == 204){
        model.enddate = label.text;
    }else if (self.num == 205){
        model.endTime = label.text;
    }
}
-(void)finish{
    if(self.num == 204){
         UILabel *label = (UILabel *)[self.view viewWithTag:self.num+699];
        NSArray *array = [label.text componentsSeparatedByString:@"."];
        int yearII =  [year integerValue];
        int monthII = [month integerValue];
        int dayII = [day integerValue];
        int yearI = [array[0] integerValue];
        int monthI = [array[1] integerValue];
        int dayI = [array[2] integerValue];
        if(yearI>yearII){
            [self alert];
        }else if(yearI<yearII){
            [self yes];
        }else{
            if(monthI>monthII){
                [self alert];
            }else if (monthI<monthII){
                [self yes];
            }else{
                if(dayI>dayII){
                    [self alert];
                }else{
                    [self yes];
                }
            }
        }
        }else{
            [self yes];
     }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
        NSInteger w = scrollView.contentOffset.y/30;
    NSInteger s = scrollView.contentOffset.y;
    NSInteger q = s%30;
    if(q>15){
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(0, (w+1)*30);
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(0, w*30);
        }];
       
    }
    if(scrollView.tag == 10){
        year = [NSString stringWithFormat:@"%d",(int)(scrollView.contentOffset.y/30+2015)];
       
    }else if (scrollView.tag == 11){
        NSInteger t = scrollView.contentOffset.y/30;
        month = [NSString stringWithFormat:@"%02d",t+1];
    }else if (scrollView.tag == 12){
        day = [NSString stringWithFormat:@"%02d",(int)(scrollView.contentOffset.y/30+1)];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        view.frame = CGRectMake(0, SCREENH, SCREENW, 0);
        fatherView.alpha = 1;
        fatherView.backgroundColor = [UIColor whiteColor];
    }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger w = scrollView.contentOffset.y/30;
    NSInteger s = scrollView.contentOffset.y;
    NSInteger q = s%30;
    if(q>15){
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(0, (w+1)*30);
        }];
       
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(0, w*30);
        }];
       
    }
    if(scrollView.tag == 10){
        
        year = [NSString stringWithFormat:@"%d",(int)(scrollView.contentOffset.y/30+2015)];
        
       
    }else if (scrollView.tag == 11){
        NSInteger t = scrollView.contentOffset.y/30;
        month = [NSString stringWithFormat:@"%02d",t+1];
    }else if (scrollView.tag == 12){
        day = [NSString stringWithFormat:@"%02d",(int)(scrollView.contentOffset.y/30+1)];
    }
}
-(void)creatNav{
    //创建导航栏
    UIView *navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW,44)];
    navView.backgroundColor = [UIColor whiteColor];
    [fatherView addSubview:navView];
    //装饰
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, SCREENW, 1)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.3;
    [navView addSubview:label];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 10, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    //创建标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREENW-40, 30)];
    titleLable.text = @"发起旅行";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREENW-60, 10, 50, 30);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nextButton];
}
-(void)next{
    UITextField *one = (UITextField *)[self.view viewWithTag:100];
    model.from = one.text;
    UITextField *two = (UITextField *)[self.view viewWithTag:101];
    model.destination = two.text;
    UITextField *three = (UITextField *)[self.view viewWithTag:102];
    model.from_mark = three.text;
    RequestViewController *requestVC = [[RequestViewController alloc]init];
    requestVC.model = model;
    [self.navigationController pushViewController:requestVC animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
