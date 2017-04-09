//
//  SettingViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/5.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "LoginViewController.h"
#import "AuthentViewController.h"
#import "personCellTableViewCell.h"
#import "PersonCell.h"
#import "PersonInfoViewController.h"
#import "MyCarViewController.h"
#import "PresentTransitionAnimated.h"
#import "MyOrderViewController.h"


#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tab_list;
@property (strong,nonatomic)NSArray *dataArr;
@property(strong,nonatomic)NSArray *dataArrImg;

@property (strong, nonatomic) IBOutlet UILabel *personInfo;
@property (strong, nonatomic) IBOutlet UIButton *cerBtn;
//NSString *str=BACKINFO_DIC_2_OBJECT(dict, @"imgAddress");
//NSString *email=BACKINFO_DIC_2_OBJECT(dict, @"email");
//NSString *name=BACKINFO_DIC_2_OBJECT(dict, @"name");
//NSString *phoneNum=BACKINFO_DIC_2_OBJECT(dict, @"phoneNum");



@property(nonatomic,strong)NSString *imageStr;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *gender;

@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self firstPageRequest];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //                    jo.put("ecoStatus", ecoStatus);企业货主认证状态
    //                    jo.put("clcStatus", clcStatus);集装箱租赁公司认证状态
    //                    jo.put("tkStatus", tkStatus);个人车主认证状态
    //                    jo.put("coStatus", coStatus);个人货主认证状态
    
    [_cerBtn setTitle:@"已认证:" forState:UIControlStateNormal];
    
    if (SingleDefaluts.obj_User.clcStatus) {
       

        [_cerBtn.titleLabel.text stringByAppendingString:@"集装箱公司,"];
         NSLog(@"已经认证了:%@",self.cerBtn.titleLabel.text);
        
    }
    if (SingleDefaluts.obj_User.ecoStatus ) {
        [_cerBtn.titleLabel.text stringByAppendingString:@"企业货主,"];
    }
    if (SingleDefaluts.obj_User.tkStatus) {
        [_cerBtn.titleLabel.text stringByAppendingString:@"个人车主,"];
    }
    if (SingleDefaluts.obj_User.coStatus ) {
        [_cerBtn.titleLabel.text stringByAppendingString:@"个人货主"];
        
    }else {
        [_cerBtn setTitle:@"未认证" forState:UIControlStateNormal];
    }
    
    
    NSLog(@"已经认证了:%@",self.cerBtn.titleLabel.text);
    
  //  _cerBtn setTitle:@"已经认证" forState:<#(UIControlState)#>
    
    
    _dataArr=[[NSArray alloc] initWithObjects:@[@"站位"],@[@"我的订单"],@[@"我的钱包"],@[@"消息中心"],@[@"会员中心"] ,@[@"认证中心",@"我的车辆",@"投诉/客服",@"我的收藏",@"注销"],nil];
    _dataArrImg=[[NSArray alloc] initWithObjects:@[@"sd"],@[@"wallet.png"],@[@"wallet.png"],@[@"news.png"],@[@"vip.png"] ,@[@"download.png",@"collect.png",@"collect.png",@"collect.png",@"cancle.png"],nil];
    
    
    self.tab_list.delegate=self;
    self.tab_list.dataSource=self;
    self.tab_list.bounces=NO;
    self.tab_list.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labBtn:)];
    self.personInfo.userInteractionEnabled=YES;
    [self.personInfo addGestureRecognizer:tap];
    [self firstPageRequest];
    

    // Do any additional setup after loading the view.
}





-(void)firstPageRequest {
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appGetMyInfo parameters:@{@"account":@"18538556305"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"个人中心的个人信息是:%@",dict);
        
        
        
   _imageStr =BACKINFO_DIC_2_OBJECT(dict, @"imgAddress");
        _email=BACKINFO_DIC_2_OBJECT(dict, @"email");
        _name=BACKINFO_DIC_2_OBJECT(dict, @"name");
        _phoneNum=BACKINFO_DIC_2_OBJECT(dict, @"phoneNum");
        
        _gender=BACKINFO_DIC_2_OBJECT(dict, @"sex");
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}



-(void)labBtn:(UILabel *)lab {
    NSLog(@"打印信息");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0||section==1||section==2||section==3||section==4) {
        return 1;
    }
    else{
        return 5;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0&&indexPath.row==0) {
        return 80;
    }
   
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
       
    return 10;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==0&&indexPath.row==0) {
     
    PersonCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath] ;
        [cell.cerBtn addTarget:self action:@selector(cerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    
    return cell;
    }
    else {
        
        
        SettingCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath] ;
        
        cell.SettingLabel.text=_dataArr[indexPath.section][indexPath.row];
        cell.SettingImage.image=[UIImage imageNamed:_dataArrImg[indexPath.section][indexPath.row]];
        return cell; 
        
        
        
        
        
    }
    
    
}


-(void)cerBtn:(UIButton *)cerBtn {
    
    [self.navigationController  pushViewController:[MAIN_STORYBOARD  instantiateViewControllerWithIdentifier:@"AuthentViewController"] animated:YES];
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==5&&indexPath.row==4) {
        
        [SVProgressHUD showWithStatus:@"退出登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
            
        });
       
 
    }
    
    if (indexPath.section==5&&indexPath.row==2) {
//        [self presentViewController:[ MAIN_STORYBOARD  instantiateViewControllerWithIdentifier:@"ComplainViewController"] animated:YES completion:nil];
        
        [self.navigationController  pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"ComplainViewController"] animated:YES];
        
        
        
    }
    if(indexPath.section==0&&indexPath.row==0){
        
        PersonInfoViewController *pv=[[PersonInfoViewController alloc] init];
        
        
        NSLog(@"姓名是%@",self.name);
    
        pv.imageStr=self.imageStr;
        pv.name=self.name;
        pv.phone=self.phoneNum;
        pv.email=self.email;
        pv.sex=self.gender;
        
    
        
        pv.block=^(NSString *str,NSString *str2,NSString *str3,NSString *imageStr,NSString *gender) {
            
            self.name=str;
            self.phoneNum=str2;
            self.email=str3;
            self.imageStr=imageStr;
            self.gender=gender;
            
            
            
            NSLog(@"性别是:%@",self.gender);
            
            
        };
        
        
        NSLog(@"字符串地址%@",self.imageStr);
        
//        pv.name=self.name;
//        pv.email=self.email;
//        pv.gender=self.gender;
//        pv.phoneNum=self.phoneNum;
        
        
        
    
        
        
        
        [self.navigationController pushViewController:pv animated:YES];
    }
    
    
    if (indexPath.section==5&&indexPath.row==0) {
//        AuthentViewController *auth=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"AuthentViewController"];
//        auth.transitioningDelegate=self;
//        [self presentViewController:auth animated:YES completion:nil];
        
        [self.navigationController pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"AuthentViewController"] animated:YES];
    }
    
    if (indexPath.section==3&&indexPath.row==0) {
        
        [self.navigationController  pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"InfomationCenterViewController"] animated:YES];
    }
    
    if (indexPath.section==5&&indexPath.row==1) {
        
        MyCarViewController *myCar=[[MyCarViewController alloc] init];
        
        [self.navigationController pushViewController:myCar animated:YES];
    }
    
    if(indexPath.section==1&&indexPath.row==0) {
        MyOrderViewController *order=[[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:order animated:YES];
        
        
    }
    
}


#pragma Mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentTransitionAnimated alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenticationbutton:(id)sender {
   
//    [self  presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"AuthentViewController"] animated:YES completion:nil];
//    
    [self.navigationController  pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"AuthentViewController"] animated:YES];
    
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
