//
//  ZGQSingleClass.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/3.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGQGetUserInfo.h"

@interface ZGQSingleClass : NSObject


@property(nonatomic,strong)ZGQGetUserInfo *obj_User;
@property(nonatomic,assign)BOOL bol_Login;
+(ZGQSingleClass *)sharedSingleClass;




@end
