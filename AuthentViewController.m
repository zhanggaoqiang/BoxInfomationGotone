//
//  AuthentViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/5.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "AuthentViewController.h"
#import "CarOwnersAuthenticationViewController.h"
#import "OwnerOfCargoViewController.h"
#import "EnterpriseGoodsOwnerViewController.h"
#define windowContentHeight ([[UIScreen mainScreen] bounds].size.height)

#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface AuthentViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage* paiZhaoImage;

}
//@property (strong, nonatomic) IBOutlet UIScrollView *auscrollview;
//@property (strong, nonatomic) IBOutlet UIImageView *AdentifyFore;
//
//@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;

@property (strong, nonatomic) IBOutlet UIButton *backbutton;

@end

@implementation AuthentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_backbutton setTitle:@"认证中心" forState:UIControlStateNormal];
    [_backbutton setImage:[UIImage imageNamed:@"返回键"] forState:UIControlStateNormal];
  
    
    
   // self.view.backgroundColor=[UIColor lightGrayColor];
//    
//    self.auscrollview.contentSize=CGSizeMake(375, 1000);
//    
//    
//    self.AdentifyFore.userInteractionEnabled=YES;
//    
//    UITapGestureRecognizer *tab=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto:)];
//    [self.AdentifyFore  addGestureRecognizer:tab];
//    
//    self.avatarImage.layer.cornerRadius=30;
//    self.avatarImage.layer.masksToBounds=YES;
//    
    
    
    // Do any additional setup after loading the view.
}




- (IBAction)backBtn:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}






- (IBAction)goCertificate:(id)sender {
    CarOwnersAuthenticationViewController *carOwner=[[CarOwnersAuthenticationViewController alloc] init];
    
     [self.navigationController pushViewController:carOwner animated:YES];
}

- (IBAction)boxIdentify:(id)sender {
    
    

    [self.navigationController pushViewController:[MAIN_STORYBOARD instantiateViewControllerWithIdentifier:@"NowCertificateViewController"] animated:YES];
    
    
}


- (IBAction)enterPriseIdentify:(id)sender {
    
    EnterpriseGoodsOwnerViewController *enter=[[EnterpriseGoodsOwnerViewController alloc] init];
    [self.navigationController pushViewController:enter animated:YES];
}

- (IBAction)individualCarOwner:(id)sender {
    OwnerOfCargoViewController *owneGoods=[[OwnerOfCargoViewController alloc] init];
    [self.navigationController pushViewController: owneGoods animated:YES];
    

   

}




//-(void)clickPhoto:(UITapGestureRecognizer *)tap {
//    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选取", nil];
//    [actionSheet showInView:self.view];
//}



//
//#pragma mark- UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    if (buttonIndex == 0)
//    {
//        UIImagePickerController *pick = [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
//        pick.delegate = self;
//    }
//    
//    if (buttonIndex == 1)
//    {
//        UIImagePickerController *pick = [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        pick.delegate = self;
//    }
//}
//
//
//
//#pragma mark- 打开相机/相册
//- (UIImagePickerController *)openPhotoToViewController:(UIViewController *)viewController sourceType:(UIImagePickerControllerSourceType)sourceType;
//{
//    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
//    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.mediaTypes = mediaTypes;
//        picker.navigationBarHidden = YES;
//        picker.allowsEditing = YES;
//        picker.sourceType = sourceType;
//        [viewController presentViewController:picker animated:YES completion:^(void){}];
//        return picker;
//    }
//    else
//    {
//    
//    }
//    return nil;
//}
//
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
//    self.AdentifyFore.image=image;
//    
//
//}
//
///**
// *  切割图片
// */
//- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
//{
//    CGSize newSize;
//    if (image.size.height / image.size.width > 1){
//        newSize.height = size.height;
//        newSize.width = size.height / image.size.height * image.size.width;
//    } else if (image.size.height / image.size.width < 1){
//        newSize.height = size.width / image.size.width * image.size.height;
//        newSize.width = size.width;
//    } else {
//        newSize = size;
//    }
//    
//    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return scaledImage;
//}
//


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
