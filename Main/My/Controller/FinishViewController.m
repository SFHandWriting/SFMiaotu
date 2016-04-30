//
//  FinishViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
#import "FinishViewController.h"
#import "UITextField_TL.h"
#import "AFNetworking.h"
#define url @"http://api.miaotu.com/v1.1/user"
@interface FinishViewController ()
{
    UIImagePickerController *_picker;
    UIButton *headButton;
}
@end

@implementation FinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNav];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    _picker = [[UIImagePickerController alloc]init];
    // 是否允许编辑 剪裁（默认是YES）
    _picker.allowsEditing = NO;
    _picker.delegate =self;//两个代理
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
    view.backgroundColor =  [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:view];
    UIScrollView *circleView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 5, SCREENW-20, SCREENH-76)];
    circleView.showsVerticalScrollIndicator = NO;
    circleView.contentSize = CGSizeMake(SCREENW-20, SCREENH-76+450);
    circleView.contentOffset = CGPointZero;
    
    //因为要计算偏移量，从而计算出pagecontrol的当前页码，所以要写代理
  
    circleView.backgroundColor =  [[UIColor orangeColor] colorWithAlphaComponent:0.1];    circleView.layer.cornerRadius = 5;
    circleView.layer.masksToBounds  = YES;
    [view addSubview:circleView];
    
    UIImageView *blue = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    blue.image = [UIImage imageNamed:@"icon_join_detail.png"];
    [circleView addSubview:blue];
    
    //头像
    headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = CGRectMake((SCREENW-60)/2, 15, 40, 40);
    headButton .layer.cornerRadius = 20;
    headButton.layer.masksToBounds = YES;
    [headButton addTarget:self action:@selector(head) forControlEvents:UIControlEventTouchUpInside];
    [headButton setImage:[UIImage imageNamed:@"icon_default_head_photo.png"] forState:UIControlStateNormal];
    [circleView addSubview:headButton];
    //
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREENW-120)/2, 60, 100, 40)];
    addLabel.text = @"添加头像";
    addLabel.font = [UIFont systemFontOfSize:12];
    addLabel.textColor = [UIColor blackColor];
    addLabel.textAlignment = NSTextAlignmentCenter;
    [circleView addSubview:addLabel];
    NSArray *array1 = @[@"昵称",@"性别",@"年龄",@"情感状态",@"想去",@"家乡",@"职业",@"学校",@"生活在",@"工作在",@"有闲",@"约游预算",@"邮箱",@"自我评价",@"学历",@"爱好",@"国籍",@"省份"];
    NSArray *array2 = @[@"请输入您的昵称",@"请选择您的性别",@"20",@"请输入您的感情状态",@"请输入您想去的地方",@"如北京",@"如程序员",@"如清华大学",@"如青岛",@"如北京中关村",@"2015-10-20",@"2k-4k",@"请输入您的邮箱",@"如屌丝",@"如本科",@"如打篮球",@"如中国",@"如北京"];
    for(int i=0;i<18;i++){
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 100+i*40, 60, 25)];
        label1.text = array1[i];
        label1.textColor = [UIColor blackColor];
        label1.alpha = 0.6;
        label1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textAlignment = NSTextAlignmentCenter;
        [circleView addSubview:label1];
        UILabel *li =[[UILabel alloc]initWithFrame:CGRectMake(55.5, 2, 0.5, 21)];
        li.backgroundColor = [UIColor grayColor];
        li.alpha = 0.6;
        [label1 addSubview:li];
        
        UITextField *textField = [UITextField_TL creatTextFieldWithFrame:CGRectMake(100, 100+i*40, SCREENW-150, 25) borderStyle:UITextBorderStyleNone tag:100+i placeholder:array2[i] clearButtonMode:UITextFieldViewModeAlways secureTextEntry:NO font:12 boldFont:NO];
        [circleView addSubview:textField];
    }
}
-(void)head{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从手机相册选择" otherButtonTitles:@"拍照",nil];
    //让sheet 显示出来
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){                               //从相册选择照片
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.sourceType = sourceType;
        [self presentViewController:_picker animated: YES completion:^{
            
        }];
    }else if (buttonIndex==1){                       //从相机选择照片
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备不支持相机功能!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
            _picker.sourceType = sourceType;
            [self presentModalViewController:_picker animated:YES];//进入照相界面
            //      [_picker release];
        }
        
    }else{                                            //取消选择
        [_picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

//在相册里 选择某一张图片调用的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        //从相册获取的图片key
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [headButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
        //从相机照完相 获取的图片的key
        UIImage *image  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [headButton setImage:image forState:UIControlStateNormal];
        
    }
    
    // 选择完照片后，把照片选择器dismiss掉
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//取消的代理

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
    titleLable.text = @"编辑个人资料";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREENW-60, 30, 50, 30);
    [nextButton setTitle:@"保存" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nextButton];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)next{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray *messagearray= [[NSMutableArray alloc]init];
    for(int i=0;i<12;i++){
        UITextField *textField = (UITextField *)[self.view viewWithTag:100+i];
        NSString *str = textField.text;
        [messagearray addObject:str];
        NSString *encode = [NSString stringWithString:[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [array addObject:encode];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",array[0],@"nickname",array[2],@"age",array[1],@"gender",array[16],@"country",array[17],@"province",@"",@"city",array[12],@"email",@"",@"head_url",array[13],@"about_me",@"",@"high",array[14],@"education",array[3],@"marital_status",@"",@"address",array[7],@"graduate_school",array[6], @"work",@"",@"tags",@"",@"body_type",array[4],@"want_go",@"",@"been_go",array[15],@"hobbies",@"",@"music",@"",@"film",@"",@"book",@"",@"food",@"",@"pic_url",array[11],@"budget",array[5],@"home",array[8],@"life_area",array[9],@"work_area",array[10],@"free_time",nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view endEditing:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜，个人信息保存成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ok" object:messagearray];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
