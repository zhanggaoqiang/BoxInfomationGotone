//
//  BoxSourceViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/17.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "BoxSourceViewController.h"
#import "BoxCellTableViewCell.h"
#import "BoxKindsChoiceViewController.h"
#import "BoxDetailViewController.h"
#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface BoxSourceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>
{
    int flagrefresh;
    int flag;
}

@property(nonatomic,strong)UITableView *tablist;

@property (strong, nonatomic) IBOutlet UIView *rightView;

@property (strong, nonatomic) IBOutlet UIScrollView *boxScroll;
@property (strong, nonatomic) UIView *blueView;
@property (strong, nonatomic) IBOutlet UIButton *boxinfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *releaseBtn;



//发布箱源
@property (strong, nonatomic) IBOutlet UITextField *boxFiledChoice;

@property (strong, nonatomic) IBOutlet UITextField *boxContainer;
@property (strong, nonatomic) IBOutlet UITextField *boxLoad;

@property (strong, nonatomic) IBOutlet UITextField *boxRemark;

@property (strong, nonatomic) IBOutlet UIImageView *boxImage;

@property (strong, nonatomic) IBOutlet UITextField *boxReturnAdress;




@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property(nonatomic,strong)UILabel *startLabel;//出发地选择

@property(nonatomic,strong)UILabel *endLabel;//目的地选择
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentbox;
//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@property (strong, nonatomic) UIView *maskView;

@property (strong, nonatomic) IBOutlet UIView *pickerBgView;


@end
int indexpage2=4;
@implementation BoxSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentbox addTarget:self action:@selector(didClickSegment:) forControlEvents:UIControlEventValueChanged];//segment触发事件

    
    _boxScroll.contentSize=CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height-64-50);
    _boxScroll.bounces=NO;
    _boxScroll.showsVerticalScrollIndicator=NO;
    _boxScroll.showsHorizontalScrollIndicator=NO;
    _boxScroll.pagingEnabled=YES;
    _boxScroll.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];

    
    [self.view addSubview:_boxScroll];
    
    
    
    _tablist=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height)];
   _tablist.delegate=self;
    _tablist.dataSource=self;
    
    [_tablist registerNib:[UINib nibWithNibName:@"BoxCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"BoxCellTableViewCell"];
    _tablist.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    _tablist.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tablist.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tablist.mj_header beginRefreshing];
    self.tablist.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        indexpage2+=4;
        
        [self loadNewData];
    }];
    



    
    [_boxScroll addSubview:_tablist];
    
    
    [[NSBundle mainBundle] loadNibNamed:@"BoxSourceView" owner:self options:nil];
    
    
    _rightView.frame=CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64-44);
    [_boxScroll addSubview:_rightView];
    
    UITapGestureRecognizer *taphide=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_rightView addGestureRecognizer:taphide];

    
    
    _boxFiledChoice.delegate=self;
    _boxFiledChoice.text=@"asdf";
    
    
    _startLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.view.frame.size.width/2-10, 30)];
    _startLabel.backgroundColor=[UIColor whiteColor];
    _startLabel.font=[UIFont systemFontOfSize:12];
    _startLabel.userInteractionEnabled=YES;
    _startLabel.text=@"请选择箱源所在地";
    _startLabel.textAlignment=NSTextAlignmentCenter;
    _startLabel.layer.cornerRadius=5;
    _startLabel.layer.masksToBounds=YES;
    
    [_boxScroll addSubview:_startLabel];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLabel:)];
    tap1.delegate=self;
    [_startLabel addGestureRecognizer:tap1];
    
    
    
    _endLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+5, 10, self.view.frame.size.width/2-10, 30)];
    _endLabel.backgroundColor=[UIColor whiteColor];
    _endLabel.font=[UIFont systemFontOfSize:12];
    _endLabel.userInteractionEnabled=YES;
    _endLabel.text=@"请选择还箱地";
    _endLabel.textAlignment=NSTextAlignmentCenter;
    _endLabel.layer.cornerRadius=5;
    _endLabel.layer.masksToBounds=YES;
    
    [_boxScroll addSubview:_endLabel];
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endlabel2:)];
    tap2.delegate=self;
    [_endLabel addGestureRecognizer:tap2];
    

    
    

    
    
    [self  requesBoxInfo];
    [self getPickerData];
    [self initView];
 
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageUpload:)];
    self.boxImage.userInteractionEnabled=YES;
    [self.boxImage addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    
    
    
}

-(void)endlabel2:(UITapGestureRecognizer *)tap {
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

-(void)dismissKeyboard {
    
    
    [self.boxFiledChoice resignFirstResponder];
    [self.boxContainer resignFirstResponder];
    [self.boxLoad resignFirstResponder];
    [self.boxRemark resignFirstResponder];
    [self.boxReturnAdress resignFirstResponder];
    
}

-(void)loadNewData {
    
    [SVProgressHUD showSuccessWithStatus:@"正在更新数据中"];
    if (flagrefresh==1) {
        NSNumber *myNumber = [NSNumber numberWithInt:indexpage2];
        NSDictionary *dict=@{
                             @"place":self.startLabel.text,
                             @"num":myNumber
                             
                             };
        [self request:dict];
        
    }else {
        [self requesBoxInfo];
    }

}


-(void)imageUpload:(UITapGestureRecognizer *)tap {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选取", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        UIImagePickerController *pick = [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
        pick.delegate = self;
    }
    
    if (buttonIndex == 1)
    {
        UIImagePickerController *pick = [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        pick.delegate = self;
    }
}

#pragma mark- 打开相机/相册
- (UIImagePickerController *)openPhotoToViewController:(UIViewController *)viewController sourceType:(UIImagePickerControllerSourceType)sourceType;
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.navigationBarHidden = YES;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [viewController presentViewController:picker animated:YES completion:^(void){}];
        return picker;
    }
    else
    {
        
    }
    return nil;
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    self.boxImage.image=image;

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


- (IBAction)cancel:(id)sender {
    
     [self hideMyPicker];
}

- (IBAction)ensure:(id)sender {
    
    if (flag==0) {
        
        self.startLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startLabel.text= [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startLabel.text=  [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
        NSNumber *myNumber = [NSNumber numberWithInt:indexpage2];
        NSDictionary *dict=@{
                             @"place":self.startLabel.text,
                             @"num":myNumber
                             
                             };
        
        [self request:dict];
        

        
    }
    
    if (flag==1) {
        
        self.startLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.startLabel.text= [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.startLabel.text=  [self.startLabel.text stringByAppendingString:@"-"];
        
        self.startLabel.text=[self.startLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
        NSNumber *myNumber = [NSNumber numberWithInt:indexpage2];
        NSDictionary *dict=@{
                             @"place":self.startLabel.text,
                             @"num":myNumber
                             
                             };
        
        [self request:dict];
        

        
    }
    
    
    
    if (flag==2) {
        
        
        self.endLabel.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.endLabel.text= [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.endLabel.text=  [self.endLabel.text stringByAppendingString:@"-"];
        
        self.endLabel.text=[self.endLabel.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
        
        NSNumber *myNumber = [NSNumber numberWithInt:indexpage2];
        NSDictionary *dict=@{
                             @"place":self.startLabel.text,
                             @"num":myNumber
                             
                             };
        
        [self request:dict];
        


        
    }
    
    
    
    if (flag==3) {
        self.boxReturnAdress.text=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        self.boxReturnAdress.text= [self.boxReturnAdress.text stringByAppendingString:@"-"];
        
        self.boxReturnAdress.text=[self.boxReturnAdress.text stringByAppendingString: [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1] ]];
        self.boxReturnAdress.text=  [self.boxReturnAdress.text stringByAppendingString:@"-"];
        
        self.boxReturnAdress.text=[self.boxReturnAdress.text  stringByAppendingString:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];

        
        
    }
    
    
    
    
    [self hideMyPicker];

}

-(void)request:(NSDictionary *)dict {
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:boxOwnerFind parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
        NSArray *arr_data= BACKINFO_DIC_2_OBJECT(dict, @"list");
        
        [ _dataArr removeAllObjects];
        
        for (NSDictionary *dict in arr_data) {
            BoxOwnerModel *model=[[BoxOwnerModel alloc] init];
            
            model.ctsiPlace=BACKINFO_DIC_2_OBJECT(dict, @"ctsiPlace");
            model.ctsiContainerLoad=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerLoad");
            model.ctsiContainerType=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerType");
            model.ctsiContainerSize=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerSize");
            [_dataArr addObject:model];
            
            [_dataArr addObject:model];
        }
        [self.tablist reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
 }



-(void)startLabel:(UITapGestureRecognizer *)tap {
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    _pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
    
}

-(void)requesBoxInfo {
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSNumber *myNumber=[NSNumber numberWithInt:indexpage2];
    
    [manager POST:boxOwner parameters:@{@"num":myNumber} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        [self.tablist.mj_header endRefreshing];

        _dataArr=[NSMutableArray array];
        NSArray *arr=dict[@"newList"];
        if ([dict[@"flag"] isEqual:@0]) {
            
                    for (NSDictionary *dict in arr) {
                        BoxOwnerModel *model=[[BoxOwnerModel alloc] init];
            
                        model.ctsiPlace=BACKINFO_DIC_2_OBJECT(dict, @"ctsiPlace");
                        model.ctsiContainerLoad=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerLoad");
                        model.ctsiContainerType=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerType");
                        model.ctsiContainerSize=BACKINFO_DIC_2_OBJECT(dict, @"ctsiContainerSize");
                        model.index=BACKINFO_DIC_2_OBJECT(dict, @"ctsiId");
                        [_dataArr addObject:model];
                    }
        }
        [ SVProgressHUD showSuccessWithStatus:@"刷新成功"];
        [self.tablist reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });

            
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"连接失败");
          }];
}


-(void)didClickSegment:(UISegmentedControl*)seg {
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            _boxScroll.contentOffset=CGPointMake(0, 0);
            
            break;
        case 1:
            _boxScroll.contentOffset=CGPointMake(self.view.frame.size.width, 0);
            
            break;
            
        default:
            break;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ( _boxScroll.contentOffset.x==self.view.frame.size.width) {
        _segmentbox.selectedSegmentIndex=1;
    }
    if (_boxScroll.contentOffset.x==0) {
        _segmentbox.selectedSegmentIndex=0;
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField==_boxFiledChoice) {
        
        BoxKindsChoiceViewController *kind=[MAIN_STORYBOARD  instantiateViewControllerWithIdentifier:@"BoxKindsChoiceViewController"];
        [self.navigationController pushViewController: kind animated:YES];
        
        
        
        [kind setMyBlock:^(NSString *textStr) {
            
            _boxFiledChoice.text=textStr;
            
        }];
    }
    
    
    if (textField==_boxReturnAdress) {
        flag=3;
        
        
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBgView];
        self.maskView.alpha = 0;
        _pickerBgView.top = self.view.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBgView.bottom = self.view.height;
        }];
        [_boxReturnAdress resignFirstResponder];

        
        
    }
    
    
    
    
    
    
    return NO;
    
}


//- (void)textFieldDidBeginEditing:(UITextField *)textField
//
//{
//    
//    [self resignFirstResponder];
//    
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BoxCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BoxCellTableViewCell" forIndexPath:indexPath];
    BoxOwnerModel *model=_dataArr[indexPath.row];
    [cell showDataWithModel:model];


    return cell;
}

- (IBAction)ensureReleaseBox:(id)sender {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //接收类型不一致请替换一致text/html或别的
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    //AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"account":@"15324715795",
                          @"containerType":self.boxFiledChoice.text,
                          @"containerWeight":self.boxLoad.text,
                          @"containerLoad":self.boxContainer.text,
                          @"containerRemark":self.boxRemark.text,
                          @"backPlace":self.boxReturnAdress.text
                          
                          };
    
    [manager POST:goodsOwnerIdentify parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image= self.boxImage.image;
        
        
        NSData *imageDatas = UIImageJPEGRepresentation(image, 0.2);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@", str];
        //上传的参数(上传图片，以文件流的格式)
        
        
        
        [formData appendPartWithFileData:imageDatas
                                    name:@"photo"
                                fileName:fileName                                mimeType:@".png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"上传进度");
        
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
        
        
          [SVProgressHUD  showSuccessWithStatus:@"发布成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });        NSLog(@"上传成功");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self presentViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"BoxDetailViewController"] animated:YES completion:nil];
    BoxDetailViewController *boxdetail=[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"BoxDetailViewController"];
    BoxOwnerModel *modle=_dataArr[indexPath.row];
    boxdetail.index=modle.index;
    
    
    
    [self.navigationController pushViewController:boxdetail animated:YES];
    
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
