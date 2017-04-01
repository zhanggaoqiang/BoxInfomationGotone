//
//  ZGQGetUserInfo.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/3.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGQGetUserInfo : NSObject

/**
 *  用户手机号
 */
@property (nonatomic, strong) NSString     * mrAccount;//用户手机号
@property(nonatomic,strong)NSString *mrHeadImage;//用户头像
@property(nonatomic,strong)NSString *userId;//用户id

@property (nonatomic, strong) NSString    * coStatus;//个人货主认证状态

@property (nonatomic, strong) NSString    * ecoStatus;//企业货主认证状态

@property (nonatomic, strong) NSString    * clcStatus;//集装箱租赁公司主认证状态

@property (nonatomic, strong) NSString    * tkStatus;//车主身份认证






@end
