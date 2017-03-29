//
//  ReleaseViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/7.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ReleaseViewController.h"
#import "STPickerArea.h"

@interface ReleaseViewController ()<UITextFieldDelegate, STPickerAreaDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textArea;
@property (strong, nonatomic) IBOutlet UITextField *destinationarea;


@end
  BOOL flag;
@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.textArea.delegate=self;
    self.destinationarea.delegate=self;
    self.textArea.rightViewMode=UITextFieldViewModeAlways;
    self.textArea.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"出发地.PNG"]];
    
    self.destinationarea.rightViewMode=UITextFieldViewModeAlways;
    self.destinationarea.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"出发地.png"]];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textArea) {
        flag=NO;
        [self.textArea resignFirstResponder];
        
        
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];
        
    }
    
    if (textField==self.destinationarea) {
        flag=YES;
         [self.destinationarea resignFirstResponder];
        
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];

    }
    
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    if (flag==YES) {
        self.destinationarea.text=text;
    }
    else {
    self.textArea.text = text;
    }
}



- (IBAction)backbutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
