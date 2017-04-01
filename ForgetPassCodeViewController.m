//
//  ForgetPassCodeViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/13.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ForgetPassCodeViewController.h"
#import "IdentifyCodeViewController.h"

@interface ForgetPassCodeViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTextFiled;

@end

@implementation ForgetPassCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)NextIdenfiyCodeViewController:(id)sender {
    
    if([self.phoneTextFiled.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"电话不能为空"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });

        return;
    }
    if(!MATCH_PHONE(self.phoneTextFiled.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });

        return;
    }
    
    NSDictionary *dict=@{
                         @"account":self.phoneTextFiled.text
                         };

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appTestAccount parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
        if ([dict[@"flag"] isEqual:@0]) {
            
            IdentifyCodeViewController *identify=[[IdentifyCodeViewController alloc] init];
            
            identify.phoneStr=self.phoneTextFiled.text;
            [self presentViewController:identify animated:YES completion:nil];
        }else {
            [SVProgressHUD showErrorWithStatus:@"账号不存在"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
            });
             return;

            
        }
        
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];

    
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
