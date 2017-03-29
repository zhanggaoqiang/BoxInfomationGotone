//
//  MyOrderViewController.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/28.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "MyOrderViewController.h"
#import "ContainerViewController.h"
#import "CancelOrderViewController.h"
#import "HadOrderSuccessViewController.h"
#import "WaitOrderViewController.h"



@interface MyOrderViewController ()

@property(nonatomic,strong)HadOrderSuccessViewController *firstVC;
@property(nonatomic,strong)WaitOrderViewController *secondVC;
@property(nonatomic,strong)CancelOrderViewController *thirdVC;


@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIScrollView *headScrollView;  //  顶部滚动视图

@property (nonatomic ,strong) NSArray *headArray;

@end

@implementation MyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:248/255.0 green:126/255.0 blue:68/255.0 alpha:1];
    
    
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"支付宝支付列表";
    
    self.headArray = @[@"已支付",@"等待支付",@"取消支付"];
    /**
     *   automaticallyAdjustsScrollViewInsets   又被这个属性坑了
     *   我"UI高级"里面一篇文章着重讲了它,大家可以去看看
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    self.headScrollView.backgroundColor = [UIColor whiteColor];
    
    self.headScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 50);
    self.headScrollView.bounces = NO;
    self.headScrollView.pagingEnabled = YES;
    [self.view addSubview:self.headScrollView];
    for (int i = 0; i < [self.headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0 + i*(self.view.frame.size.width/self.headArray.count), 0, self.view.frame.size.width/self.headArray.count, 50);
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i + 100;
      
        
        button.titleLabel.font=[UIFont systemFontOfSize:22];
        button.titleLabel.textColor=[UIColor blackColor];
        [button setTintColor:[UIColor blackColor]];
    
        
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:button];
        
    }
    
    /*
     苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
     对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
     这样做的好处：
     
     1.无疑，对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
     2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
     3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
     */
    
    /**
     *  在iOS5中，ViewController中新添加了下面几个方法：
     *  addChildViewController:
     *  removeFromParentViewController
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  willMoveToParentViewController:
     *  didMoveToParentViewController:
     */
    self.firstVC = [[HadOrderSuccessViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114)];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[WaitOrderViewController alloc] init];
    [self.secondVC.view setFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114)];

    
    self.thirdVC = [[CancelOrderViewController alloc] init];
    [self.thirdVC.view setFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114)];
    
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
    
}

- (void)didClickHeadButtonAction:(UIButton *)button
{
    //  点击处于当前页面的按钮,直接跳出
    if ((self.currentVC == self.firstVC && button.tag == 100)||(self.currentVC == self.secondVC && button.tag == 101.)||(self.currentVC == self.thirdVC && button.tag == 102)) {
        return;
    }else{
        
        //  展示2个,其余一样,自行补全噢
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 101:
                [self replaceController:self.currentVC newController:self.secondVC];
                break;
            case 102:
                [self replaceController:self.currentVC newController:self.thirdVC];

                //.......
                break;
                           //.......
            default:
                break;
        }
    }
    
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}
/**
 *  方法说明：
 *  1、addChildViewController:向父VC中添加子VC，添加之后自动调用willMoveToParentViewController:父VC
 *  2、removeFromParentViewController:将子VC从父VC中移除，移除之后自动调用
 didMoveToParentViewController:nil
 *  3、willMoveToParentViewController:  当向父VC添加子VC之后，该方法会自动调用。若要从父VC移除子VC，需要在移除之前调用该方法，传入参数nil。
 *  4、didMoveToParentViewController:  当向父VC添加子VC之后，该方法不会被自动调用，需要显示调用告诉编译器已经完成添加（事实上不调用该方法也不会有问题，不太明白）; 从父VC移除子VC之后，该方法会自动调用，传入的参数为nil,所以不需要显示调用。
 */

/**
 *  注意点：
 要想切换子视图控制器a/b,a/b必须均已添加到父视图控制器中，不然会报错
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
