//
//  BoxDetailViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/17.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "BoxDetailViewController.h"

@interface BoxDetailViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backbutton;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *boxKinds;

@property (strong, nonatomic) IBOutlet UILabel *boxlength;
@property (strong, nonatomic) IBOutlet UILabel *boxcontain;
@property (strong, nonatomic) IBOutlet UILabel *boxload;
@property (strong, nonatomic) IBOutlet UILabel *boxzaizhong;
@property (strong, nonatomic) IBOutlet UILabel *boxAdress;

@end

@implementation BoxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDetail];
    // Do any additional setup after loading the view.
}


-(void)requestDetail {
    
    [SVProgressHUD showSuccessWithStatus:@"loading"];
    
    NSDictionary *dict1=@{@"account":@"15324715795",
                          @"ctsiId":self.index};
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:appGetOneContainerInfo parameters:dict1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"这条信息是:%@",dict);
        
        NSDictionary *dict1=dict[@"list"][0];
        
        self.name.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiContactName");
        self.boxKinds.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckType");
        self.boxload.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckLoad");
        self.boxlength.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckLength");
        self.boxzaizhong.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiTruckVolume");
        self.boxAdress.text=BACKINFO_DIC_2_OBJECT(dict1, @"tsiDeparturePlace");
        
        
        
//        
//        {
//            ctsiContainerNetweight = 11,
//            ctsiQuantity = ,
//            ctsiBrowseTimes = ,
//            ctsiContainerHeight = ,
//            ctsiDistrict = ,
//            ctsiExamineFlag = 0,
//            ctsiContainerImage = resources/img/PublishContainer/1490326329411.png,
//            ctsiDetails = 11,
//            ctsiPlace = ,
//            ctsiReturnDistrict = 雨湖区,
//            ctsiCity = ,
//            ctsiReturnProvince = 湖南省,
//            ctsiContainerSize = ,
//            ctsiContainerType = 20尺普箱,
//            clcCompanyName = ,
//            ctsiContainerLoad = 11,
//            updateDateTime = ,
//            ctsiExpiryDate = ,
//            ctsiHideFlag = 1,
//            ctsiReturnCity = 湘潭市,
//            createDateTime = 2017-03-24 11:31:07,
//            ctsiContainerWidth = ,
//            ctsiContainerLength = ,
//            ctsiRevokeFlag = 1,
//            ctsiProvince = ,
//            ctsiReturnPlace = 湖南省-湘潭市-雨湖区,
//            ctsiId = 10000200,
//            ctsiAccount = 18538556305
//        },
  
        
        
        
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
