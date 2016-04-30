//
//  EndViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "EndViewController.h"
#import "AFNetworking.h"
#define url @"http://api.miaotu.com/v1.1/yueyou/"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface EndViewController ()
{
    UIImagePickerController *_picker;
    NSInteger tag;
    NSMutableArray *picArray;
    UITextView *textView2;
}
@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
    picArray = [[NSMutableArray alloc]init];
    tag = 99;
    [self creatUI];
    [self creatButton];
    // Do any additional setup after loading the view.
}
-(void)creatUI{
    textView2 = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, SCREENW-20, 150)];
    textView2.font = [UIFont systemFontOfSize:14];
    //设置字体颜色
    textView2.layer.borderWidth = 1;
    textView2.layer.borderColor = [[UIColor grayColor]CGColor];
    textView2.textColor = [UIColor blackColor];
    textView2.alpha = 0.5;
    //设置光标从头开始显示 默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    //因为没有placeholder属性 所以先设置文本
    textView2.text = [NSString stringWithFormat:@"#想去%@，求约伴%@人#把这一刻的想法跟妙友说...",self.model.destination,self.model.number];
    //使用代理方法 来清除textView.text
    textView2.delegate = self;
    [self.view addSubview:textView2];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 234, SCREENW, 7)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.3;
    [self.view addSubview:label];
    
    UIButton *placeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    placeButton.frame = CGRectMake(0, 241, SCREENW, 30);
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 15, 20)];
    view.image = [UIImage imageNamed:@"icon_together_publish_location.png"];
    [placeButton addSubview:view];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 150, 20)];
    label2.text = @"北京市";
    label2.textColor = [UIColor blackColor];
    label2.alpha = 0.6;
    label2.font = [UIFont systemFontOfSize:14];
    [placeButton addSubview:label2];
    UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENW-20, 10, 10, 10)];
    view2.image = [UIImage imageNamed:@"icon_together_publish_location_select.png"];
    [placeButton addSubview:view2];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, SCREENW-10, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [placeButton addSubview:line];
    [self.view addSubview:placeButton];
    
    _picker = [[UIImagePickerController alloc]init];
    // 是否允许编辑 剪裁（默认是YES）
    _picker.allowsEditing = NO;
    _picker.delegate =self;//两个代理

}
-(void)creatButton{
    tag++;
    if(tag == 106){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多可选六张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(tag>102){
     button.frame = CGRectMake(10+(tag-103)*120, 440, 100, 120);
    }else{
    button.frame = CGRectMake(10+(tag-100)*120, 300, 100, 120);
    }
        UIImage *image = [UIImage imageNamed:@"icon_pic_add.png"];
        [picArray addObject:image];
    [button setBackgroundImage:image forState:UIControlStateNormal];
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(80, 0, 20, 20);
        [deleteButton setImage:[UIImage imageNamed:@"icon_pic_del.png"] forState:UIControlStateNormal];
        deleteButton.alpha = 0;
        deleteButton.tag = 200+tag;
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:deleteButton];
    button.tag = tag;
    [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    }
}
-(void)delete:(UIButton *)button{
    for(int i=100;i<tag+1;i++){
        UIButton *button1 = (UIButton *)[self.view viewWithTag:i];
        [button1 removeFromSuperview];
    }
    [picArray removeObjectAtIndex:button.tag-300];
    NSInteger s=tag;
    tag = 99;
    for(int i=100;i<s;i++){
    tag++;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if(tag>102){
            button.frame = CGRectMake(10+(tag-103)*120, 440, 100, 120);
        }else{
            button.frame = CGRectMake(10+(tag-100)*120, 300, 100, 120);
        }
        [button setBackgroundImage:picArray[i-100] forState:UIControlStateNormal];
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(80, 0, 20, 20);
        [deleteButton setImage:[UIImage imageNamed:@"icon_pic_del.png"] forState:UIControlStateNormal];
        if(i==s-1){
            deleteButton.alpha = 0;
        }else{
        deleteButton.alpha = 0.5;
        }
        deleteButton.tag = 200+tag;
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:deleteButton];
        button.tag = tag;
        [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)choose:(UIButton *)button{
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
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:image forState:UIControlStateNormal];
        UIButton *view = (UIButton *)[self.view viewWithTag:tag+200];
        view.alpha = 0.5;
        [picArray replaceObjectAtIndex:tag-100 withObject:image];
        [self creatButton];
           }
    else
    {
        //从相机照完相 获取的图片的key
        UIImage *image  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:image forState:UIControlStateNormal];
        UIButton *view = (UIButton *)[self.view viewWithTag:tag+200];
        view.alpha = 0.5;
        [picArray replaceObjectAtIndex:tag-100 withObject:image];
        [self creatButton];
        
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
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.textColor = [UIColor orangeColor];
    if (self.string.length == 0) {
        textView.text = @"";
        
    }else{
        
        textView.text = self.string;
    }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    self.string = textView.text;
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    //当结束编辑的时候,记录一次输入框里输入的文本
    if (self.string.length == 0) {
        textView.text = [NSString stringWithFormat:@"#想去%@，求约伴%@人#把这一刻的想法跟妙友说...",self.model.destination,self.model.number];
        
    }
    NSLog(@"textViewDidEndEditing");
}
//在这个touch方法里 收键盘
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
    titleLable.text = @"推荐下";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREENW-60, 30, 50, 30);
    [nextButton setTitle:@"发布" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nextButton];
}
-(void)next{
    self.model.remark = textView2.text;
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:self.model.destination,self.model.money_type,self.model.from,self.model.from_mark,self.model.remark,self.model.require, nil];
    NSMutableArray *rearray = [[NSMutableArray alloc]init];
    for(int i=0;i<6;i++){
        NSString *encode = [NSString stringWithString:[array[i] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [rearray addObject:encode];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发布成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:rearray[0],@"destination",@"",@"detail",self.model.enddate,@"end_date",self.model.endTime,@"end_time",rearray[1],@"money_type",@"",@"img",@"40.113621",@"latitude",@"116.251748",@"longitude",self.model.number,@"number",rearray[2],@"from",rearray[3],@"from_mark",rearray[4],@"remark",rearray[5],@"require",self.model.startDate,@"start_date",@"98aa550d-6758-11e5-bb24-00163e002e59",@"token",nil];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
