//
//  NameModifyViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock2)(NSString *str);

@interface NameModifyViewController : UIViewController
@property(nonatomic,strong)NSString *name;

@property(nonatomic,copy)myBlock2 block;


@end
