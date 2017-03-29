//
//  BoxKindsChoiceViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/14.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "BoxKindsChoiceViewController.h"

@interface BoxKindsChoiceViewController ()
@property(nonatomic,strong)UIButton *btn;

@property (strong, nonatomic) IBOutlet UILabel *box_label;


@end

@implementation BoxKindsChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)boxKindsChioce:(UIButton*)sender {
    
    self.btn.selected=!self.btn.selected;

    
    
    
    if (sender.tag==1000||sender.tag==1020) {
        if (self.myBlock) {
            
            self.myBlock(_box_label.text);
        }else {
            NSLog(@"没有传入block");
            
        }

        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    self.btn=sender;
    sender.selected=YES;
    
    _box_label.text=self.btn.titleLabel.text;
        
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
