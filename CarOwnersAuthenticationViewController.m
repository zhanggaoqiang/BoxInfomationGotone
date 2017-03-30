//
//  CarOwnersAuthenticationViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/7.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "CarOwnersAuthenticationViewController.h"

@interface CarOwnersAuthenticationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int flag;
}
@property (strong, nonatomic) IBOutlet UIImageView *avaterImage;
@property (strong, nonatomic) IBOutlet UIImageView *identifyInfo;
@property (strong, nonatomic) IBOutlet UIImageView *identifyBack;
@property (strong, nonatomic) IBOutlet UIImageView *drivingLicense;
@property (strong, nonatomic) IBOutlet UIImageView *jiashiLicense;



@property (strong, nonatomic)  UIImageView *avaterImage1;
@property (strong, nonatomic)  UIImageView *identifyInfo1;
@property (strong, nonatomic)  UIImageView *identifyBack1;
@property (strong, nonatomic)  UIImageView *drivingLicense1;
@property (strong, nonatomic)  UIImageView *jiashiLicense1;



@property(strong,nonatomic)NSMutableArray *imagArray;


@end

@implementation CarOwnersAuthenticationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _avaterImage1=nil;
    _imagArray =[NSMutableArray arrayWithCapacity:100];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)imageUploadBtn:(UIButton *)sender {
    
     NSInteger intflag=sender.tag;
    NSLog(@"图片id是:%ld",intflag);
    switch (intflag-1000) {
        case 1001:
            flag=1;
            break;
        case 1002:
            flag=2;
            break;
        case 1003:
            flag=3;
            break;
        case 1004:
            flag=4;
            break;
        case 1005:
            flag=5;
            break;
            
        default:
            break;
    }
    
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
    switch (flag) {
        case 1:{
            self.avaterImage.image=image;
            self.avaterImage1=[[UIImageView alloc] init];
            self.avaterImage1.image=image;
//            if (self.imagArray.count!=0) {
//                [self.imagArray removeObjectAtIndex:0];
//            }
//            
//            [self.imagArray insertObject:image atIndex:0];
//            
        }
            
            break;
        case 2:{
            self.identifyInfo.image=image;
            self.identifyInfo1=[[UIImageView alloc] init];
            
            self.identifyInfo1.image=image;
            // [self.imagArray addObject:self.identifyCardFore.image];
            
        }
            
            break;
        case 3:{
            self.identifyBack.image=image;
            self.identifyBack1=[[UIImageView alloc] initWithImage:image];
            
            //self.identifyBack1.image=image;
            //  [self.imagArray addObject:self.identifyCardBack.image];
        }
            
            break;
        case 4:{
            self.drivingLicense.image=image;
            self.drivingLicense1=[[UIImageView alloc] init];
            self.drivingLicense1.image=image;
            //  [self.imagArray addObject:self.enterprisePicture.image];
        }
            
            break;
        case 5:{
            self.jiashiLicense.image=image;
            self.jiashiLicense1=[[UIImageView alloc] init];
            
            self.jiashiLicense1.image=image;
            //  [self.imagArray addObject:self.enterpriseCode.image];
            
        }
            
            break;
        default:
            break;
    }
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}



- (IBAction)cancelBtn:(id)sender {
    
}
- (IBAction)ensureUpload:(id)sender {
    
    if(self.avaterImage1==nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传头像"];
        return;
    }
    
    if (self.identifyInfo1==nil) {
          [SVProgressHUD showErrorWithStatus:@"请上传身份证正面照"];
        return;
    }
    
    
    if (self.identifyBack1==nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证反面照"];
        return;
    }
    if (self.drivingLicense1==nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传行驶证"];
        return;
    }

    
    if (self.jiashiLicense1==nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传驾驶证"];
        return;
    }
    
    [self.imagArray  addObject:self.avaterImage1.image];
    [self.imagArray addObject:self.identifyInfo1.image];
    [self.imagArray addObject:self.identifyBack1.image];
    [self.imagArray addObject:self.drivingLicense1.image];
    [self.imagArray addObject:self.jiashiLicense1.image];
    
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
    [manager POST:appCarOwnerIdentity parameters:@{@"account":@"18538556305"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        //        self.avaterImage.image
        for (int i=0;i<5;i++) {
            UIImage *image= self.imagArray[i];
            NSData *imageDatas = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageDatas
                                        name:@"photo"
                                    fileName:fileName
                                    mimeType:@".png"];
            
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        [uploadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
        

        //打印下上传进度
        NSLog(@"上传进度");
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
        
        
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chezhu" object:nil];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        NSLog(@"上传成功");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"fractionCompleted"]&&[object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress1 =(NSProgress *)object;
        
        __block typeof(progress1) progress = progress1;
        dispatch_sync(dispatch_get_main_queue(), ^() {
            double flt_Count=(float)progress.completedUnitCount/(float)(progress.totalUnitCount);
            [SVProgressHUD showProgress:flt_Count status:@"uploading"];
            
            
        });
        
    }
    
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
