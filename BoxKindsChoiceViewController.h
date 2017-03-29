//
//  BoxKindsChoiceViewController.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/14.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeTextFiledBlock1)(NSString *);


@interface BoxKindsChoiceViewController : UIViewController
//{
//    ChangeTextFiledBlock _myBlock;
//}
//
//-(void)setMyBlock:(ChangeTextFiledBlock)block;
//-(ChangeTextFiledBlock)myBlock;

@property(nonatomic,copy) ChangeTextFiledBlock1 myBlock;


@end
