//
//  InterfaceUrlSetting.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/20.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#ifndef InterfaceUrlSetting_h
#define InterfaceUrlSetting_h
#import <Foundation/Foundation.h>
#import "ZGQSingleClass.h"

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

/**
 *  手机号正则
 *
 *  @param str 手机号
 *
 *  @return 是否通过正则
 */
#define MATCH_PHONE(str) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"] evaluateWithObject:str]

/**
 *  解析字典中字段对象数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_OBJECT(d , k) ([d objectForKey:k] == [NSNull null])?nil:[d objectForKey:k]

#define MAIN_STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil]

#define PZWeakSelf     __block __typeof(&*self) weakSelf = self
#define windowContentHeight ([[UIScreen mainScreen] bounds].size.height)


#define PREFIX @"http://192.168.18.65:8080/ContainerofCommunication/mobile/"

#define loginUrl @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appLogin.do"//登录
#define firstPage @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCarlist.do"//首页数据
#define adressfind @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCarSourceInfoByPlace.do"//车源大厅地址选择查询
#define verifyCode @"http://192.168.18.65:8080/ContainerofCommunication/mobile/verifyCode.do"//获取验证码
#define registUrl @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appRegister.do"//注册
#define goodsOwner @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCargoList.do"//货主界面

#define goodsOwnerIdentify @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appPublishContainerInfo.do"//发布箱源

#define adressfind1 @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCargoInfoByPlace.do"//地址选择查询货源大厅

#define boxOwner @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appContainerList.do"//箱源信息
//appCargoOwnerIdentity

#define boxOwnerFind  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appContainerListByPlace.do"///箱源地址查询
#define pulishCargoInfo @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appPublishCargoInfo.do"//发布货源


#define appCarOwnerIdentity   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCarOwnerIdentity.do"//个人车主认证

#define appCargoOwnerIdentity  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCargoOwnerIdentity.do"//个人货主认证
#define appEnterpriseCargoOwnerIdentity   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEnterpriseCargoOwnerIdentity.do"//企业货主认证


#define appCLCIdentity @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCLCIdentity.do"
#define  appGetMyInfo  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appGetMyInfo.do"
#define appEditMyImage @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMyImage.do"//个人头像上传
#define appEditMyNikeName   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMyNikeName.do"//昵称修改
#define appEditMyPhoneNum  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMyPhoneNum.do"//手机号修改


#define imagePre @"http://192.168.18.65:8080/ContainerofCommunication"
/**
 *  通用请求前缀 本地
 *
 *  @return 返回前缀
 */
#define REQUEST_IP_PREFIX   @"http://192.168.18.65:8080"




#define appEditMySex  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMySex.do"//性别修改
#define  appEditMyEmail  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMySex.do"//修改邮箱

#define appTestAccount @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appTestAccount.do"//验证账户是否存在


#define appSendCode @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appSendCode.do"//发送验证码


#define appTestCode  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appTestCode.do"//验证验证码

#define appEditMyPassword  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMyPassword.do"//修改密码

#define appGetOneTruckInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appGetOneTruckInfo.do"//车源详情

#define appGetOneCargoInfo @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appGetOneCargoInfo.do"//货源详情

#define  appGetOneContainerInfo  @"http://192.168.18.65:8080/ContainerofCommunication/appGetOneContainerInfo.do"//箱源详情

#define appComplaintInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appComplaintInfo.do"//投诉
#define appMyOwnerCarList  @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appMyOwnerCarList.do"//我的车辆


#define appAddMyOwnerCarInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appAddMyOwnerCarInfo.do"//增加车辆
#define appDeleteMyOwnerCarInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appDeleteMyOwnerCarInfo.do"//删除一条车辆

#define appEditMyOwnerCarInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appEditMyOwnerCarInfo.do"//编辑车辆
#define appPublishTruckInfo   @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appPublishTruckInfo.do"//发布车源


#define appCargoSourceOrder @"http://192.168.18.65:8080/ContainerofCommunication/mobile/appCargoSourceOrder.do"//获取订单




//
////车源详情
//科技部王世龙  16:27:21
//String tsiId = req.getParameter("tsiId");
//科技部王世龙  16:27:31
////货源详情
//科技部王世龙  16:27:39
//String csiId = req.getParameter("csiId");
//科技部王世龙  16:27:46
////箱源详情
//科技部王世龙  16:27:54
//String ctsiId = req.getParameter("ctsiId");
//科技部王世龙  16:28:34
//@RequestMapping("appTruckDetails")
//科技部王世龙  16:28:45
////货源详情
//@RequestMapping("appCargoDetails")
//科技部王世龙  16:28:55
////箱源详情
//@RequestMapping("appContainerDetails")

/**
 *  弹出一个带有代理的alertView
 *
 *  @param alertStr  内容
 *  @param alertTag  提示框tag
 *  @param cancelStr 取消按钮标题
 *
 *  @return 返回一个alertView
 */
#define AlertView_Show_FUNC(alertStr,alertTag,cancelStr) \
UIAlertView *al =[[UIAlertView alloc] initWithTitle:kStrTips_Z_Common_TipsTitle \
message:alertStr delegate:self \
cancelButtonTitle:kStrTips_Z_Common_TipsSureTitle otherButtonTitles:cancelStr, nil]; \
al.tag = alertTag; \
[al show]; \

//邮箱正则表达式
#define MATCH_EMAIL(str) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])\?\\.)+[\\w](?:[\\w-]*[\\w])?"] evaluateWithObject:str]


#define SingleDefaluts   ((ZGQSingleClass *)[ZGQSingleClass  sharedSingleClass])



#endif /* InterfaceUrlSetting_h */
