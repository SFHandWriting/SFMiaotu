//
//  MyViewController.m
//  妙途
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#import "foButton.h"
#import "Btn.h"
#import "PersonalViewController.h"
#import "FinishViewController.h"
#import "MyViewController.h"
#import "FocusViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface MyViewController ()
{
    UIImageView *view1;//头像
    Btn *age;//年龄
    UILabel *label;//想去
    UILabel *nick;//昵称
    BOOL _man;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:@"ok" object:nil];
    self.title = @"我的";
    _man = NO;
    self.view.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)change:(NSNotification *)noti{
    NSMutableArray *array = noti.object;
    nick.text = array[0];
    label.text = array[4];
    if([array[1] isEqualToString:@"女"]){
        age.backgroundColor = [UIColor redColor];
        [age setImage:[UIImage imageNamed:@"icon_girl.png"] forState:UIControlStateNormal];
    }else{
        age.backgroundColor = [UIColor blueColor];
        [age setImage:[UIImage imageNamed:@"icon_boy.png"] forState:UIControlStateNormal];
    }
    [age setTitle:array[2] forState:UIControlStateNormal];
}
-(void)creatUI{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor =  [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:view];
    //完善资料
    UIView *meView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, 120)];
    meView.backgroundColor =  [[UIColor orangeColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:meView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREENW, 40);
    [button addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    [meView addSubview:button];
    
    //假头像
    view1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    view1.image = [UIImage imageNamed:@"icon_default_head_photo.png"];
    view1.layer.cornerRadius = 25;
    view1.layer.masksToBounds = YES;
    [button addSubview:view1];
    
    //昵称
    nick = [[UILabel alloc]initWithFrame:CGRectMake(78, 15, 100, 30)];
    nick.textColor = [UIColor blackColor];
    nick.font = [UIFont systemFontOfSize:14];
    nick.alpha = 0.6;
    [button addSubview:nick];
    //age
    age = [[Btn alloc]initWithFrame:CGRectMake(43, 52, 30, 10)];
    if(_man==NO){
        age.backgroundColor = [UIColor redColor];
        [age setImage:[UIImage imageNamed:@"icon_girl.png"] forState:UIControlStateNormal];
   }else{
        age.backgroundColor = [UIColor blueColor];
        [age setImage:[UIImage imageNamed:@"icon_boy.png"] forState:UIControlStateNormal];
    }
    age.alpha = 0.3;
    [age setTitle:@"20" forState:UIControlStateNormal];
    age.layer.cornerRadius = 5;
    age.layer.masksToBounds = YES;
    age.titleLabel.font = [UIFont systemFontOfSize:10];
    age.titleLabel.textColor = [UIColor whiteColor];
    age.titleLabel.textAlignment = NSTextAlignmentRight;
    [button addSubview:age];
    
    //want
    label = [[UILabel alloc]initWithFrame:CGRectMake(78, 33, 100, 30)];
    label.text = @"想去";
    label.textColor = [UIColor grayColor];
    label.alpha = 0.7;
    label.font = [UIFont systemFontOfSize:10];
    [button addSubview:label];
    //图
    UIImageView *go = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-25, 32.5, 15, 15)];
    go.image  =[UIImage imageNamed:@"icon_system_msg_right.png"];
    [button addSubview:go];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREENW, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [button addSubview:line];
    
    //3
    NSArray *array = @[@"关注",@"粉丝",@"寻找妙友",@"icon_searchfriend.png"];
    for(int i=0;i<3;i++){
        foButton *focu = [[foButton alloc]initWithFrame:CGRectMake(i*SCREENW/3, 80.5, SCREENW/3, 40)];
        [focu setTitle:array[i] forState:UIControlStateNormal];
        if(i==2){
            [focu setImage:[UIImage imageNamed:array[3]] forState:UIControlStateNormal];
        }else{
            UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW/3, 20)];
            num.text = @"0";
            num.textColor = [UIColor grayColor];
            num.font = [UIFont systemFontOfSize:12];
            num.textAlignment = NSTextAlignmentCenter;
            [focu addSubview:num];
        }
        [focu setTitle:array[i] forState:UIControlStateNormal];
        [focu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        focu.titleLabel.font = [UIFont systemFontOfSize:13];
        focu.titleLabel.textAlignment = NSTextAlignmentCenter;
        focu.tag = 100+i;
        [focu addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        [meView addSubview:focu];
    }
    //
    NSArray *picArray = @[@"个人主页",@"红包",@"设置",@"icon_home.png",@"icon_redbag.png",@"mine_setting.png"];
    for(int i=0;i<3;i++){
    UIButton *my = [UIButton buttonWithType:UIButtonTypeCustom];
    my.frame = CGRectMake(0, 220+i*50, SCREENW, 40);
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    ima.image = [UIImage imageNamed:picArray[i+3]];
    [my addSubview:ima];
        UILabel *na = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 150, 20)];
        na.text = picArray[i];
        na.textColor = [UIColor grayColor];
        na.font = [UIFont systemFontOfSize:14];
        na.alpha = 0.6;
        [my addSubview:na];
        UIImageView *go2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-25, 12.5, 15, 15)];
        go2.image  =[UIImage imageNamed:@"icon_system_msg_right.png"];
        [my addSubview:go2];
        my.backgroundColor =  [[UIColor orangeColor] colorWithAlphaComponent:0.1];
        
        my.tag = 200+i;
        [my addTarget:self action:@selector(come:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:my];
    }
}

-(void)focus:(UIButton *)button{
    if(button.tag == 100){
        FocusViewController *focus = [[FocusViewController alloc]init];
        focus.state = 0;
        focus.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.Uid = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.type = @"like";
        [self presentViewController:focus animated:YES completion:^{
           
        }];
  
    }else if (button.tag == 101){
        FocusViewController *focus = [[FocusViewController alloc]init];
        focus.state = 1;
        focus.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.Uid = @"98aa550d-6758-11e5-bb24-00163e002e59";
        focus.type = @"like";
        [self presentViewController:focus animated:YES completion:^{
            
        }];
    }else{
        
    }
}

-(void)come:(UIButton *)button{
    if(button.tag == 200){
        PersonalViewController *per = [[PersonalViewController alloc]init];
        per.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        per.uid = @"98aa5463-6758-11e5-bb24-00163e002e59";
        [self presentViewController:per animated:YES completion:^{
          
        }];
    }
}

-(void)message{
    FinishViewController *fi = [[FinishViewController alloc]init];
    [self presentViewController:fi animated:YES completion:^{
        
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
