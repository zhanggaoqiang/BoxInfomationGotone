//
//  NowCertificateViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/10.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "NowCertificateViewController.h"

@interface NowCertificateViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int flag;
}
@property (strong, nonatomic) IBOutlet UIImageView *avaterImage;

@property (strong, nonatomic) IBOutlet UIImageView *identifyCardFore;
@property (strong, nonatomic) IBOutlet UIImageView *identifyCardBack;
@property (strong, nonatomic) IBOutlet UIImageView *enterprisePicture;
@property (strong, nonatomic) IBOutlet UIImageView *enterpriseCode;
@property (strong, nonatomic) IBOutlet UIButton *avaterbtn;

@property(strong,nonatomic)NSMutableArray *imagArray;

@end

@implementation NowCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagArray =[NSMutableArray arrayWithCapacity:100];
    
  
    // Do any additional setup after loading the view.
}






- (IBAction)imageBtn:(UIButton *)sender {
    NSInteger intflag=sender.tag;
    NSLog(@"图片id是:%ld",intflag);
    switch (intflag) {
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
            if (self.imagArray.count!=0) {
                 [self.imagArray removeObjectAtIndex:0];
            }
          
            [self.imagArray insertObject:image atIndex:0];
            
        }
            
            break;
        case 2:{
            self.identifyCardFore.image=image;
           // [self.imagArray addObject:self.identifyCardFore.image];
            
        }
            
            break;
        case 3:{
            self.identifyCardBack.image=image;
          //  [self.imagArray addObject:self.identifyCardBack.image];
        }
            
            break;
        case 4:{
            self.enterprisePicture.image=image;
          //  [self.imagArray addObject:self.enterprisePicture.image];
        }
            
            break;
        case 5:{
            self.enterpriseCode.image=image;
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
- (IBAction)back:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
    
    
    
}





-(NSData *)upload:(UIImage*)image {
    
    
    
    
    return nil;
    
}
- (IBAction)ensurePostImg:(UIButton *)sender {
    
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
    [manager POST:appCLCIdentity parameters:@{@"account":@"18538556305"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        self.avaterImage.image
         for (int i=0;i<3;i++) {
             UIImage *image= [UIImage imageNamed:@"1.png"];
             
             
             NSData *imageDatas = UIImagePNGRepresentation(image);
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
     
    
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer.timeoutInterval = 20;
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
//        // 在parameters里存放照片以外的对象
//        [manager POST:goodsOwnerIdentify parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
            // 这里的_photoArr是你存放图片的数组
//            for (int i = 0; i < _photosArr.count; i++) {
//    
//                UIImage *image = _photosArr[i];
//                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    
//                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//                // 要解决此问题，
//                // 可以在上传时使用当前的系统事件作为文件名
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                // 设置时间格式
//                [formatter setDateFormat:@"yyyyMMddHHmmss"];
//                NSString *dateString = [formatter stringFromDate:[NSDate date]];
//                NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//                /*
//                 *该方法的参数
//                 1. appendPartWithFileData：要上传的照片[二进制流]
//                 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//                 3. fileName：要保存在服务器上的文件名
//                 4. mimeType：上传的文件的类型
//                 */
//                [formData appendPartWithFileData:imageData name:@"upload" fileName:fileName mimeType:@"image/jpeg"]; //
//            }
            
            




//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
