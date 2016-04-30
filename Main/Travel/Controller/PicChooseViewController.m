//
//  PicChooseViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//
#import "EndViewController.h"
#import "PicChooseViewController.h"
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface PicChooseViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIView *chooseView;
    NSInteger num;
    NSInteger k;
    UIButton *imageButton;
    UIImageView *view;
    UIImagePickerController *_picker;
    NSInteger tag;
    NSString *f;
    BOOL _delete;

}
@end

@implementation PicChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picker = [[UIImagePickerController alloc]init];
    // 是否允许编辑 剪裁（默认是YES）
    _picker.allowsEditing = NO;
    _picker.delegate =self;//两个代理
    num = 2;
    _delete = NO;
    self.picArray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    for(int i=0;i<2;i++){
        UIImage *image = [UIImage imageNamed:@"icon_publish_together_photo.png"];
//        NSString *str = @"icon_publish_together_photo.png";
        [self.picArray addObject:image];
    }
    NSLog(@"%@",self.picArray[0]);
    [self creatData];
    [self creatNav];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatData{
    for(int i=0;i<num;i++){
        [_dataArray addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    [_tableView reloadData];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 100)];
    NSArray *array = @[@"icon_add_schedule.png",@"icon_delete_schedule.png"];
    for(int i=0;i<2;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREENW/2, 0, SCREENW/2, 100);
        UIImageView *editView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW/2-60)/2, 20, 60, 60)];
        editView.userInteractionEnabled = NO;
        editView.image = [UIImage imageNamed:array[i]];
        [button addSubview:editView];
        button.tag = 200+i;
        [button addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button];
        view2.userInteractionEnabled = YES;
    }
    _tableView.tableFooterView = view2;
}
//编辑
-(void)edit:(UIButton *)button{
       if(button.tag == 200){
           NSInteger s = _dataArray.count;
           
           NSString *string = [NSString stringWithFormat:@"%d",s+1];
           //        //先处理数据源
           [_dataArray addObject:string];
           UIImage *image = [UIImage imageNamed:@"icon_publish_together_photo.png"];
           [_picArray addObject:image];
           [_tableView reloadData];
       }else{
           _delete = !_delete;
           if(_delete){
           for(int i=0;i<_dataArray.count;i++){
               UIButton *button = (UIButton *)[self.view viewWithTag:400+i];
               button.alpha = 1;
           }
           }else{
               for(int i=0;i<_dataArray.count;i++){
                   UIButton *button = (UIButton *)[self.view viewWithTag:400+i];
                   button.alpha = 0;
               }
 
           }
    }
}
-(void)delete:(UIButton *)button{
    
    [_dataArray removeObjectAtIndex:button.tag-400];
    for(int i=button.tag-400;i<_dataArray.count;i++){
        NSInteger s = [_dataArray[i] integerValue]-1;
        NSString *str = [NSString stringWithFormat:@"%d",s];
        _dataArray[i] = str;
    }
    [_picArray removeObjectAtIndex:button.tag-400];

    [_tableView reloadData];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *_model2 = _dataArray[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    f=_model2;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 30)];
    dayLabel.textColor = [UIColor blackColor];
    dayLabel.text = [NSString stringWithFormat:@"Day %@",_model2];
    dayLabel.alpha = 0.6;
    dayLabel.font = [UIFont systemFontOfSize:17];
    [cell.contentView addSubview:dayLabel];
    
     UIButton*deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(SCREENW-30, 15, 20, 20);
    [deleteButton setImage:[UIImage imageNamed:@"icon_schedult_delete.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    if(_delete == NO){
    deleteButton.alpha = 0;
    }else{
        deleteButton.alpha = 1;
    }
    deleteButton.tag = 400+indexPath.row;
    [cell.contentView addSubview:deleteButton];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREENW-10, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.4;
    [cell.contentView addSubview:line];
    
    imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(10, 80, 150, 100);
    [imageButton addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    imageButton.tag = 600+indexPath.row;
    
    UIImage *image = self.picArray[indexPath.row];
    [imageButton setImage:image forState:UIControlStateNormal];
    [cell.contentView addSubview:imageButton];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 200, SCREENW-20, 100)];
    textView.font = [UIFont systemFontOfSize:12];
    textView.tag = 700+indexPath.row;
    //设置字体颜色
    textView.textColor = [UIColor orangeColor];
    //设置光标从头开始显示 默认为YES
    textView.alpha = 0.8;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //因为没有placeholder属性 所以先设置文本
    textView.text = [NSString stringWithFormat:@"添加第%@天行程",_model];
    //使用代理方法 来清除textView.text
    textView.delegate = self;
    [cell.contentView addSubview:textView];
    
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(0, 305, SCREENW, 5)];
    la.backgroundColor = [UIColor grayColor];
    la.alpha = 0.5;
    [cell.contentView addSubview:la];    
    return cell;
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
        textView.text = [NSString stringWithFormat:@"添加第%@天行程",f];
        
    }
    NSLog(@"textViewDidEndEditing");
}
//在这个touch方法里 收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    titleLable.text = @"行程";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.alpha = 0.5;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLable];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREENW-60, 30, 50, 30);
    [nextButton setTitle:@"跳过" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nextButton];
}
-(void)next{
    EndViewController *endVC = [[EndViewController alloc]init];
    endVC.model = self.model;
    [self.navigationController pushViewController:endVC animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)chooseImage:(UIButton *)button{
    tag = button.tag;
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
        [self.picArray replaceObjectAtIndex:tag-600 withObject:image];
    }
    else
    {
        //从相机照完相 获取的图片的key
        UIImage *image  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:image forState:UIControlStateNormal];
        [_picArray replaceObjectAtIndex:tag-600 withObject:image];

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
