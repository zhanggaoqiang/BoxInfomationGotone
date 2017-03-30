//
//  PhoneModifyViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "PhoneModifyViewController.h"

@interface PhoneModifyViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation PhoneModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneText.text=self.phoneStr;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
   
   
    
    [self.navigationController  popViewControllerAnimated:YES];
    
    
}
- (IBAction)savePhone:(id)sender {
    
    if([self.phoneText.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"电话不能为空"];
        return;
    }
    if(!MATCH_PHONE(self.phoneText.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if ([self.phoneText.text isEqualToString:self.phoneStr]) {
        [SVProgressHUD showErrorWithStatus:@"亲，手机号没改变"];
        return;
    }

    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST: appEditMyPhoneNum parameters:@{@"account":@"18538556305",@"phoneNum":self.phoneText.text} progress:^(NSProgress * _Nonnull uploadProgress) {
//        //进度检测
//
        [uploadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showWithStatus:@"修改成功" ];
         self.myBlock(self.phoneText.text);
        [self.navigationController popViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
        });

        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"昵称修改%@",dict);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"连接失败");
    }];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"fractionCompleted"]&&[object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress1 =(NSProgress *)object;
        
        __block typeof(progress1) progress = progress1;
                dispatch_sync(dispatch_get_main_queue(), ^() {
                    double flt_Count=(float)progress.completedUnitCount/(float)(progress.totalUnitCount);
                  [SVProgressHUD showProgress:flt_Count status:kStrTips_Request_On_0];
        
                    
                });
        
    }
    
}
//张高强
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
