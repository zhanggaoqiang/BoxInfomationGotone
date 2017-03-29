//
//  PersonInfoViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "EmailModifyViewController.h"
#import "NameModifyViewController.h"
#import "PhoneModifyViewController.h"

@interface PersonInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *avaterImage;
@property (strong, nonatomic) IBOutlet UIButton *nameBtn;

@property (strong, nonatomic) IBOutlet UILabel *genderBtn;

@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;
@property (strong, nonatomic) IBOutlet UIButton *emailBtn;
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImage;

//要修改的个人资料

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property(nonatomic,strong)NSString *imageString;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
  //  imagePre =[imagePre  stringByAppendingString:_imageStr];
    
    NSString *str=@"http://192.168.18.65:8080/ContainerofCommunication/";
    if(self.imageStr !=nil){
        str=[str stringByAppendingString:self.imageStr];

    }
    
    else {
        return;
    }
    
    
    
    NSLog(@"拼接的字符串地址:%@",str);
    
    [self.touxiangImage sd_setImageWithURL:[NSURL URLWithString:str]];
    self.nameLabel.text=self.name;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)avaerUpload:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选取", nil];
    [actionSheet showInView:self.view];

    
    NSLog(@"点击");
    
    
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
    [manager POST:appEditMyImage parameters:@{@"account":@"18538556305"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            
            
        
        NSData *imageDatas =UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageDatas
                                        name:@"photo"
                                    fileName:fileName
                                    mimeType:@".png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"上传进度");
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
        NSLog(@"上传成功");
          self.touxiangImage.image=image;
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];

    
    
    
    
}




- (IBAction)nameIdentify:(id)sender {
    NameModifyViewController *nvc=[[NameModifyViewController alloc] init];
    
    nvc.name=self.nameLabel.text;
    
    nvc.block=^(NSString *str) {
      
        self.nameLabel.text=str;
        
        
    };
    
    [self.navigationController pushViewController:nvc animated:YES];
}
- (IBAction)genderIdentify:(id)sender {
}

- (IBAction)phoneIdentify:(id)sender {
    PhoneModifyViewController *phone=[[PhoneModifyViewController alloc] init];
    phone.phoneStr=self.phoneLabel.text;
    phone.myBlock=^(NSString *str) {
        self.phoneLabel.text=str;
        
    };

    [self.navigationController pushViewController:phone animated:YES];
    
    
}
- (IBAction)emailIdentify:(id)sender {
    EmailModifyViewController *email=[[EmailModifyViewController alloc] init];
    email.emailText=self.emailLabel.text;
    email.emailBlock=^(NSString *str) {
      
        self.emailLabel.text=str;
        
    };
    [self.navigationController pushViewController:email animated:YES];
    
    
}


- (IBAction)backBtn:(id)sender {
    
    self.block(self.nameLabel.text,self.phoneLabel.text,self.emailLabel.text,self.imageStr);
    
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
