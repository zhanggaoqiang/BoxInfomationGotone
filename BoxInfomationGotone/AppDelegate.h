//
//  AppDelegate.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2016/12/30.
//  Copyright © 2016年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BMKMapManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
   // BMKMapManager* _mapManager;

}

@property (strong, nonatomic) UIWindow *window;

//当前跟视图
@property(nonatomic,strong)UITabBarController * viewC_TabBar;
/**
 *监ൢ测ൢ网ൢ络ൢ状ൢ态ൢ
 */

-(void)checkNetWorking;


@end

