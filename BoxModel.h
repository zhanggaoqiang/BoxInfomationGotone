//
//  BoxModel.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/22.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BoxModel : NSObject

@end


@interface BoxFirstPageModel : NSObject

@property(nonatomic,strong)NSString * createDateTime;//发布时间
@property(nonatomic,strong)NSString *tsiAccount;//创建手机号
@property(nonatomic,strong)NSString *tsiId;//发布人ID


@property(nonatomic,strong)NSString *tsiContactName;//发布人姓名
@property(nonatomic,strong)NSString *tsiTruckLength;//车的长度
@property(nonatomic,strong)NSString *tsiTruckType;//货车类型
@property(nonatomic,strong)NSString *tsiTruckVolume;//货车载重

@property(nonatomic,strong)NSString * tsiDeparturePlace;//发布货物出发地址
@property(nonatomic,strong)NSString *tsiDestination;//发布货物目的地址
@end


@interface GoodsOwnerModel : NSObject


@property(nonatomic,strong)NSString * csiContactName;//发布人姓名
@property(nonatomic,strong)NSString *index;//发布人id
@property(nonatomic,strong)NSString *csiDpCity;//出发市
@property(nonatomic,strong)NSString *csiRpCity;//目的市
@property(nonatomic,strong)NSString *csiDpDistrict;//出发所在区
@property(nonatomic,strong)NSString *csiRpDistrict;//目的地所在区

@property(nonatomic,strong)NSString * csiReceiptPlace;//出发详细地址
@property(nonatomic,strong)NSString *csiTruckType;//车的种类
@property(nonatomic,strong)NSString *csiCargoWeight;//车的载重
@property(nonatomic,strong)NSString *csiMinTruckLength;//车的最小长度
@property(nonatomic,strong)NSString *csiMaxTruckLength;//车的最大长度
@property(nonatomic,strong)NSString *csiCargoDesc;//货物诶性


@end



@interface BoxOwnerModel : NSObject
@property (strong, nonatomic) NSString *ctsiContainerType;//集装箱类型
@property (strong, nonatomic) NSString *ctsiContainerSize;//集装箱尺寸
@property (strong, nonatomic) NSString * ctsiContainerLoad;//集装箱载重
@property (strong, nonatomic) NSString *createDateTime;//发布时间

@property (strong, nonatomic) NSString *ctsiPlace;//集装箱所在地
@property(strong,nonatomic)NSString *index;//集装箱id





@end



@interface PersonCenterAvaterModel : NSObject


@property(nonatomic,strong)NSString *imageStr;


@end



@interface MyCarModel : NSObject
@property(nonatomic,strong)NSString *carNum;
@property(nonatomic,strong)NSString *carKinds;
@property(nonatomic,strong)NSString *carLoad;
@property(nonatomic,strong)NSString *carLength;


@end






