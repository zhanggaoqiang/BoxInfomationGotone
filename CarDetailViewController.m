//
//  CarDetailViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/10.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "CarDetailViewController.h"

@interface CarDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *carkinds;
@property (strong, nonatomic) IBOutlet UILabel *carlength;
@property (strong, nonatomic) IBOutlet UILabel *carLoad;
@property (strong, nonatomic) IBOutlet UILabel *treadNum;
@property (strong, nonatomic) IBOutlet UILabel *carNum;
@property (strong, nonatomic) IBOutlet UILabel *latestAdress;

@property (strong, nonatomic) IBOutlet UILabel *attentionRoute1;
@property (strong, nonatomic) IBOutlet UILabel *attentionRoute2;


@property(strong,nonatomic)NSString *idx;

@end

@implementation CarDetailViewController



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.idx=self.index;
    
    [self requestDetail];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


-(void)requestDetail {
    
    [SVProgressHUD showSuccessWithStatus:@"loading"];
    
    
    NSDictionary *dict=@{
                         @"account":@"18538556305",
                         @"tsiId":self.idx
                         };
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appGetOneTruckInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"这条信息是:%@",dict);
          
        NSDictionary *dict1=dict[@"list"][0];
        
        self.name.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiAccount");
        
        self.carkinds.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckType");
        
        self.carLoad.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckVolume");
        self.carlength.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckLength");
        self.carlength.text=[self.carlength.text stringByAppendingString:@"米"];
        self.carNum.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiPlateNum");
        self.latestAdress.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiDeparturePlace");
        self.attentionRoute1.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiDeparturePlace");
        self.attentionRoute2.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiDestination");
        [SVProgressHUD dismiss];
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];

}



- (IBAction)backbutton:(id)sender {
    
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
