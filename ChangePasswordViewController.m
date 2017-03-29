//
//  ChangePasswordViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/13.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *passwordText;

@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;

@property(nonatomic,strong)NSString *phoneS;



@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneS=self.phone;
    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)finishChangPassword:(id)sender {
    if ([self.passwordText.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }
    
    if ([self.confirmPassword.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }
    
    if (![self.confirmPassword.text isEqualToString:self.passwordText.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];

    }

    
    NSDictionary *dict=@{
                         @"account":self.phoneS,
                         @"password":self.passwordText.text,
                         @"confirmPWD":self.confirmPassword.text
                         };
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appEditMyPassword parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
        if ([dict[@"flag"] isEqual:@0]) {
              [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            [self.navigationController pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"LoginViewController"]animated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
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
