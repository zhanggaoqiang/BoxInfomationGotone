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

@property(strong,nonatomic)NSMutableArray *imagArray;


@end

@implementation CarOwnersAuthenticationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
            // [self.imagArray addObject:self.identifyCardFore.image];
            
        }
            
            break;
        case 3:{
            self.identifyBack.image=image;
            //  [self.imagArray addObject:self.identifyCardBack.image];
        }
            
            break;
        case 4:{
            self.drivingLicense.image=image;
            //  [self.imagArray addObject:self.enterprisePicture.image];
        }
            
            break;
        case 5:{
            self.jiashiLicense.image=image;
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
    
    if(self.avaterImage==nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传头像"];
        return;
    }
    
    [self.imagArray  addObject:self.avaterImage.image];
    [self.imagArray addObject:self.identifyInfo.image];
    [self.imagArray addObject:self.identifyBack.image];
    [self.imagArray addObject:self.drivingLicense.image];
    [self.imagArray addObject:self.jiashiLicense.image];
    
    
    
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
        //打印下上传进度
        NSLog(@"上传进度");
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
        NSLog(@"上传成功");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];
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