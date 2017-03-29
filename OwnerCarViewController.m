//
//  OwnerCarViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/22.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "OwnerCarViewController.h"
#import "OwnerCarTableViewCell.h"

@interface OwnerCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tablist;

@property(strong,nonatomic)NSMutableArray *dataArr;

@end

@implementation OwnerCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self firstPageRequest];
    
    _tablist.delegate=self;
    _tablist.dataSource=self;
    _tablist.showsHorizontalScrollIndicator=NO;
    _tablist.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:_tablist];
    

    // Do any additional setup after loading the view from its nib.
}



-(void)firstPageRequest {
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [_dataArr removeAllObjects];
    _dataArr=[NSMutableArray array];
    
    [manager POST:appMyOwnerCarList parameters:@{@"account":@"18538556305"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr=dict[@"list"];
        NSLog(@"我的所有车辆%@",arr);
        
        
        for (NSDictionary *dict1 in arr) {
            MyCarModel *model=[[MyCarModel alloc] init];
            model.carNum=BACKINFO_DIC_2_OBJECT(dict1, @"tiPlateNum");
            model.carKinds=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckType");
            model.carLoad=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckVolume");
            model.carLength=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckLength");
            
            
            
            [_dataArr addObject:model];
            
        }
        
        [_tablist reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyCarModel *model=_dataArr[indexPath.row];
    
    
    static NSString *CellIdentifier = @"Cell1";
    OwnerCarTableViewCell *cell = (OwnerCarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OwnerCarTableViewCell class]) owner:self options:nil] objectAtIndex:0];
    }
    
    [cell showDataWithModel:model];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
