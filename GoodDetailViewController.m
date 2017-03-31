//
//  GoodDetailViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/5.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "MapDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "MapDetailViewController.h"
#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface GoodDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *startCity;
@property (strong, nonatomic) IBOutlet UILabel *endCity;
@property (strong, nonatomic) IBOutlet UILabel *startDis;
@property (strong, nonatomic) IBOutlet UILabel *endDis;
@property (strong, nonatomic) IBOutlet UILabel *goodsKinds;
@property (strong, nonatomic) IBOutlet UILabel *goodsLength;
@property (strong, nonatomic) IBOutlet UILabel *carKinds;
@property (strong, nonatomic) IBOutlet UILabel *carlength;
@property (strong, nonatomic) IBOutlet UILabel *treadeAddress;
@property (strong, nonatomic) IBOutlet UILabel *publishTime;
@property (strong, nonatomic) IBOutlet UILabel *latestTime;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDetail];
    // Do any additional setup after loading the view.
}

-(void)requestDetail {
    
    [SVProgressHUD showSuccessWithStatus:@"loading"];
    
    NSDictionary *dict1=@{@"account":@"18538556305",
                          @"csiId":self.index};
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:appGetOneCargoInfo parameters:dict1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"这条信息是:%@",dict);
        
        NSDictionary *dict1=dict[@"list"][0];
        
        self.name.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiAccount");
        self.startCity.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiDpCity");
        self.endCity.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiRpCity");
        self.startDis.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiDpDistrict");//
        self.endDis.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiRpDistrict");
        self.goodsKinds.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiTruckType");
        self.goodsLength.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiExpectFee");
        self.carKinds.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiExpectFee");
        self.treadeAddress.text=BACKINFO_DIC_2_OBJECT(dict1, @"csiDeparturePlace");
        self.treadeAddress.text=[@"经营地址:" stringByAppendingString: self.treadeAddress.text];
        
        self.publishTime.text=BACKINFO_DIC_2_OBJECT(dict1, @"createDateTime");
        
        self.publishTime.text=[@"发布时间:" stringByAppendingString: self.publishTime.text];
       self.latestTime.text=BACKINFO_DIC_2_OBJECT(dict1, @"createDateTime");
        
        self.latestTime.text=[@"更新时间:" stringByAppendingString: self.latestTime.text];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    
}

- (IBAction)backhomebutton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)mapbutton:(id)sender {
    
    
    MapDetailViewController *mapDetail=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"MapDetailViewController"];
    
    mapDetail.startCity=self.startCity.text;
    
    mapDetail.endCity=self.endCity.text;
    mapDetail.startDis=self.startDis.text;
    mapDetail.endDis=self.endDis.text;
    
       NSLog(@"开始地是%@",self.startCity);
    
    [self.navigationController pushViewController:mapDetail animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id theSegue =segue.destinationViewController;
    [theSegue setValue:@"北京" forKey:@"startcity"];
    
}

- (IBAction)infomationFee:(id)sender {
    ConfirmOrderViewController *confirmOrder=[[ConfirmOrderViewController alloc] init];
    confirmOrder.index=self.index;
    
    
    [self.navigationController pushViewController:confirmOrder animated:YES];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
