//
//  RegistViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/4.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>





#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]


@interface RegistViewController ()
@property (strong, nonatomic) IBOutlet UITextField *telephone;

@property (strong, nonatomic) IBOutlet UIButton *code;

@property (strong, nonatomic) IBOutlet UITextField *passcode;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgain;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.telephone resignFirstResponder];
    [self.password resignFirstResponder];
    [self.passwordAgain resignFirstResponder];
    [self.passcode resignFirstResponder];
    
}


- (IBAction)popBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registBtn:(id)sender {
    
    if([self.telephone.text isEqualToString:@""]) {
        [_telephone resignFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }

    if(!MATCH_PHONE(self.telephone.text)&&self.telephone.text!=NULL) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对"];
        [_telephone resignFirstResponder];
        return;
    }
    
    if([self.passcode.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        [_telephone resignFirstResponder];
        return;
    }
    if([self.passwordAgain .text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        [_telephone resignFirstResponder];
        return;
    }

    
    NSDictionary *dict=@{
                         @"account":self.telephone.text,
                         @"passCode":self.passcode.text,
                         @"password":self.password.text
                         };
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:registUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        NSLog(@"返回的信息%@",dict);
        
        
        if ([dict[@"flag"] isEqual:@(1)]) {
            [SVProgressHUD showWithStatus:@"验证码错误"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return ;
            });
        }
        else {
        
            [SVProgressHUD showWithStatus:@"验证码错误"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return ;
            });

        
        
        [self.navigationController presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:YES completion:nil];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    
}

- (IBAction)codeBtn:(UIButton *)sender {
    
    
   
    
    if([self.telephone.text isEqualToString:@""]) {
        [_telephone becomeFirstResponder];
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    
    if(!MATCH_PHONE(self.telephone.text)&&self.telephone.text!=NULL) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对"];
        [_telephone becomeFirstResponder];
        return;
    }
    
    
    
    
    

    NSDictionary *dict=@{
                         @"account":self.telephone.text
                                                };
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:verifyCode parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
  
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"注册信息我的%@",dict);
        if ([dict[@"flag"] isEqual:@(1)]) {
            
            [SVProgressHUD showWithStatus:@"手机号已存在,请直接登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
            });
            return;
             
        }else {
            
            //设置倒计时时间
            //通过检验发现，方法调用后，timeout会先自动-1，所以如果从15秒开始倒计时timeout应该写16
            //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
            __block int timeout = 61;
            __block UIButton *verfybutton=_code;
            verfybutton.enabled=NO;
            
            //获取全局队列
            dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
            
            // 设置触发的间隔时间
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
            //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
            
            //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
            __weak typeof(self)weakSelf = self;
            //设置定时器的触发事件
            dispatch_source_set_event_handler(timer, ^{
                
                //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
                
                //1. 每调用一次 时间-1s
                timeout --;
                
                //2.对timeout进行判断时间是停止倒计时，还是修改button的title
                if (timeout <= 0) {
                    
                    //停止倒计时，button打开交互，背景颜色还原，title还原
                    
                    //关闭定时器
                    dispatch_source_cancel(timer);
                    
                    //MRC下需要释放，这里不需要
                    // dispatch_realse(timer);
                    
                    //button上的相关设置
                    //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
                    //在主线程中对button进行修改操作
                    dispatch_async(dispatch_get_main_queue(), ^{
                        verfybutton.userInteractionEnabled = YES;//开启交互性
                        // weakSelf.identifyBtnText.backgroundColor = [UIColor yellowColor];
                        [verfybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    });
                }else {
                    
                    //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * title = [NSString stringWithFormat:@"%d秒后重新获取验证码",timeout];
                        [verfybutton setTitle:title forState:UIControlStateNormal];
                        verfybutton.userInteractionEnabled = NO;//关闭交互性
                    });
                }
            });
            
            dispatch_resume(timer);

            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    
}
    
    
    
//    
//    NSDictionary *dic=@{@"name":self.username.text,
//                        @"pwd":self.password.text,
//                        @"email":self.passwordAgain.text
//                        
//                        };
//    
////    NSString *url=[registerUrl  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    NSString *url= [registerUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    
//    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//      
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"连接成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"连接失败");
//    }];


//}


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
