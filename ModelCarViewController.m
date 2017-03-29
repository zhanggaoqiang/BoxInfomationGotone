//
//  ModelCarViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/16.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ModelCarViewController.h"

@interface ModelCarViewController ()
@property (strong, nonatomic) IBOutlet UILabel *modelCarLabel;
@property(strong,nonatomic)UIButton *btn;


@end

@implementation ModelCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}
- (IBAction)backBtn:(id)sender {
    
    if (self.blcok) {
        self.blcok(self.modelCarLabel.text);
        
    }else {
        NSLog(@"block为空");
    }

    
    [self.navigationController  popViewControllerAnimated:YES];
    
}
- (IBAction)modelCarChoice:(UIButton*)sender {
    self.btn.selected=!self.btn.selected;
    
    
  
    
    
    
    
    self.btn=sender;
    sender.selected=YES;
    self.modelCarLabel.text=self.btn.titleLabel.text;
    
    
    
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
