//
//  ModelCarViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/16.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^carModelBlock)(NSString *str);


@interface ModelCarViewController : UIViewController

@property(nonatomic,strong)carModelBlock blcok;


@end
