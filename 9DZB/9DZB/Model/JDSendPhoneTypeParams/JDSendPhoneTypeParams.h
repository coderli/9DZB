//
//  JDSendPhoneTypeParams.h
//  jiuduzhibo
//
//  Created by 王加祥 on 2017/1/2.
//  Copyright © 2017年 王加祥. All rights reserved.
//  发送手机型号等参数

#import <Foundation/Foundation.h>

@interface JDSendPhoneTypeParams : NSObject
/** 手机唯一设备号 */
@property (nonatomic,copy) NSString * uuid;
/** 手机唯一设备号 */
@property (nonatomic,copy) NSString * smartphones;
/** 用户令牌 */
@property (nonatomic,copy) NSString * accesstoken;
/** 类型：1：android 2:ios */
@property (nonatomic,copy) NSString * equtype;
/** 激光识别号 */
@property (nonatomic,copy) NSString * registrationid;
/** 手机系统 */
@property (nonatomic,copy) NSString * centeros;
/** 版本号 */
@property (nonatomic,copy) NSString * versionCode;
@end
