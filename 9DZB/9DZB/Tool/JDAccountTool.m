//
//  JDAccountTool.m
//  9DZB
//
//  Created by 上海灏月 on 2017/11/20.
//  Copyright © 2017年 上海灏月. All rights reserved.
//

#import "JDAccountTool.h"
#import "JDWSTool.h"
#import "JDAccount.h"
#import "JDSendPhoneTypeParams.h"
#import "UUID.h"

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.archiver"]

@implementation JDAccountTool

// 保存
+ (void)saveAccount:(JDAccount *)account{
    
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
    
    [self ws_webSocketDidOpen];
}

#pragma mark - WS代理
+ (void)ws_webSocketDidOpen {
    if ([JDAccountTool judgeLogin]) { // 如果登录，那么连接ws
        JDWSTool *wsTool = [JDWSTool shareInstance];
        
        JDAccount *account = [JDAccountTool account];
        
        NSString *userid          = account.userid;
        NSData *data              = [userid dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64Userid    = [data base64EncodedStringWithOptions:0];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"fuserid"]          = base64Userid;
        dict[@"type"]             = @"p2pChatLogin";
        dict[@"app"]              = @"1";
        NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [wsTool ws_sendMessage:[NSData dataWithData:dictData]];
    }
    
}


// 获取账号
+ (JDAccount *)account{
    // 解档
    JDAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    
    // 判断账号是否过期
    NSDate * now = [NSDate date];
    if ([now compare:account.expires_time] == NSOrderedDescending)
    { // 过期
        [self accessTokenSuccess:^(JDAccount *account) {
            [[[self alloc] init] sendUuidAndPhoneType:account];
        } failure:nil];
        return nil;
    }
    
    if (!account)
    { // 说明没有token.这时候也需要重新请求
        [self accessTokenSuccess:^(JDAccount *account) {
            [[[self alloc] init] sendUuidAndPhoneType:account];
        } failure:nil];
        return nil;
    }
    
    if (!account.token)
    {
        [self accessTokenSuccess:^(JDAccount *account) {
            [[[self alloc] init] sendUuidAndPhoneType:account];
        } failure:nil];
        return nil;
    }
    
    return account;
}

// 获取token
+ (void)getToken
{
    [self removeAccount];
    [self accessTokenSuccess:^(JDAccount *account) {
        [[[self alloc] init] sendUuidAndPhoneType:account];
    } failure:nil];
}


// 获取当前token
+ (NSString *)getCurrentToken
{
    JDAccount *account = [self account];
    return account.token;
}
+ (void)accessTokenSuccess:(void (^)(JDAccount *))success
                   failure:(void (^)(NSError *))failure
{
    /*
    [JXHTTPTool GET:kTokenUrl
             params:nil
           progress:nil
            success:^(NSDictionary * responseObj) {
                if (success) {
                    NSInteger code = [responseObj[@"code"] integerValue];
                    if (code == 200) {
                        CJAccount *account = [CJAccount accountWithDict:responseObj[@"result"]];
                        [CJAccountTool saveAccount:account];
                        success(account); // 成功返回账号信息
                    } else {
                        success(nil); // 失败返回空
                    }
                }
            } failure:^(NSError *error) {
                
            }];
    */
}

- (void)sendUuidAndPhoneType:(JDAccount *)account{
    
    
    if (!account) return; // 没有获取到token，不需要执行以下信息
    if (!account.token) return;
    
    NSString * uuid= [UUID getUUID];
    NSString * phoneType = [UUID getPhoneType];
    
    if (!phoneType) phoneType = @"未识别的手机型号";
    JDSendPhoneTypeParams *sendParms = [[JDSendPhoneTypeParams alloc] init];
    sendParms.accesstoken = account.token;
    sendParms.smartphones = phoneType;
    sendParms.uuid = uuid;
    sendParms.equtype = @"2";
    sendParms.versionCode = kversionCodeNumber;
    
    /*
    [JXHTTPTool POST:kSendPhoneType params:sendParms.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        
        NSInteger code = [responseObj[@"code"] integerValue];
        if (code == 200) {
            NSDictionary * dict = responseObj[@"result"];
            NSMutableDictionary * countDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            countDict[@"type"] = account.type;
            countDict[@"expires"] = account.expires;
            countDict[@"token"] = account.token;
            CJAccount * account = [CJAccount accountWithDict:countDict];
            [CJAccountTool saveAccount:account];
        }
        
    } failure:^(NSError *error) {
        
    }];
     */
}


// 删除账号
+ (void)removeAccount{
    
    [self removeSocketDidOpen];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL isExist = [fileMgr fileExistsAtPath:AccountPath];
    
    if (isExist) {
        
        NSError *err;
        
        [fileMgr removeItemAtPath:AccountPath error:&err];
    }
}

#pragma mark - WS代理
+ (void)removeSocketDidOpen {
    JDWSTool *wsTool = [JDWSTool shareInstance];
    NSString *userid          = [[JDAccountTool account] userid];
    NSData *data              = [userid dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Userid    = [data base64EncodedStringWithOptions:0];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"userid"]           = base64Userid;
    dict[@"type"]             = @"unbinduid";
    dict[@"client_id"]        = wsTool.client_id;
    
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    [wsTool ws_sendMessage:[NSData dataWithData:dictData]];
}
// 判断是否登录
+ (BOOL)judgeLogin {
    JDAccount *account = [self account];
    if (!account) return NO; // 没有账号，说明是没有登录
    if (!account.token) return NO; // 没有获取token，说明没有登录
    NSInteger type = [account.type integerValue];
    if (type == 2 || type == 3) return YES; // 说明是登录状态
    return NO; // 不符合上述条件，说明是未登录状态
}

@end
