//
//  EmailModifyViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^emailBlock)(NSString *emailStr);


@interface EmailModifyViewController : UIViewController
@property(nonatomic,strong)NSString *emailText;
@property(nonatomic,copy)emailBlock emailBlock;


@end
