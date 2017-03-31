//
//  FindGoodsViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2016/12/30.
//  Copyright © 2016年 ZhongHao. All rights reserved.

#import "FindGoodsViewController.h"
#import "FindGoodsCell.h"
#import "GoodDetailViewController.h"
#import "ReleaseGoodsView.h"
#import "ModelCarViewController.h"
#import "CarDetailViewController.h"

@interface FindGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>
{
    IBOutlet UIScrollView *horizenScroll;
    IBOutlet UISegmentedControl *seg;//分段控制器
    int flag;
    NSString *endFootStr;
    int flagrefresh;
    
    
}

/*
 发布货源中的属性
 */
@property (strong, nonatomic) IBOutlet UITextField *startAdress;
@property (strong, nonatomic) IBOutlet UITextField *endAdress;

@property (strong, nonatomic) IBOutlet UITextField *inputGoodsGravity;//输入货物重量
@property (strong, nonatomic) IBOutlet UITextField *modelCarFiled;//输入车型车长
@property (strong, nonatomic) IBOutlet UITextField *inputGoodsVloum;//输入货物体积
@property (strong, nonatomic) IBOutlet UITextField *inputGoodsPrize;//输入货物价格
@property (strong, nonatomic) IBOutlet UITextField *inputGoodsDetail;//货物名称
@property (strong, nonatomic) IBOutlet UITextField *inputRemark;//输入备注信息
@property (strong, nonatomic) IBOutlet UITextField *ownerBoxFlag;//是否自备箱子

@property (strong, nonatomic) IBOutlet UITextField *bxoReturnAdress;


@property (strong, nonatomic) IBOutlet ReleaseGoodsView *xibView;//加载整个ReleaseGoodsView
@property (strong, nonatomic) IBOutlet UIButton *confirmReleasegoods;//确定发布货源
/*
 车源信息中的属性
 
 */
@property(nonatomic,strong)UIView *carSourceView;//车源信息界面
@property(nonatomic,strong)UIView *releaseGoodsView;//发布货源界面
@property(nonatomic,strong)UITableView *tab_list;//车源信息中的表视图
@property(nonatomic,strong)UIScrollView *rightScroll;
@property(strong,nonatomic)NSMutableArray *mutArr;//请求数据数组

@property(nonatomic,strong)UILabel *startLabel;//出发地选择

@property(nonatomic,strong)UILabel *endLabel;//目的地选择
@property (strong, nonatomic) IBOutlet UITextField *returnBoxAdress;//选择还箱地

@property (strong, nonatomic) IBOutlet UIView *pickerBgView;

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;

@property (strong, nonatomic) UIView *maskView;

@property(strong ,nonatomic)UIButton *provinceBtn;
@property(strong ,nonatomic)UIButton *cityBtn;
@property(strong,nonatomic)UIButton *townBtn;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;
@property(strong,nonatomic)NSString *startStr;
@property(strong,nonatomic)NSString *endStr;


@end

@implementation FindGoodsViewController

int indexPage=4;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.startStr=@"";
    
    self.endStr=@"";
    endFootStr=@"";
    
    [self creatGloabScroView];
    [seg addTarget:self action:@selector(didClickSegment:) forControlEvents:UIControlEventValueChanged];//segment触发事件
     [self creatLeftView];//加载车源信息表视图
    [self creatReleaseGoodsSource];//加载发布货源view
    [self firstPageRequest];//首页请求数据
    
    
    [self getPickerData];
    [self initView];
    
 }



-(void)dismissKeyboard {
    
    [self.inputGoodsDetail resignFirstResponder];
    [self.inputGoodsPrize resignFirstResponder];
    [self.inputGoodsGravity resignFirstResponder];
    [self.inputGoodsVloum resignFirstResponder];
    [self.startAdress resignFirstResponder];
    [self.endAdress resignFirstResponder];
    [self.inputRemark resignFirstResponder];
    [self.ownerBoxFlag resignFirstResponder];
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

- (IBAction)cancel:(UIButton *)sender {
    [self hideMyPicker];
}
- (IBAction)enrsure:(id)sender {

  
    
     if (flag==0) {
        
        self.startLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startLabel.text= [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startLabel.text=  [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
       
         self.startStr=[NSString stringWithString:self.startLabel.text];
             indexPage=4;
         flagrefresh=1;
         
         
                 NSNumber *myNumber = [NSNumber numberWithInt:indexPage];
        
        NSDictionary *dict=@{
                             @"beginPlace":self.startStr,
                             @"endPlace":self.endStr,
                             @"num":myNumber
                             
                             };
        
         [self request:dict];
        
    } if (flag==1) {
        flagrefresh=2;
        
        self.endLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.endLabel.text= [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.endLabel.text=  [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        self.endStr=self.endLabel.text;
        indexPage=4;
         NSNumber *myNumber = [NSNumber numberWithInt:indexPage];
    
               NSDictionary *dict=@{
                             @"beginPlace":self.startStr,
                             @"endPlace":self.endStr,
                             @"num":myNumber
                             
                             };
        [self request:dict];
        
    }
    
    
    
    if (flag==2) {
       
        self.startAdress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startAdress.text= [self.startAdress.text stringByAppendingString:@"-"];
        
        self.startAdress.text=[self.startAdress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startAdress.text=  [self.startAdress.text stringByAppendingString:@"-"];
        
        self.startAdress.text=[self.startAdress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
        
    }
    
    if (flag==3) {
        
       
        self.endAdress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.endAdress.text= [self.endAdress.text stringByAppendingString:@"-"];
        
        self.endAdress.text=[self.endAdress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.endAdress.text=  [self.endAdress.text stringByAppendingString:@"-"];
        
        self.endAdress.text=[self.endAdress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
    }
    
    
    
    if (flag==4) {
        
        self.bxoReturnAdress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.bxoReturnAdress.text= [self.bxoReturnAdress.text stringByAppendingString:@"-"];
        
        self.bxoReturnAdress.text=[self.bxoReturnAdress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.bxoReturnAdress.text=  [self.bxoReturnAdress.text stringByAppendingString:@"-"];
        
        self.bxoReturnAdress.text=[self.bxoReturnAdress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        

        
    }
    [self hideMyPicker];
}

-(void)request:(NSDictionary *)dict {
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:adressfind parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
        NSArray *arr_data= BACKINFO_DIC_2_OBJECT(dict, @"newList");
        
        [_mutArr removeAllObjects];
        
        [self.tab_list.mj_header endRefreshing];
        [self.tab_list.mj_footer endRefreshing];
        
        for (NSDictionary *dict in arr_data) {
            BoxFirstPageModel *model=[[BoxFirstPageModel alloc] init];
            model.createDateTime =BACKINFO_DIC_2_OBJECT(dict, @"createDateTime");
            model.tsiId=BACKINFO_DIC_2_OBJECT(dict, @"tsiId");
            model.tsiAccount=BACKINFO_DIC_2_OBJECT(dict, @"tsiAccount");
            model.tsiDeparturePlace=BACKINFO_DIC_2_OBJECT(dict, @"tsiDeparturePlace");
            model.tsiTruckType=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckType");
            model.tsiContactName=BACKINFO_DIC_2_OBJECT(dict, @"tsiContactName");
            model.tsiDestination=BACKINFO_DIC_2_OBJECT(dict, @"tsiDestination");
            model.tsiTruckVolume=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckVolume");
            model.tsiTruckLength=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckLength");
            
            [_mutArr addObject:model];
            
           }
        
        
        [self.tab_list reloadData];
        
        if ([dict[@"message"] isEqualToString:@"已经到最底部"] ) {
            self.tab_list.mj_footer.state=MJRefreshStateNoMoreData;
            
        }

       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];

    
}


-(void)creatGloabScroView {
    //车主界面中整个滑动页面的scroview
    horizenScroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    horizenScroll.contentSize=CGSizeMake(2*self.view.frame.size.width, self.view.frame.size.height-64);
    horizenScroll.pagingEnabled=YES;
    horizenScroll.delegate=self;
    horizenScroll.bounces=NO;
    horizenScroll.showsHorizontalScrollIndicator=NO;
    horizenScroll.showsVerticalScrollIndicator=NO;
    horizenScroll.userInteractionEnabled=YES;
    [self.view addSubview:horizenScroll];

    //车源信息的view
    _carSourceView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    _carSourceView.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
//    _carSourceView.backgroundColor=[UIColor redColor];
    [horizenScroll addSubview:_carSourceView];
    
    //发布货源的view
    _releaseGoodsView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    _releaseGoodsView.backgroundColor=[UIColor greenColor];
    [horizenScroll addSubview:_releaseGoodsView];//发布
    UITapGestureRecognizer *taphide=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.releaseGoodsView addGestureRecognizer:taphide];


    
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

-(void)creatLeftView{
    
    _startLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width/2-20, 30)];
     _startLabel.backgroundColor=[UIColor whiteColor];
    _startLabel.font=[UIFont systemFontOfSize:12];
    _startLabel.userInteractionEnabled=YES;
    _startLabel.text=@"请选择始发地";
    _startLabel.textAlignment=NSTextAlignmentCenter;
    _startLabel.layer.cornerRadius=5;
    _startLabel.layer.masksToBounds=YES;
    
    [_carSourceView addSubview:_startLabel];
    
   _endLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+10, 10, self.view.frame.size.width/2-20, 30)];
    _endLabel.backgroundColor=[UIColor whiteColor];
    _endLabel.font=[UIFont systemFontOfSize:12];
    _endLabel.userInteractionEnabled=YES;
    _endLabel.text=@"请选择目的地";
    _endLabel.textAlignment=NSTextAlignmentCenter;
    _endLabel.layer.cornerRadius=5;
    _endLabel.layer.masksToBounds=YES;
    
    
    
    [_carSourceView addSubview:_endLabel];
    
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLabel:)];
    tap1.delegate=self;
    [_startLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endLabel:)];
    tap2.delegate=self;
    [_endLabel addGestureRecognizer:tap2];
 
    
    _tab_list=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-49-64-50)];
    _tab_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab_list.delegate=self;
    _tab_list.dataSource=self;
    [_tab_list registerNib:[UINib nibWithNibName:@"FindGoodsCell" bundle:nil] forCellReuseIdentifier:@"FindGoodsCell"];
    _tab_list.showsHorizontalScrollIndicator=NO;
    _tab_list.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
      [_carSourceView addSubview:_tab_list];
    
   
    
    self.tab_list.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    [self.tab_list.mj_header beginRefreshing];
    self.tab_list.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        indexPage+=4;
        
        
     
     
        [self loadNewData];
    }];
   
   
}


-(void)loadNewData {
     [SVProgressHUD showSuccessWithStatus:@"正在更新数据中"];
    
    if (flagrefresh==1||flagrefresh==2) {
        NSNumber *myNumber = [NSNumber numberWithInt:indexPage];
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

-(void)firstPageRequest {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSNumber *myNumber = [NSNumber numberWithInt:indexPage];
    [manager POST:firstPage parameters:@{@"num": myNumber} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"获取数据是:%@",dict);
          NSArray *arr_data= BACKINFO_DIC_2_OBJECT(dict, @"newList");
        [_mutArr removeAllObjects];
        _mutArr=[NSMutableArray array];
        [self.tab_list.mj_header endRefreshing];
        [self.tab_list.mj_footer endRefreshing];
        
        for (NSDictionary *dict in arr_data) {
            BoxFirstPageModel *model=[[BoxFirstPageModel alloc] init];
            model.createDateTime =BACKINFO_DIC_2_OBJECT(dict, @"createDateTime");
            model.tsiId=BACKINFO_DIC_2_OBJECT(dict, @"tsiId");
            model.tsiAccount=BACKINFO_DIC_2_OBJECT(dict, @"tsiAccount");
            model.tsiDeparturePlace=BACKINFO_DIC_2_OBJECT(dict, @"tsiDeparturePlace");
            model.tsiTruckType=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckType");
            model.tsiContactName=BACKINFO_DIC_2_OBJECT(dict, @"tsiContactName");
            model.tsiDestination=BACKINFO_DIC_2_OBJECT(dict, @"tsiDestination");
            model.tsiTruckVolume=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckVolume");
            model.tsiTruckLength=BACKINFO_DIC_2_OBJECT(dict, @"tsiTruckLength");
      
            [_mutArr addObject:model];
            
            
        }
        
        if ([dict[@"message"] isEqualToString:@"已经到最底部"] ) {
        self.tab_list.mj_footer.state=MJRefreshStateNoMoreData;
            
        }
          [ SVProgressHUD showSuccessWithStatus:@"刷新成功"];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
                   [self.tab_list reloadData];

            
        });
 
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
 }

//发布货源视图
-(void)creatReleaseGoodsSource {
    
    [[NSBundle mainBundle] loadNibNamed:@"ReleaseGoodsView" owner:self options:nil];
    
    _xibView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-44);
    
    
    [_releaseGoodsView addSubview:_xibView];
    
     _modelCarFiled.delegate=self;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    [self.inputGoodsDetail resignFirstResponder];
    [self.inputGoodsPrize resignFirstResponder];
    [self.inputGoodsGravity resignFirstResponder];
    [self.inputGoodsVloum resignFirstResponder];
    [self.startAdress resignFirstResponder];
    [self.endAdress resignFirstResponder];
    

    return YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField==self.startAdress) {
        
        
        [self.inputGoodsDetail resignFirstResponder];
        [self.inputGoodsPrize resignFirstResponder];
        [self.inputGoodsGravity resignFirstResponder];
        [self.inputGoodsVloum resignFirstResponder];
        
        
        [self.inputRemark resignFirstResponder];
        [self.ownerBoxFlag resignFirstResponder];

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
    
    if (textField==self.endAdress) {
        [self.inputGoodsDetail resignFirstResponder];
        [self.inputGoodsPrize resignFirstResponder];
        [self.inputGoodsGravity resignFirstResponder];
        [self.inputGoodsVloum resignFirstResponder];
        
        
        [self.inputRemark resignFirstResponder];
        [self.ownerBoxFlag resignFirstResponder];

        flag=3;
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBgView];
        self.maskView.alpha = 0;
        _pickerBgView.top = self.view.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBgView.bottom = self.view.height;
        }];
        [_endAdress resignFirstResponder];
        
    }
    
    if(textField==self.modelCarFiled){
        
        ModelCarViewController *modelcar=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"ModelCarViewController"];
        [self.navigationController pushViewController:modelcar animated:YES];
        [modelcar setBlcok:^(NSString *str) {
            self.modelCarFiled.text=str;
            
        }];
        

        [self.modelCarFiled resignFirstResponder];
        
    }
    
    if(textField==self.ownerBoxFlag) {
        
        [self.inputGoodsDetail resignFirstResponder];
        [self.inputGoodsPrize resignFirstResponder];
        [self.inputGoodsGravity resignFirstResponder];
        [self.inputGoodsVloum resignFirstResponder];
        [self.startAdress resignFirstResponder];
        [self.endAdress resignFirstResponder];
        [self.inputRemark resignFirstResponder];
        [self.ownerBoxFlag resignFirstResponder];

        
        [self.ownerBoxFlag resignFirstResponder];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"是",@"否", nil];
        [actionSheet showInView:self.view];
        [self.ownerBoxFlag resignFirstResponder];
        
    }
    
    
    if (textField==self.bxoReturnAdress) {
        
        if ([self.ownerBoxFlag.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"请先选择是否自有箱子"];
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          
            [SVProgressHUD dismiss];
            
        });
        
        if ([self.ownerBoxFlag.text isEqualToString:@"否"]) {
            
            [SVProgressHUD showErrorWithStatus:@"不是自有箱子不能选择还箱地"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
            });
            
        }
        
        
        if ([self.ownerBoxFlag.text isEqualToString:@"是"]) {
            
            flag=4;
            [self.view addSubview:self.maskView];
            [self.view addSubview:self.pickerBgView];
            self.maskView.alpha = 0;
            _pickerBgView.top = self.view.height;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.maskView.alpha = 0.3;
                self.pickerBgView.bottom = self.view.height;
            }];
            [self.ownerBoxFlag resignFirstResponder];

        }
    
        
        
        
    }
    
    return NO;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        self.ownerBoxFlag.text=@"是";
    }
    
    if (buttonIndex == 1)
    {
        self.ownerBoxFlag.text=@"否";
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ( horizenScroll.contentOffset.x==self.view.frame.size.width) {
        seg.selectedSegmentIndex=1;
    }
    if (horizenScroll.contentOffset.x==0) {
        seg.selectedSegmentIndex=0;
         [self dismissKeyboard];
    }
}

-(void)didClickSegment:(UISegmentedControl*)seg {
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            horizenScroll.contentOffset=CGPointMake(0, 0);
            
            break;
            case 1:
            horizenScroll.contentOffset=CGPointMake(self.view.frame.size.width, 0);
            break;
            
        default:
            break;
    }
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      
    return _mutArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FindGoodsCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"FindGoodsCell" forIndexPath:indexPath] ;
    BoxFirstPageModel *model=_mutArr[indexPath.row];
    [cell showDataWithModel:model];
    
    

    return cell;
 }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
//    if(!SingleDefaluts.bol_Login) {
//        [self presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:YES completion:nil];
//        
//        
//    }else {
    CarDetailViewController *carDetail=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"CarDetailViewController"];
    BoxFirstPageModel *model=_mutArr[indexPath.row];
    carDetail.index=model.tsiId;

    [self.navigationController pushViewController:carDetail animated:YES];
   // }
    
}


- (IBAction)releaseBtn:(id)sender {
    
    if ([self.startAdress.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus :@"始发地不能为空"];
        return;
    }
    if ([self.endAdress.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"目的地不能为空"];
        return;
    }
    
    if ([self.inputGoodsGravity.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入货物重量"];
        return;
    }

    if ([self.inputGoodsVloum.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入货物体积"];
        return;
    }
         if ([self.modelCarFiled.text  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus: @"请选择车型车长"];
        return;
    }

    if ([self.inputGoodsPrize.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入货物运费"];
        return;
    }
    if ([self.inputGoodsDetail.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入货物描述"];
        return;
    }
    if ([self.inputRemark.text isEqualToString:@""]) {
        [SVProgressHUD  showErrorWithStatus:@"请输入备注信息"];
        return;
    }
    
    
    
   
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //河南省-郑州市-管城区
    //河南省-郑州市-二七区
    
    //湖南省-呼伦贝尔市-新城区
    
    
    NSDictionary *dict=@{@"account":@"15324715795",
                         @"beginPlace":self.startAdress.text,
                         @"endPlace":  self.endAdress.text,
                         @"cargoWeight":self.inputGoodsGravity.text,
                         @"truckType":self.modelCarFiled.text,
                         @"cargoVolume":self.inputGoodsVloum.text,
                         @"cargoFee":self.inputGoodsPrize.text,
                         @"cargoDesc":self.inputGoodsDetail.text,
                         @"cargoRemark":self.inputGoodsVloum.text,
                         @"backPlace":self.returnBoxAdress.text
                         };
    
    
    
    [manager POST:pulishCargoInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        
        [ SVProgressHUD  showWithStatus:@"发布成功，你可以去货源大厅查看你刚发布的那条信息哦!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ SVProgressHUD dismiss];
            
            
            self.startAdress.text=@"";
            self.endAdress.text=@"";
            self.inputGoodsGravity.text=@"";
            self.modelCarFiled.text=@"";
            self.inputGoodsVloum.text=@"";
            self.inputGoodsPrize.text=@"";
            self.inputGoodsDetail.text=@"";
            self.inputGoodsVloum.text=@"";
            self.returnBoxAdress.text=@"";
            self.ownerBoxFlag.text=@"";
            self.inputRemark.text=@"";
            
            
            
            
            
        });
    
        
        
        
        
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];

   // 18538556305
    
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
