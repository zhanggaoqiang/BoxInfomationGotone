//
//  ComplainViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/13.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ComplainViewController.h"

@interface ComplainViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *phoneNum;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UILabel *reson;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UITextView *textReson;
@property (strong, nonatomic) IBOutlet UITextView *detailtextView;



@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.account.delegate=self;
    self.phoneNum.delegate=self;
    self.name.delegate=self;
    self.detailtextView.delegate=self;
    self.textReson.delegate=self;
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    
    [self.account resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self.name resignFirstResponder];
    [self.textReson resignFirstResponder];
    [self.detail resignFirstResponder];
    
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.account resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self.name resignFirstResponder];
    [self.textReson resignFirstResponder];
    [self.detail resignFirstResponder];
    
    return YES;
}
- (IBAction)confirmComplaint:(id)sender {
    
    NSDictionary *dict=@{
                         @"cpAccount":self.account.text,
                         @"cpPhoneNum":self.phoneNum.text,
                         @"cpName":self.name.text,
                         @"cpReason":self.textReson.text,
                         @"cpDetails":self.detailtextView.text
                         
                         };
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST: appComplaintInfo parameters:dict  progress:^(NSProgress * _Nonnull uploadProgress) {
        //        //进度检测
        //
        [uploadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
  
        
        [SVProgressHUD showWithStatus:@"，已经收到你的投诉，我们会尽快处理" ];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
             [self.navigationController popViewControllerAnimated:YES];
        });
        
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
 

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)complainBtn:(id)sender {
    
  //  [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
