//
//  PersonInfoViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock)(NSString *str,NSString *str2,NSString *str3,NSString *imageStr,NSString *gender);

@interface PersonInfoViewController : UIViewController
@property(nonatomic,strong)NSString *imageStr;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *sex;


@property(nonatomic,copy)myBlock block;


@end
