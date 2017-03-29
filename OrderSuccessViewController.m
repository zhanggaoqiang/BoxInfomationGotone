//
//  OrderSuccessViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/28.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "OrderSuccessViewController.h"
#import "MyOrderViewController.h"

@interface OrderSuccessViewController ()

@end

@implementation OrderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finishBack:(id)sender {
    MyOrderViewController *myOrder=[[MyOrderViewController alloc] init];
    
    
    [self presentViewController:myOrder animated:YES completion:nil];
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
