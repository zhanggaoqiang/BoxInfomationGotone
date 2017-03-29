//
//  ConfirmOrderViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/17.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "OrderSuccessViewController.h"

@interface ConfirmOrderViewController ()

@end

@implementation ConfirmOrderViewController


-(void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
   
    
    
    
}

    

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderSuccessPage:) name:@"orderSuccess" object:nil];
    
    
    
    [SVProgressHUD showSuccessWithStatus:@"loading"];
    
    NSDictionary *dict1=@{@"account":@"18538556305",
                          @"csiId":self.index};
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:appCargoSourceOrder parameters:dict1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"这条信息是:%@",dict);
        
    
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    

    
    // Do any additional setup after loading the view from its nib.
}


-(void)orderSuccessPage:(NSNotification *)nf {
    OrderSuccessViewController *order=[[OrderSuccessViewController alloc] init];
    [self presentViewController:order animated:YES completion:nil];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nowPay:(id)sender {
    
    [self doAlipayPay];




}



- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPay
{
    //
    //    NSString *pid = @"2088521159614794";
    //    NSString *appID = @"2017031706260303";
    
    
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017031706260303";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    
    NSString *rsaPrivateKey =@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAM8ujUTzFYqf0Xa3nujwTbHZoFdlKlBcT9kZZAcWEA13tOBP5yzm72wBplQub3Zjw+IYIoOmZVESLNuqzMUJywRHb/7chuD1M8rRDWHoAJsV9lx46rFcwvydGAkIz0d8miSL0OUMjiBqGQ8TgmJhCbP2HzqxLw/aCW4ZvHIKfbCNAgMBAAECgYBSvMh1zI3Bumkv+8xeQfkFGV/LBv+K8BKDJHypx8nJVxDIs6AicmcSvuXpoFGq+dR0Kic+Y+j6I0P+xYrY9Tw5VJA8Lb4wWvuatHoF8J7ZHRXyyNYopJUKzFU7RTO/2XTWoYE+Oe5bzhrhi4ZCiOt/EESIY/CTmoGXUMVFyKMjkQJBAPvYvbZYZV6F+8LEkDFomZc5dby+4zb3VmAokUTaYNivriPDRVdi1CDOz3UIsWidZ5PxaLSJbTY2ZTslU+BaRg8CQQDSmT4d+ysYa6FvMR/cV6qE48spytZMUWMpuXBi0SEzJgzcfib5PgWy50OCEmsPhslkh82ZpjoGzQfUQV5F6JujAkEA76VM0OjIfOuNp8YXV4yrKkVZDaOu3iz5mkLACP6sTUTOteUoZID8TcO9kSYWeu/dEeATvEdRDtcv+NoKOGBubQJBAMGlANYGjqDczsr0K6yqu3OIFdZu2U/BgmHqTmm+jD2A3lCceu+xVQIk3hErKGBVerdCnA2NKEv6mRlVpf64HOsCQDidgu0aCaRPaNOHrYjgg+TePH9aj2Ny/9jEf0gAZGTepXUvt3gqa6ZmgslzlboeAQH/fVfRagsoXKp925vjHG0=";
    
    
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    
    order.biz_content.body = @"test";
    // order.biz_content.seller_id=seller;
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    NSLog(@"签名后的字符串是:%@",signedString);
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"boxInfomationGone";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        NSLog(@"订单字符串是:%@",orderString);
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}



//-(void)viewDidDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden=NO;
//    
//}
//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
