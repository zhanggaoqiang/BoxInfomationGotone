//
//  MyCarViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/19.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "MyCarViewController.h"
#import "JXButton.h"
#import "AddMyCarViewController.h"
#import "MyCarTableViewCell.h"
#import "EditViewController.h"



@interface MyCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tablist;
@property (strong, nonatomic) IBOutlet UILabel *carLicense;
@property (strong, nonatomic) IBOutlet UILabel *carKinds;
@property (strong, nonatomic) IBOutlet UILabel *load;
@property (strong, nonatomic) IBOutlet UILabel *carlength;

@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleBtn;

@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchbtn;
@property(strong,nonatomic)MyCarTableViewCell *cell1;
@property(strong,nonatomic)NSMutableArray *dataArr;

//北京
//
@end




@implementation MyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  
}
-(void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];
    
    [self firstPageRequest];
    
    _tablist.delegate=self;
    _tablist.dataSource=self;
    _tablist.showsHorizontalScrollIndicator=NO;
    _tablist.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:_tablist];

    
    
    

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyCarModel *model=_dataArr[indexPath.row];
    
    
    static NSString *CellIdentifier = @"Cell";
    MyCarTableViewCell *cell = (MyCarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    _cell1=cell;
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyCarTableViewCell class]) owner:self options:nil] objectAtIndex:0];
            }
    
    [cell showDataWithModel:model];
    
    return cell;
    
}






- (IBAction)deleteAcar:(id)sender {
    
    self.tablist.editing=!self.tablist.editing;
    
    
}

- (IBAction)editBtn:(id)sender {
    
   // MyCarTableViewCell *cell=[[MyCarTableViewCell alloc] init];
    _cell1.editImage.hidden=!_cell1.editImage.hidden;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    model.carNum=BACKINFO_DIC_2_OBJECT(dict1, @"tiPlateNum");
//    model.carKinds=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckType");
//    model.carLoad=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckVolume");
//    model.carLength=BACKINFO_DIC_2_OBJECT(dict1, @"tiTruckLength");
//
    
    
    EditViewController *edit=[[EditViewController alloc] init];
    
//    NSLog(@"数组中的内容是%@",_dataArr[indexPath.row]);
//    
//    
//    edit.carNum1=_dataArr[indexPath.row][@"tiPlateNum"];
//    edit.carKinds1=_dataArr[indexPath.row][@"tiTruckType"];
//    edit.carVolume1=_dataArr[indexPath.row][@"tiTruckVolume"];
//     edit.carLength1=_dataArr[indexPath.row][@"tiTruckLength"];
    //    edit.carNum1=_dataArr[indexPath.row][@"tiPlateNum"];
    //    edit.carKinds1=_dataArr[indexPath.row][@"tiTruckType"];
    //    edit.carVolume1=_dataArr[indexPath.row][@"tiTruckVolume"];
    //     edit.carLength1=_dataArr[indexPath.row][@"tiTruckLength"];
    
    MyCarModel *model=_dataArr[indexPath.row];
    edit.carNum1=model.carNum;
    edit.carKinds1=model.carKinds;
    edit.carLength1=model.carLength;
   
    
    
   
    [self.navigationController pushViewController:edit animated:YES];
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ///删除
    //先从数据源数组中删除指定的数据
        //删除指定索引
    [_dataArr removeObjectAtIndex:indexPath.row];
//    NSString *index=dict[@"tild"];
//    NSLog(@"这一条信息的id是%@",index);
//    
      //数据源 一旦变化 必须要刷新表格 ,保持同步
    

    //刷新表格  整个表格
    //reloadData 会把 协议中的三个方法 1.多少分区2.分区有多少行3.创建显示cell 重新调用
   
 
    
    
    NSDictionary *dict1=@{@"account":@"18538556305",
                         @"tiId":@(29)
                         };
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
        [manager POST:appDeleteMyOwnerCarInfo  parameters: dict1 progress:^(NSProgress * _Nonnull uploadProgress) {
    
    
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"删除后的返回值%@",dict);
   
             [self.tablist reloadData];
            
        
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败");
        }];
    
    

    
}


- (IBAction)addCar:(id)sender {
    AddMyCarViewController *addMyCar=[[AddMyCarViewController alloc] init];
    [self.navigationController pushViewController:addMyCar animated:YES];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    
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
