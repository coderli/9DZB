//
//  JDAccountTool.h
//  9DZB
//
//  Created by 上海灏月 on 2017/11/20.
//  Copyright © 2017年 上海灏月. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDAccount;
@interface JDAccountTool : NSObject

/**
 *  存储账户信息到本地
 */
+ (void) saveAccount:(JDAccount *)account;

/**
 *  获取用户账户信息
 *
 *  @return 个人账户
 */
+ (JDAccount *)account;

/**
 *  移除用户本地信息
 */
+ (void)removeAccount;

// 请求token
+ (void)getToken;

// 是否登录
+ (BOOL)judgeLogin;

// 获取token
+ (NSString *)getCurrentToken;

+ (void)accessTokenSuccess:(void (^)(JDAccount *account))success
                   failure:(void (^)(NSError * error))failure;

@end
