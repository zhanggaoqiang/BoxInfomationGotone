//
//  NameModifyViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "NameModifyViewController.h"

@interface NameModifyViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextFiled;

@end

@implementation NameModifyViewController



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.nameTextFiled.text=self.name;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
   }
- (IBAction)saveUpload:(id)sender {
    if([self.nameTextFiled.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        return;
    }
    if ([self.nameTextFiled.text isEqualToString:self.name]) {
        [SVProgressHUD showErrorWithStatus:@"姓名并没有做出任何改变"];
        return;
    }
   
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST: appEditMyNikeName parameters:@{@"account":@"18538556305",@"name":self.nameTextFiled.text} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        //进度检测
        __block typeof(uploadProgress) progress = uploadProgress;
        dispatch_sync(dispatch_get_main_queue(), ^(){
            // 这里的代码会在主线程执行
            double flt_Count = (float)progress.completedUnitCount/(float)(progress.totalUnitCount);
            [SVProgressHUD showProgress:flt_Count status:kStrTips_Request_On_0];
        });

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"昵称修改%@",dict);
        
            [SVProgressHUD showProgress:0 status:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        self.block(self.nameTextFiled.text);
        
        
        
        

            [self.navigationController popViewControllerAnimated:YES];
        
        
        
        
        
        
        
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
