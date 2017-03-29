//
//  PhoneModifyViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock1)(NSString *str);

@interface PhoneModifyViewController : UIViewController
@property(nonatomic,strong)NSString *phoneStr;
@property(nonatomic,strong)myBlock1 myBlock;

@end
