//
//  SearchViewController.m
//  妙途
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 Doctor. All rights reserved.
//

#import "SearchViewController.h"
#import "UITextField_TL.h"
#import "QFRequestManger.h"
#import "AFHTTPRequestOperationManager.h"
#import "SearchCell.h"
#import "DoubleModel.h"
#import "ItemsModel.h"
#import "MoreCell.h"
#import "adViewController.h"
#import "SearchCell2.h"
#import "PersonalViewController.h"
#import "TravelDetailViewController.h"
#import "ItemsModel2.h"
#define url2 @"http://api.miaotu.com/v1.1/%@/search"

#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENW [UIScreen mainScreen].bounds.size.width
@interface SearchViewController ()
{
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray;
    NSMutableArray *_array;
    
    UITextField *textField;
    UITableView *_tableView;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self creatNav];
    [self creatBack];
    _dataArray1 = [[NSMutableArray alloc]init];
    _dataArray2 = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    _array = [[NSMutableArray alloc]init];

}


-(void)creatTableView{
    if(self.selectedButton.tag == 100){
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104) style:UITableViewStyleGrouped];
    }else{
      _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.selectedButton.tag == 100){
    return _dataArray.count;
    }else{
        return _array.count-_array.count+1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selectedButton.tag == 100){
    return [_dataArray[section] count];
    }else{
        return _array.count;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(self.selectedButton.tag == 100){
    NSArray *array = @[@"一起去",@"妙旅团"];
    
    return array[section];
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.selectedButton.tag == 100){
    return 30;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectedButton.tag == 100){
    if(indexPath.section == 0){
    SearchCell *cell = [[SearchCell alloc]init];
    NSArray *array = _dataArray[indexPath.section];
    ItemsModel *model = array[indexPath.row];
    cell.row = indexPath.row;
        cell.keywords = encode;
        cell.fatherVC = self;
    cell.model = model;
    return cell;
    }else{
        SearchCell2 *cell = [[SearchCell2 alloc]init];
        NSArray *array = _dataArray[indexPath.section];
        ItemsModel2 *model = array[indexPath.row];
        cell.row = indexPath.row;
        cell.keywords = encode;
        cell.fatherVC = self;
        cell.model = model;
        [cell finishCellWithModel:model];
        return cell;
    }
    }else{
        MoreCell *cell = [[MoreCell alloc]init];
        DoubleModel *model = _array[indexPath.row];
        cell.fatherVC = self;
        cell.state = 1;
        cell.model = model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedButton.tag == 100){
    if(indexPath.section == 0){
        NSArray *array = _dataArray[0];
        ItemsModel *model = array[indexPath.row];
    CGRect rect = [model.Remark boundingRectWithSize:CGSizeMake(SCREENW-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        if(indexPath.row == 2){
            return 55+rect.size.height+30;
        }else{
    return 55+rect.size.height;
        }
    }else{
        if(indexPath.row == 2){
            return 105;
        }else{
        return 75;
        }
    }
    }else{
        return 60;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedButton.tag == 100){
    if(indexPath.section == 0){
        TravelDetailViewController *detailVC = [[TravelDetailViewController alloc]init];
        ItemsModel *model = [_dataArray[indexPath.section] objectAtIndex:indexPath.row];
        detailVC.Yid =  model.Yid;
        detailVC.myModel = model;
        [self presentViewController:detailVC animated:YES completion:^{
            
        }];
    }else{
        adViewController *adVC = [[adViewController alloc]init];
        ItemsModel2 *model = [_dataArray[indexPath.section] objectAtIndex:indexPath.row];
        adVC.Title = model.Title;
        NSString *myUrl = [NSString stringWithFormat:@"http://m.miaotu.com/App32/detail/?aid=%@&token=%@&uid=%@",model.Aid,@"98aa550d-6758-11e5-bb24-00163e002e59",model.Uid];
        adVC.url = myUrl;
        [self presentViewController:adVC animated:YES completion:^{
            
        }];
    }
    }else{
        DoubleModel *model = _array[indexPath.row];
        PersonalViewController *personal = [[PersonalViewController alloc]init];
        personal.uid = model.Uid;
        personal.token = @"98aa550d-6758-11e5-bb24-00163e002e59";
        personal.hidesBottomBarWhenPushed = YES;
        [self presentViewController:personal animated:YES completion:^{
            
        }];
    }
}
-(void)creatData{
    [_dataArray removeAllObjects];
    [_dataArray1 removeAllObjects];
    [_dataArray2 removeAllObjects];
    [_array removeAllObjects];
    encode = [NSString stringWithString:[textField.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *getUrl;
    NSDictionary *dic;
    if(self.selectedButton.tag == 100){
       dic = @{@"token": @"98aa550d-6758-11e5-bb24-00163e002e59",@"keywords": encode,@"latitude": @"40.114437",@"longitude":@"116.251533"};
        getUrl = [NSString stringWithFormat:url2,@"base"];
    }else{
        dic = @{@"token": @"98aa550d-6758-11e5-bb24-00163e002e59",@"keywords": encode,@"page": @"1",@"num":@"10000"};
        getUrl = [NSString stringWithFormat:url2,@"users"];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:getUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(self.selectedButton.tag == 100){
                NSDictionary *Items = [responseObject objectForKey:@"Items"];
            
        id objc2 = [Items objectForKey:@"ActivityList"];
        id objc1 = [Items objectForKey:@"YueyouList" ];
                if([objc1 isKindOfClass:[NSArray class]]){
        for(NSDictionary *dic in objc1){
            ItemsModel *model = [ItemsModel initWithDict:dic];
            [_dataArray1 addObject:model];
        }
        [_dataArray addObject:_dataArray1];
                }
                if([objc2 isKindOfClass:[NSArray class]]){
        for(NSDictionary *dic in objc2){
            ItemsModel2 *model = [ItemsModel2 initWithDict:dic];
            [_dataArray2 addObject:model];
        }
        [_dataArray addObject:_dataArray2];
                }
                if(_dataArray.count>0){
        [self creatTableView];
                }else{
                    [self creatAlert];
                }
            }else{
                id objc = [responseObject objectForKey:@"Items"];
                if([objc isKindOfClass:[NSArray class]]){
                for(NSDictionary *dic in objc){
                    DoubleModel *model = [DoubleModel initWithDict:dic];
                    [_array addObject:model];
                }
                }
                if(_array.count>0){
                [self creatTableView];
                }else{
                    [self creatAlert];
                }
            }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}
-(void)creatAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不存在包含该关键字的内容，请重新输入关键字！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        textField.text = @"";
    }
}
-(void)creatBack{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH-104)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENW-180)/2, 80, 180, 120)];
    imageV.image = [UIImage imageNamed:@"icon_search_init.png"];
    [view addSubview:imageV];
    [self.view addSubview:view];

}
-(void)creatNav{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 10, 20, 24);
    [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, SCREENW, 0.5)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.4;
    [navView addSubview:label];
    [navView addSubview:backButton];
    
    textField = [UITextField_TL creatTextFieldWithFrame:CGRectMake(50, 7, SCREENW-100, 30) borderStyle:UITextBorderStyleRoundedRect tag:10 placeholder:@"键入关键词搜索线路或者键入关键字搜人" clearButtonMode:UITextFieldViewModeAlways secureTextEntry:NO font:14 boldFont:NO];
    textField.textColor = [UIColor blackColor];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [[UIColor grayColor]CGColor];
    textField.layer.cornerRadius = 15;
    textField.layer.masksToBounds = YES;
    textField.keyboardType = UIKeyboardTypeWebSearch;
    [navView addSubview:textField];
    [textField becomeFirstResponder];

    [self.view addSubview:navView];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame =CGRectMake(SCREENW-40, 7, 30, 30);
    [bu setTitle:@"搜索" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    bu.titleLabel.font = [UIFont systemFontOfSize:15];
    [bu addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:bu];
   }
-(void)focus:(UIButton *)button{
    //UI效果
    [self.selectedButton  setBackgroundColor:[UIColor grayColor]];
    UILabel *label = (UILabel *)[self.view viewWithTag:self.selectedButton.tag+100];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.4;
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    button.selected = YES;
    [button setBackgroundColor:[UIColor whiteColor]];
    UILabel *label3 = (UILabel *)[self.view viewWithTag:button.tag+100];
    label3.backgroundColor = [UIColor orangeColor];
    label3.alpha = 0.7;
    [_tableView removeFromSuperview];
    if(button.tag == 100){
        [self creatData];
    }else{
        [self creatData];
    }
}
-(void)search{
        if([textField.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入关键词！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
    //创建button
    NSArray *array = @[@"找线路",@"找人"];
    for(int i=0;i<2;i++){
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*SCREENW/2, 66, SCREENW/2, 38);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*SCREENW/2, 64, SCREENW/2, 2)];
        label.backgroundColor  =[UIColor grayColor];
        label.alpha = 0.4;
        label.tag = 200+i;
        [self.view addSubview:label];
        [button setBackgroundColor:[UIColor grayColor]];
        button.alpha = 0.4;
        if(i==0){
            button.selected = YES;
            [button setBackgroundColor:[UIColor whiteColor]];
            self.selectedButton = button;
            label.backgroundColor = [UIColor orangeColor];
            label.alpha = 0.7;
        }
        [button addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    [self creatData];
        }
//    [self creatTableView];
}
//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
