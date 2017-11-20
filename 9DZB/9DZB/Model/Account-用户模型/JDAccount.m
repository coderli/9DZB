//
//  JDAccount.m
//  9DZB
//
//  Created by 上海灏月 on 2017/11/20.
//  Copyright © 2017年 上海灏月. All rights reserved.
//

#import "JDAccount.h"

@implementation JDAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict {
    JDAccount * account = [[self alloc] init];
    
    account.token      = dict[@"token"];
    account.type       = [NSString stringWithFormat:@"%@",dict[@"type"]];
    account.username   = dict[@"username"];
    account.email      = dict[@"email"];
    account.nickname   = dict[@"nickname"];
    account.headimage  = dict[@"headimage"];
    account.phone      = dict[@"phone"];
    account.sharecode  = dict[@"sharecode"];
    account.gradeid    = dict[@"gradeid"];
    account.expervalue = dict[@"expervalue"];
    account.ninemoney  = dict[@"ninemoney"];
    account.balance    = dict[@"balance"];
    account.signature  = dict[@"signature"];
    account.qq         = dict[@"qq"];
    account.weixin     = dict[@"weixin"];
    account.sina       = dict[@"sina"];
    account.roomcode   = dict[@"roomcode"];
    account.expires    = dict[@"expires"];
    account.usertype   = dict[@"usertype"];
    account.gender     = dict[@"gender"];
    account.roomid     = dict[@"roomid"];
    account.job        = dict[@"job"];
    account.emcid      = dict[@"emcid"];
    account.emcpwd     = dict[@"emcpwd"];
    account.userid     = dict[@"userid"];
    account.privatekey     = dict[@"privatekey"];
    
    // 确定账号过期时间：账号创建的时间加上有效期
    NSDate * now       = [NSDate date];
    CGFloat expires    = account.expires.doubleValue * 4 / 5;
    //    CGFloat expires = account.expires.doubleValue;
    account.expires_time = [now dateByAddingTimeInterval:expires];
    return account;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
/**
 *  当从文件中读取一个对象的时候调用
 *  在这个方法中写清楚怎么解析文件中的数据，利用key来解析数据
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.token        = [aDecoder decodeObjectForKey:@"token"];
        self.type         = [aDecoder decodeObjectForKey:@"type"];
        self.expires      = [aDecoder decodeObjectForKey:@"expires"];
        self.username     = [aDecoder decodeObjectForKey:@"username"];
        self.email        = [aDecoder decodeObjectForKey:@"email"];
        self.nickname     = [aDecoder decodeObjectForKey:@"nickname"];
        self.headimage    = [aDecoder decodeObjectForKey:@"headimage"];
        self.phone        = [aDecoder decodeObjectForKey:@"phone"];
        self.sharecode    = [aDecoder decodeObjectForKey:@"sharecode"];
        self.gradeid      = [aDecoder decodeObjectForKey:@"gradeid"];
        self.expervalue   = [aDecoder decodeObjectForKey:@"expervalue"];
        self.ninemoney    = [aDecoder decodeObjectForKey:@"ninemoney"];
        self.balance      = [aDecoder decodeObjectForKey:@"balance"];
        self.signature    = [aDecoder decodeObjectForKey:@"signature"];
        self.qq           = [aDecoder decodeObjectForKey:@"qq"];
        self.weixin       = [aDecoder decodeObjectForKey:@"weixin"];
        self.sina         = [aDecoder decodeObjectForKey:@"sina"];
        self.roomcode     = [aDecoder decodeObjectForKey:@"roomcode"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.usertype     = [aDecoder decodeObjectForKey:@"usertype"];
        self.gender       = [aDecoder decodeObjectForKey:@"gender"];
        self.roomid       = [aDecoder decodeObjectForKey:@"roomid"];
        self.job          = [aDecoder decodeObjectForKey:@"job"];
        self.emcid        = [aDecoder decodeObjectForKey:@"emcid"];
        self.emcpwd       = [aDecoder decodeObjectForKey:@"emcpwd"];
        self.userid       = [aDecoder decodeObjectForKey:@"userid"];
        self.privatekey     =[aDecoder decodeObjectForKey:@"privatekey"];
        
    }
    return self;
}


/**
 *  当将一个对象存储到文件中的时候需要调用
 *  这这个方法中写清楚要存储哪些属性，以及定义怎么存储属性，以及存储哪些属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.expires forKey:@"expires"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.headimage forKey:@"headimage"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.sharecode forKey:@"sharecode"];
    [aCoder encodeObject:self.gradeid forKey:@"gradeid"];
    [aCoder encodeObject:self.expervalue forKey:@"expervalue"];
    [aCoder encodeObject:self.ninemoney forKey:@"ninemoney"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.signature forKey:@"signature"];
    [aCoder encodeObject:self.qq forKey:@"qq"];
    [aCoder encodeObject:self.weixin forKey:@"weixin"];
    [aCoder encodeObject:self.sina forKey:@"sina"];
    [aCoder encodeObject:self.roomcode forKey:@"roomcode"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.usertype forKey:@"usertype"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.roomid forKey:@"roomid"];
    [aCoder encodeObject:self.job forKey:@"job"];
    [aCoder encodeObject:self.emcid forKey:@"emcid"];
    [aCoder encodeObject:self.emcpwd forKey:@"emcpwd"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.privatekey forKey:@"privatekey"];
    
}

@end
