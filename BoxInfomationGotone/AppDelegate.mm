//
//  AppDelegate.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2016/12/30.
//  Copyright © 2016年 ZhongHao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZGQSingleClass.h"
#import "PZWelcomeViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


#define SingleDefaluts   ((ZGQSingleClass *)[ZGQSingleClass  sharedSingleClass])

#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]


#define COLOR_HEX_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface AppDelegate ()<UITabBarControllerDelegate,BMKGeneralDelegate,JPUSHRegisterDelegate>
{
    UITabBarController *viewC_TabBar;
    BOOL flag;
     BMKMapManager* _mapManager;
    
 }
@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //  NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"78cead45e0f7177975dd483e"
                          channel:@"appstore"
     
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginClick:) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:@"logout" object:nil];
    
    [self checkNetWorking];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"6f5D9Ly6oXRzntWG9y4eNy20hG4FDIG1"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
    [self changeWelcome];
    
    
    
    // Override point for customization after application launch.
    return YES;
}


-(void)changeWelcome {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kStr_FirstLocation ]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kStr_FirstLocation ];
        
        [ZGQSingleClass killUserInfo];
        self.window.rootViewController=[[PZWelcomeViewController alloc] init];
        
        
    }
    else {
    
    
    [self setWindowRootViewController];
    [self setTabBar];
    }

    
}





- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSLog(@"设备的deviceToken是%@",deviceToken);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Rxemote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    NSLog(@"通知的消息是%@",userInfo);
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
   
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   
    // Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    
//    // Required, iOS 7 Support
//    // 取得 APNs 标准信息内容
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"];                 // 推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];    // badge数量
//    NSString *sound = [aps valueForKey:@"sound"];
//    
//    // 播放的声音
//    NSLog(@"推送的内容%@",content);
//    
//    
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"];  // 服务端中Extras字段，key是自己定义的
//    NSLog(@"\nAppDelegate:\ncontent =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
//    
//
//    // Required,For systems with less than or equal to iOS6
//    [JPUSHService handleRemoteNotification:userInfo];
//}
//



/**
 *
 */
/**
 *<#注ൢ释ൢ#>
 */


/**
 *  检查网络状态
 */
-(void)checkNetWorking{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启网络监测
    [manger startMonitoring];
    PZWeakSelf;
    //网络状态变化
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                //无网状态
                [UIAlertView showSureAndCancleWithMessage:@"检测到您当前没有可用网络，是否前去设置" handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 0) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }else{
                        //网络状态界面
//                        PZCommentNetWorkingViewController * viewC_Temp = [[PZCommentNetWorkingViewController alloc] initWithNibName:@"PZCommentNetWorkingViewController" bundle:nil];
//                        //模态弹出界面
//                        [weakSelf.viewC_TabBar.selectedViewController presentViewController:viewC_Temp animated:YES completion:NULL];
                    }
                }];
            }
                break;
                
            default:
                //有网状态
                //发送通知
//                [[NSNotificationCenter defaultCenter] postNotificationName:kStr_LocationNetworking object:nil];
                break;
        }
    }];
}


-(void)setWindowRootViewController {
    UITabBarController * tabBar_VC1 = (UITabBarController *)[MAIN_STORYBOARD instantiateInitialViewController];
    self.window.rootViewController = tabBar_VC1;
    tabBar_VC1.delegate = self;
    self.viewC_TabBar = tabBar_VC1;

}
//设置底部tabbar

-(void)setTabBar {
    NSArray *arr_ImagesName =@[@"zhaohuoHight",@"zhaohuoNormal",@"zhaocheHight",@"zhaocheNormal",@"xiangyuanHight",@"xiangyuanNormal",@"personHight",@"personNormal"];
       NSArray *arr_titlesName =@[@"车主",@"货主",@"箱源",@"我的"];
    viewC_TabBar = (UITabBarController *)self.window.rootViewController;
    for (int index_Temp = 0;index_Temp < viewC_TabBar.viewControllers.count; index_Temp ++) {
        //设置图片
        UIImage * img_Nomal = [UIImage imageNamed:[arr_ImagesName objectAtIndex:2*index_Temp + 1]];
        //防止图片重绘
        [img_Nomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置图片
        UIImage * img_Hight = [UIImage imageNamed:[arr_ImagesName objectAtIndex:2*index_Temp]];
        //防止图片重绘
        [img_Hight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置每一个界面的TabBarItem
        UIViewController * viewC_Temp = [viewC_TabBar.viewControllers objectAtIndex:index_Temp];
        //设置选项样式
       UITabBarItem * tabBarItem_Temp = [[UITabBarItem alloc] initWithTitle:[arr_titlesName objectAtIndex:index_Temp] image:img_Nomal selectedImage:img_Hight];
        [tabBarItem_Temp setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_HEX_RGB(0xEC7C26), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [tabBarItem_Temp setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_HEX_RGB(0x746a67),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
     //   tabBarItem_Temp.titlePositionAdjustment = UIOffsetMake(0, -5);
        viewC_Temp.tabBarItem = tabBarItem_Temp;
    }
    
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    
    
    
    if ([tabBarController.viewControllers  indexOfObject:viewController]==3) {
        if (!SingleDefaluts.bol_Login) {
            UIViewController *vc = [MAIN_STORYBOARD  instantiateViewControllerWithIdentifier:@"Login_Nav"];
            
            
           [tabBarController.selectedViewController presentViewController:vc animated:YES completion:NULL];
            
            return NO;
        }else {
            
            return YES;
            
        }        
    }
    else {
        return YES;
    }
    
    
}


-(void)loginClick:(NSNotification *)no {
    SingleDefaluts.bol_Login=YES;
    viewC_TabBar.selectedIndex = 3;
}

-(void)logout:(NSNotification *)no {
    NSLog(@"注销成功");
    SingleDefaluts.bol_Login=NO;
   
    
    UIViewController *vc = [MAIN_STORYBOARD  instantiateViewControllerWithIdentifier:@"Login_Nav"];
    
    [viewC_TabBar.selectedViewController presentViewController:vc animated:YES completion:NULL];
    
  
        viewC_TabBar.selectedIndex=0;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    [[NSNotificationCenter  defaultCenter] postNotificationName:@"orderSuccess" object:nil];

    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            
            
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
