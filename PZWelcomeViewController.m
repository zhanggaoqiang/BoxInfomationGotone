//
//  PZWelcomeViewController.m
//  PZShoppingPro
/*
                    _ooOoo_
                   o8888888o
                   88" . "88
                   (| -_- |)
                   O\  =  /O
                ____/`---'\____
              .'  \\|  卍 |//  `.
             /  \\|||  :  |||//  \
            /  _||||| -:- |||||-  \
            |   | \\\  -  /// |   |
            | \_|  ''\---/''  |   |
            \  .-\__  `-`  ___/-. /
          ___`. .'  /--.--\  `. . __
       ."" '<  `.___\_<|>_/___.'  >'"".
      | | :  `- \`.;`\ _ /`;.`/ - ` : | |
      \  \ `-.   \_ __\ /__ _/   .-` /  /
 ======`-.____`-.___\_____/___.-`____.-'======
                    `=---='
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              佛祖保佑       永无BUG
 */
//  Created by 陈平喆  on 16/4/1.
//  Copyright（c）2016年 陈平喆. All rights reserved
//

#import "PZWelcomeViewController.h"
#import "AppDelegate.h"
#import  "EAIntroPage.h"
#import "EAIntroView.h"

#pragma mark- Define Type Parameter
//定义类型(Block ,Enum)


#pragma mark- Define Constant Parameter
//常量宏定义


#pragma mark- Define Constant Method
//方法宏定义


#pragma mark-
@interface PZWelcomeViewController ()<EAIntroDelegate>
{
    //私有成员变量
    
}
#pragma mark- Private Property
//私有属性区域


#pragma mark- Private Method
//私有方法区域


#pragma mark-
@end

@implementation PZWelcomeViewController

#pragma mark- System View Method
//系统界面事件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载界面布局
    [self viewSetting];
    
    //界面高度适配
    if (CGRectGetHeight([UIScreen mainScreen].bounds)<500) {
        [self flashView];
    }
}

#pragma mark- System View Composition Method
//界面布局
-(void)viewSetting{
    
    //界面布局
    UIImageView * imgV_Temp_1 = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgV_Temp_1.image = IMAGE_NAME(@"ZZ_Welcome_Image1");
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:imgV_Temp_1];
    
    UIImageView * imgV_Temp_2 = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgV_Temp_2.image = IMAGE_NAME(@"ZZ_Welcome_Image2");
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:imgV_Temp_2];
    
    UIImageView * imgV_Temp_3 = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgV_Temp_3.image = IMAGE_NAME(@"ZZ_Welcome_Image3");
    imgV_Temp_3.userInteractionEnabled = YES;
    
    PZWeakSelf;
    UIButton * btn_Temp = [UIButton button_AllocWithType:UIButtonTypeSystem basicSet:^(UIButton *btn) {
        [btn setFrame:CGRectMake(107.5f, windowContentHeight - 50.f - 34.f, 105.f, 34.f)];
        [btn setTitle:@"Let's go!" forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_HEX_RGB(0xFFFFFF) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:16.f]];
        [btn setBackgroundColor:COLOR_HEX_RGB(0xEC7C26)];
        [btn.layer setCornerRadius:3.f];
        [btn.layer setMasksToBounds:YES];
    } withControlEvents:UIControlEventTouchUpInside withClicked:^(UIButton *btn) {
        [weakSelf introDidFinish];
    }];
    [imgV_Temp_3 addSubview:btn_Temp];
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:imgV_Temp_3];

    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:[UIScreen mainScreen].bounds andPages:@[page1,page2,page3]];
    intro.backgroundColor = [UIColor whiteColor];
    intro.pageControl.hidden = YES;
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
}

#pragma mark- System View Adaptation Method
//界面适配
-(void)flashView{
    //5以下界面 修改尺寸
//    CGRect rect_Temp = CGRectZero;
    
    
}


#pragma mark- Overwrite Property
//重写属性



#pragma mark- Clicked Method
//点击事件
-(IBAction)allClickedRespond:(id)sender{
    //点击对象
    UIControl * ctrl_Temp = (UIControl *)sender;
    //区分点击事件
    switch (ctrl_Temp.tag) {
            
//        case <#constant#>:{
//            <#statements#>
//        }
//            break;
            
        default:
            break;
    }
}

#pragma mark- Function Method
//功能方法



#pragma mark- Delegate Method
- (void)introDidFinish{
    NSLog(@"introDidFinish callback");
    
    //引导结束 加载主页面
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置TabBar
    [app changeWelcome];
}


#pragma mark- System Memory Woring
//内存警告方法
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
