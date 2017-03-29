//
//  AddMyCarViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/20.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "AddMyCarViewController.h"
#import "MyCarViewController.h"

@interface AddMyCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *carScroller;
@property (strong, nonatomic) IBOutlet UITextField *carNum;
@property (strong, nonatomic) IBOutlet UITextField *carKinds;

@property (strong, nonatomic) IBOutlet UITextField *carLoad;
@property (strong, nonatomic) IBOutlet UITextField *carVolume;
@property (strong, nonatomic) IBOutlet UITextField *carLength;




@end

@implementation AddMyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.carNum resignFirstResponder];
    [self.carKinds resignFirstResponder];
    [self.carLoad resignFirstResponder];
    [self.carVolume resignFirstResponder];
    [self.carLength  resignFirstResponder];
    
    
    
}
-(void)uploadRequest {
    
    if ([self.carNum.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"车牌号不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }
    
    if ([self.carLoad.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"车辆载重不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }
    if ([self.carVolume.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"车辆体积不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }

    if ([self.carLength.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"车辆长度不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }
    if ([self.carKinds.text isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:@"车辆类型不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }


    
    
    [SVProgressHUD showInfoWithStatus:@"上传车辆中"];
    
    
    
    NSDictionary *dict=@{@"account":@"18538556305",
                         @"plateNum":self.carNum.text,
                         @"truckType":  self.carKinds.text,
                         @"truckLoad":self.carLoad.text,
                         @"truckLength":self.carLength.text,
                         @"truckVolume":self.carVolume.text
                        };
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appAddMyOwnerCarInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"个人中心的个人信息是:%@",dict);

        
        [SVProgressHUD  showSuccessWithStatus:@"上传成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
           
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}


- (IBAction)confirmAdd:(id)sender {
    
    [self uploadRequest];
}
- (IBAction)backBtn:(id)sender {
    
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
