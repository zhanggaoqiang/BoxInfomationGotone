//
//  LoginViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/3.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "LoginViewController.h"
#import "ZGQSingleClass.h"
#import "RegistViewController.h"
#import "ForgetPassCodeViewController.h"


#define SingleDefaluts   ((ZGQSingleClass *)[ZGQSingleClass  sharedSingleClass])
#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface LoginViewController ()<UITextFieldDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    paddingView.text = @"用户名:";
//    paddingView.font=[UIFont systemFontOfSize:10];
//    paddingView.textColor = [UIColor darkGrayColor];
//    paddingView.backgroundColor = [UIColor clearColor];
//    self.username.leftView = paddingView;
//    self.username.leftViewMode = UITextFieldViewModeAlways;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
}
- (IBAction)backButton:(UIButton *)sender {
 
    
    UIControl *con =(UIControl *)sender;
    if (con.tag==2) {
        [self dismissViewControllerAnimated:YES completion:nil];
        

        
    }
    
    if (con.tag==1) {
        
        if ([self.username.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
            [self.username resignFirstResponder];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return;
                
            });
            
            
            
        }

        
        
        if(!MATCH_PHONE(self.username.text)&&self.username.text!=NULL) {
            
            [SVProgressHUD showErrorWithStatus:@"手机号格式不对"];
            [self.username resignFirstResponder];

            
          
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return;
                
            });
        }

        
        
        if([self.password.text isEqualToString:@""] ){
            [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return;
                
            });

        
        }
    
        [self.username resignFirstResponder];
        [self.password resignFirstResponder];
        
        
        
        NSDictionary *dict=@{
                             @"account":self.username.text,
                             @"password":self.password.text
                             };
        

        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        [manager POST:loginUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dict);
            
            if ([dict[@"flag"]  isEqual:@0]) {
                
                [SVProgressHUD showWithStatus:@"登录中"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    SingleDefaluts.bol_Login=YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
//                    jo.put("ecoStatus", ecoStatus);企业货主认证状态
//                    jo.put("clcStatus", clcStatus);集装箱租赁公司认证状态
//                    jo.put("tkStatus", tkStatus);个人车主认证状态
//                    jo.put("coStatus", coStatus);个人货主认证状态
                    
                    
                    
                    [self dismissViewControllerAnimated:YES completion:nil];

                    
                });
                
            }
            
            if ([dict[@"message"] isEqualToString:@"密码错误"]) {
               [ SVProgressHUD showWithStatus:@"密码错误,请重新输入密码"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    return;
                });
                
            }
            
            
            
            if ([dict[@"message"] isEqualToString:@"账号不存在或者错误"]) {
                [ SVProgressHUD showWithStatus:@"账号不存在或密码错误"];
                [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    return;
                });
                
                
            }
            

            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败");
        }];
    }
 
    
    if (con.tag==3) {
        
        
        
       // [self  presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"RegistViewController"] animated:YES completion:nil];
        
        [self.navigationController pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"RegistViewController"] animated:YES];
//        [self.navigationController pushViewController:[[LViewController alloc] init] animated:YES];
    }
}





//+(void)setTextFiledLeftImage:(UITextField*)textFiled image:(NSString*)image{
//    self.username.leftViewMode=UITextFieldViewModeAlways;
//    self.username.leftView=[[UIImageView alloc]initWithImage:[UIImageimageNamed:@""]];
//}



- (IBAction)forgetCode:(id)sender {
    
    ForgetPassCodeViewController *forget=[[ForgetPassCodeViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
    
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
