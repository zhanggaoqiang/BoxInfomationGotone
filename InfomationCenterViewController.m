//
//  InfomationCenterViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/13.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "InfomationCenterViewController.h"
#import "InfomationCenterCell.h"


@interface InfomationCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tablist;

@property (strong,nonatomic)NSArray *dataArr;

@end

@implementation InfomationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tablist.delegate=self;
    _tablist.dataSource=self;
   // _dataArr=[[NSArray alloc] initWithObjects:@"站位",@"姓名",@"性别",@"手机号",@"身份证",@"邮箱",nil];
   
  
    
    [self firstPageRequest];
    
    // Do any additional setup after loading the view.
}





-(void)firstPageRequest {
 
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:appGetMyInfo parameters:@{@"account":@"18538556305"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"个人中心的个人信息是:%@",dict);
        
        
        
        NSString *str=BACKINFO_DIC_2_OBJECT(dict, @"imgAddress");
    
        NSLog(@"地址是%@",str);
        
       
        
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"imagestr"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfomationCenterCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InfomationCenterCell"];
    
    return cell;
    
}




- (IBAction)backBtn:(id)sender {
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
