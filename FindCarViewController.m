//
//  FindCarViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/10.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "FindCarViewController.h"
//#import "FindCarTableViewCell.h"
#import "FindCarCell.h"
#import "ModelCarViewController.h"
#import "OwnerCarViewController.h"
#import "GoodDetailViewController.h"
#import "LoginViewController.h"
#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]



@interface FindCarViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    int flag;
     int flagrefresh;
}

//发布车源中的信息
@property (strong, nonatomic) IBOutlet UITextField *startAdress;
@property (strong, nonatomic) IBOutlet UITextField *endStress;
@property (strong, nonatomic) IBOutlet UITextField *LicensePlateNumber;
@property (strong, nonatomic) IBOutlet UITextField *carKindsAndlength;

@property (strong, nonatomic) IBOutlet UITextField *carLoad;

@property (strong, nonatomic) IBOutlet UITextField *carVolume;

@property (strong, nonatomic) IBOutlet UITextField *haveCar;


@property (strong, nonatomic) IBOutlet UIScrollView *goodsScroller;
@property(strong,nonatomic)UITableView *tablist;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;


@property (strong, nonatomic) IBOutlet UIView *inditView;

@property (strong, nonatomic) UIView *blueView;
@property(strong,nonatomic)NSMutableArray *dataArr;

@property(nonatomic,strong)UILabel *startLabel;//出发地选择

@property(nonatomic,strong)UILabel *endLabel;//目的地选择

@property(strong ,nonatomic)UIButton *provinceBtn;
@property(strong ,nonatomic)UIButton *cityBtn;
@property(strong,nonatomic)UIButton *townBtn;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@property (strong, nonatomic) IBOutlet UIView *xibView;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;

@property(strong,nonatomic)NSString *startStr;
@property(strong,nonatomic)NSString *endStr;


@end

 int indexPage1=4;

@implementation FindCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startStr=@"";
    
    self.endStr=@"";
    _goodsScroller. contentSize=CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height-64-50);
    _goodsScroller.bounces=NO;
    _goodsScroller.pagingEnabled=YES;
    _goodsScroller.showsVerticalScrollIndicator=NO;
    _goodsScroller.showsHorizontalScrollIndicator=NO;
    _goodsScroller.delegate=self;
    
    _goodsScroller.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];

    
    _startLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width/2-20, 30)];
    _startLabel.backgroundColor=[UIColor whiteColor];
    _startLabel.font=[UIFont systemFontOfSize:12];
    _startLabel.userInteractionEnabled=YES;
    _startLabel.text=@"请选择始发地";
    _startLabel.textAlignment=NSTextAlignmentCenter;
    _startLabel.layer.cornerRadius=5;
    _startLabel.layer.masksToBounds=YES;
    
    [_goodsScroller addSubview:_startLabel];
    
    _endLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+10, 10, self.view.frame.size.width/2-20, 30)];
    _endLabel.backgroundColor=[UIColor whiteColor];
    _endLabel.font=[UIFont systemFontOfSize:12];
    _endLabel.userInteractionEnabled=YES;
    _endLabel.text=@"请选择目的地";
    _endLabel.textAlignment=NSTextAlignmentCenter;
    _endLabel.layer.cornerRadius=5;
    _endLabel.layer.masksToBounds=YES;
    [_goodsScroller addSubview:_endLabel];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLabel:)];
    tap1.delegate=self;
    [_startLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endLabel:)];
    tap2.delegate=self;
    [_endLabel addGestureRecognizer:tap2];


    
    _tablist=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50-49)];
    
    _tablist.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];

    
    
    
    [_tablist registerNib:[UINib nibWithNibName:@"FindCarCell" bundle:nil] forCellReuseIdentifier:@"FindCarCell"];
    
    self.tablist.delegate=self;
    self.tablist.dataSource=self;
    

    
      [_goodsScroller addSubview:_tablist];
    self.tablist.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tablist.mj_header beginRefreshing];
   
    
    self.tablist.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        indexPage1+=4;
        
        
        [self loadNewData];
    }];

    
    
    [[NSBundle mainBundle] loadNibNamed:@"ReleaseCarSource" owner:self options:nil];
    
    
   self.xibView.frame=CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64-44);
    [_goodsScroller addSubview:self.xibView];
    
    UITapGestureRecognizer *taphide=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.xibView addGestureRecognizer:taphide];
    

    
    [self.segment addTarget:self action:@selector(didClickSegment:) forControlEvents:UIControlEventValueChanged];//segment触发事件
    // Do any additional setup after loading the view.
//    
//    UITapGestureRecognizer *taphide=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.goodsScroller addGestureRecognizer:taphide];
    
    [self firstPageRequest];
    
    [self initView];
    [self getPickerData];
    
}

-(void)loadNewData {
    [SVProgressHUD showSuccessWithStatus:@"正在更新数据中"];
    if (flagrefresh==1||flagrefresh==2) {
        NSNumber *myNumber = [NSNumber numberWithInt:indexPage1];
        NSDictionary *dict=@{
                             @"beginPlace":self.startStr,
                             @"endPlace":self.endStr,
                             @"num":myNumber
                             
                             };
        [self request:dict];
        
        
    }else {
        [self firstPageRequest];
    }

}

-(void)dismissKeyboard {
 
    
    [self.startAdress resignFirstResponder];
    [self.endStress resignFirstResponder];
    [self.LicensePlateNumber resignFirstResponder];
    [self.carKindsAndlength resignFirstResponder];
   
       [self.carLoad resignFirstResponder];
    [self.carVolume resignFirstResponder];
    [self.haveCar resignFirstResponder];
    
}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    
    if (textField==self.carKindsAndlength) {
        ModelCarViewController *modelcar=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"ModelCarViewController"];
        [self.navigationController pushViewController:modelcar animated:YES];
        [modelcar setBlcok:^(NSString *str) {
            self.carKindsAndlength.text=str;
            
        }];
        
        
        [self.carKindsAndlength resignFirstResponder];
        
        
        
    }
 
    if (textField==self.startAdress) {
        flag=2;
       
        
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBgView];
        self.maskView.alpha = 0;
        _pickerBgView.top = self.view.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBgView.bottom = self.view.height;
        }];
        [_startAdress resignFirstResponder];
        
    }
    if (textField==self.endStress) {
        
        flag=4;
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBgView];
        self.maskView.alpha = 0;
        _pickerBgView.top = self.view.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBgView.bottom = self.view.height;
        }];
        [_endStress resignFirstResponder];
        
    }
    
    
    if(textField ==self.haveCar) {
        
        OwnerCarViewController *owner=[[OwnerCarViewController alloc] init];
        [self.navigationController pushViewController:owner animated:YES];
        
        
        
        
    }
    
    

    return NO;
}


-(void)startLabel:(UITapGestureRecognizer *)tap1 {
    flag=0;
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    _pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
    
    
    
}


-(void)endLabel:(UITapGestureRecognizer *)tap2 {
    flag=1;
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    _pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
    
    
}

- (IBAction)cancel:(id)sender {
     [self hideMyPicker];
}



- (IBAction)ensure:(id)sender {

    if (flag==0) {
        flagrefresh=1;
        
        
        self.startLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startLabel.text= [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startLabel.text=  [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        self.startStr=self.startLabel.text;
        
           NSNumber *myNumber=[NSNumber numberWithInt:indexPage1];
        NSDictionary *dict=@{
                             @"beginPlace":self.startStr,
                             @"endPlace":self.endStr,
                             @"num":myNumber

                              };
        
        [self request:dict];
    }
    
    
    if (flag==1) {
        flagrefresh=2;
        self.endLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.endLabel.text= [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.endLabel.text=  [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];

        NSNumber *myNumber=[NSNumber numberWithInt:indexPage1];
        
        self.endStr=self.endLabel.text;

        NSDictionary *dict=@{
                             @"beginPlace":self.startStr,
                             @"endPlace":self.endStr,
                             @"num": myNumber
                             
                             };
        [self request:dict];
        
    }
    
    
    
    if (flag==2) {
        
        [self.LicensePlateNumber resignFirstResponder];
        [self.carKindsAndlength resignFirstResponder];
        
        [self.carLoad resignFirstResponder];
        [self.carVolume resignFirstResponder];
        [self.haveCar resignFirstResponder];

       
        
        self.startAdress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startAdress.text= [self.startAdress.text stringByAppendingString:@"-"];
        
        self.startAdress.text=[self.startAdress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startAdress.text=  [self.startAdress.text stringByAppendingString:@"-"];
        
        self.startAdress.text=[self.startAdress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
        
        
    }
    
    if (flag==4) {
        
        [self.LicensePlateNumber resignFirstResponder];
        [self.carKindsAndlength resignFirstResponder];
        
        [self.carLoad resignFirstResponder];
        [self.carVolume resignFirstResponder];
        [self.haveCar resignFirstResponder];

        
        
        self.endStress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.endStress.text= [self.endStress.text stringByAppendingString:@"-"];
        
        self.endStress.text=[self.endStress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.endStress.text=  [self.endStress.text stringByAppendingString:@"-"];
        
        self.endStress.text=[self.endStress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];

        
    }


    
    [self hideMyPicker];

    
}




-(void)request:(NSDictionary *)dict {
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:adressfind1 parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startLabel2"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"按地址查询结果是%@",dict);
        
        
        NSArray *arr_data= BACKINFO_DIC_2_OBJECT(dict, @"newList");
        
        [_dataArr removeAllObjects];
        _dataArr =[NSMutableArray array];
        
        [self.tablist.mj_header endRefreshing];
        [self.tablist.mj_footer endRefreshing];
        
        
        for (NSDictionary *dict in arr_data) {
            GoodsOwnerModel *model=[[GoodsOwnerModel alloc] init];
            
            model.csiContactName=BACKINFO_DIC_2_OBJECT(dict, @"csiContactName");
            model.csiReceiptPlace=BACKINFO_DIC_2_OBJECT(dict, @"csiReceiptPlace");
            model.csiCargoWeight=BACKINFO_DIC_2_OBJECT(dict, @"csiCargoWeight");
            model.csiRpDistrict=BACKINFO_DIC_2_OBJECT(dict, @"csiRpDistrict");
            model.csiRpCity=BACKINFO_DIC_2_OBJECT(dict, @"csiRpCity");
            model.csiDpCity=BACKINFO_DIC_2_OBJECT(dict, @"csiDpCity");
            model.csiDpDistrict=BACKINFO_DIC_2_OBJECT(dict, @"csiDpDistrict");
            [_dataArr addObject:model];
            
        }
        if ([dict[@"message"] isEqualToString:@"已经到最底部"] ) {
            self.tablist.mj_footer.state=MJRefreshStateNoMoreData;
            
        }
        [ SVProgressHUD showSuccessWithStatus:@"刷新成功"];
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
                [self.tablist reloadData];

            
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    

    
}




#pragma mark - init view
- (void)initView {
    
    self.maskView = [[UIView alloc] initWithFrame:kScreen_Frame];
    self.maskView.backgroundColor = [UIColor blackColor];
    
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    self.pickerBgView.width = kScreen_Width;
    
}
#pragma mark - get data
- (void)getPickerData {
    self.myPicker.delegate=self;
    self.myPicker.dataSource=self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return self.view.frame.size.width/3;
    } else if (component == 1) {
        return self.view.frame.size.width/3;
    } else {
        return self.view.frame.size.width/3;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
    
}

#pragma mark - private method
- (IBAction)showMyPicker:(id)sender {
    
   
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    _pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}



-(void)firstPageRequest {
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
   NSNumber *myNumber = [NSNumber numberWithInt:indexPage1];
    [manager POST:goodsOwner parameters:@{@"num":myNumber} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self.tablist.mj_header endRefreshing];
        [self.tablist.mj_footer endRefreshing];
        NSArray *arr_data= BACKINFO_DIC_2_OBJECT(dict, @"newList");
        NSLog(@"货源大厅详情%@",arr_data);

        [_dataArr removeAllObjects];
        _dataArr=[NSMutableArray array];
        

        for (NSDictionary *dict in arr_data) {
           GoodsOwnerModel *model=[[GoodsOwnerModel alloc] init];

            model.csiContactName=BACKINFO_DIC_2_OBJECT(dict, @"csiContactName");
            model.csiReceiptPlace=BACKINFO_DIC_2_OBJECT(dict, @"csiReceiptPlace");
            model.csiCargoWeight=BACKINFO_DIC_2_OBJECT(dict, @"csiCargoWeight");
            model.csiRpDistrict=BACKINFO_DIC_2_OBJECT(dict, @"csiRpDistrict");
            model.csiRpCity=BACKINFO_DIC_2_OBJECT(dict, @"csiRpCity");
            model.csiDpCity=BACKINFO_DIC_2_OBJECT(dict, @"csiDpCity");
            model.csiDpDistrict=BACKINFO_DIC_2_OBJECT(dict, @"csiDpDistrict");
            model.csiMinTruckLength=BACKINFO_DIC_2_OBJECT(dict, @"csiMinTruckLength");
            model.index=BACKINFO_DIC_2_OBJECT(dict, @"csiId");
            model.csiCargoDesc=BACKINFO_DIC_2_OBJECT(dict, @"csiCargoDesc");
            model.csiTruckType=BACKINFO_DIC_2_OBJECT(dict, @"csiTruckType");
            [_dataArr addObject:model];
        }

        
        if ([dict[@"message"] isEqualToString:@"已经到最底部"] ) {
            self.tablist.mj_footer.state=MJRefreshStateNoMoreData;
            
        }
           [ SVProgressHUD showSuccessWithStatus:@"刷新成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tablist reloadData];
            
        });

        

      
        
                }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ( _goodsScroller.contentOffset.x==self.view.frame.size.width) {
        _segment.selectedSegmentIndex=1;
    }
    if (_goodsScroller.contentOffset.x==0) {
        _segment.selectedSegmentIndex=0;
        [self dismissKeyboard];
    }
}

-(void)didClickSegment:(UISegmentedControl*)seg {
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
              _goodsScroller.contentOffset=CGPointMake(0, 0);
            
            break;
        case 1:
            _goodsScroller.contentOffset=CGPointMake(self.view.frame.size.width, 0);

            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FindCarCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"FindCarCell" forIndexPath:indexPath] ;
    GoodsOwnerModel *model=_dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"GoodDetailViewController"] animated:YES completion:nil];
    
//    typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
//        UIModalPresentationFullScreen = 0,
//        UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
//        UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
//        UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
//        UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
//        UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
//        UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
//        UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
//        UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
//    };
//
    
    if(!SingleDefaluts.bol_Login) {
        
        LoginViewController *locv=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"LoginViewController"];
     
        
        
        
        [self presentViewController:locv animated:YES completion:nil];
        return;
        
        
    }
    

    
    
    GoodDetailViewController *goodsDetail=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"GoodDetailViewController"];
    GoodsOwnerModel *model=_dataArr[indexPath.row];
    goodsDetail.index= model.index;
    goodsDetail.modalPresentationStyle=UIViewContentModeScaleToFill;
   // [self presentViewController:goodsDetail animated:YES completion:nil];
    [self.navigationController pushViewController:goodsDetail animated:YES];
}




- (IBAction)confirmRelease:(id)sender {
//    /发布车源中的信息
//    @property (strong, nonatomic) IBOutlet UITextField *startAdress;
//    @property (strong, nonatomic) IBOutlet UITextField *endStress;
//    @property (strong, nonatomic) IBOutlet UITextField *LicensePlateNumber;
//    @property (strong, nonatomic) IBOutlet UITextField *carKindsAndlength;
//    
//    @property (strong, nonatomic) IBOutlet UITextField *carLoad;
//    
//    @property (strong, nonatomic) IBOutlet UITextField *carVolume;
//    
//    @property (strong, nonatomic) IBOutlet UITextField *haveCar;
//
    if ([self.startAdress.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus :@"始发地不能为空"];
        return;
    }
    if ([self.endStress.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"目的地不能为空"];
        return;
    }
    
    if ([self.LicensePlateNumber.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"车牌号不能为空"];
        return;
    }
    
    if ([self.carKindsAndlength.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"车型车长"];
        return;
    }
    if ([self.carLoad.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus: @"车辆载重"];
        return;
    }
    
//    if ([self.haveCar.text isEqualToString:@""]) {
//        [SVProgressHUD showErrorWithStatus:@"请选择已有车辆"];
//        return;
//    }
//    
    
    
    
    if(!SingleDefaluts.bol_Login) {
        
        LoginViewController *locv=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"LoginViewController"];
        locv.flagStr=@"发布货源";
        
        
        
        [self presentViewController:locv animated:YES completion:nil];
        return;
        
        
    }
    

    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //河南省-郑州市-管城区
    //河南省-郑州市-二七区
    
    //湖南省-呼伦贝尔市-新城区
    
    
    NSDictionary *dict=@{@"account":@"18538556305",
                         @"beginPlace":self.startAdress.text,
                         @"endPlace":  self.endStress.text,
                         @"plateNum":self.LicensePlateNumber.text,
                         @"truckType":self.carKindsAndlength.text,
                         @"truckLoad":self.carLoad.text,
                         @"truckVolume":self.carVolume.text,
                         };
    
    [manager POST:pulishCargoInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [ SVProgressHUD  showWithStatus:@"发布成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ SVProgressHUD dismiss];
            
//            
//            self.startAdress.text=@"";
//            self.endAdress.text=@"";
//            self.inputGoodsGravity.text=@"";
//            self.modelCarFiled.text=@"";
//            self.inputGoodsVloum.text=@"";
//            self.inputGoodsPrize.text=@"";
//            self.inputGoodsDetail.text=@"";
//            self.inputGoodsVloum.text=@"";
//            self.returnBoxAdress.text=@"";
            
        });
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
    
    // 18538556305
    

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >0) { // 如果push进来的不是第一个控制器
        self.tabBarController.tabBar.hidden=YES;
    }


}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
