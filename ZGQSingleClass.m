//
//  ZGQSingleClass.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/1/3.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "ZGQSingleClass.h"
#define FILE_PATH(name)  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name]
//获取单例类
#define SingleDefaluts   ((ZGQSingleClass *)[ZGQSingleClass  sharedSingleClass])

//当前全局变量，单例类对象
static ZGQSingleClass *_single=NULL;
//当前用户文件名称
static NSString *const kStruserInfoPlist =@"userInfo.plist";
//当前根字段
static NSString *const kStrUserInfoRoot =@"RootUserInfo";





@implementation ZGQSingleClass
+(ZGQSingleClass *)sharedSingleClass {
    @synchronized (self) {
        if (_single==nil) {
            _single=[[super alloc] init];
          
        }
    }
    return _single;
}

+(id)alloc {
    
    @synchronized (self) {
        if (nil==_single) {
          
        }
    }
    return _single;
    
}
/*
 保存用户信息
 
 */

+(void)saveUserInfo {
    //写入路径
    NSMutableData *data=[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver  encodeObject:SingleDefaluts.obj_User forKey:kStrUserInfoRoot];
    [archiver finishEncoding];
    [data writeToFile:FILE_PATH(kStruserInfoPlist) atomically:YES];
    
    
}

/*
 获得用户信息
 */

+(void)getUserInfo
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:FILE_PATH(kStruserInfoPlist)]) {
        NSData *dta_UserInfo =[NSData dataWithContentsOfFile:FILE_PATH(kStruserInfoPlist)];
        NSKeyedUnarchiver *unarchiver =[[NSKeyedUnarchiver alloc] initForReadingWithData:dta_UserInfo];
        SingleDefaluts.obj_User=[unarchiver decodeObjectForKey:kStrUserInfoRoot];
        SingleDefaluts.bol_Login=YES;
    }
    else {
        SingleDefaluts.obj_User=[[ZGQGetUserInfo alloc] init];
        SingleDefaluts.bol_Login=NO;
        
    }
}

+(BOOL)killUserInfo {
    if ([[NSFileManager defaultManager] fileExistsAtPath:FILE_PATH(kStruserInfoPlist)] ) {
        NSError *error =nil;
        //删除文件
        BOOL isSucess =[[NSFileManager defaultManager]removeItemAtPath:FILE_PATH(kStruserInfoPlist) error:&error];
        if(isSucess){
            SingleDefaluts.bol_Login=NO;
            return YES;
        }else{
            return NO;
        }
    }else{
        SingleDefaluts.bol_Login=NO;
        return YES;
    }
}









@end
