//
//  JDPrivateChatModel.h
//  jiuduzhibo
//
//  Created by 上海灏月 on 2017/6/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//  私聊模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDPrivateChatModel : NSObject

/** 协议类型->这里指点对点私聊 */
@property (nonatomic,copy) NSString * type;
/** 成功状态码 */
@property (nonatomic,copy) NSString * code;
/** 获取当前发言用户的角色 0是表示拜师 1是表示开户 */
@property (nonatomic,copy) NSString * apprenticetype;
/** 发言时间时分模式 */
@property (nonatomic,copy) NSString * timenow;
/** 发言时间详细模式 */
@property (nonatomic,copy) NSString * now_time;
/** 当前所在房间  */
@property (nonatomic,copy) NSString * roomid;
/** 发言人的马甲  */
@property (nonatomic,copy) NSString * majia;
/** 聊天信息ID */
@property (nonatomic,copy) NSString * msgid;
/** 接受信息人的昵称 */
@property (nonatomic,copy) NSString * tonickname;
/** 接受信息的用户 */
@property (nonatomic,copy) NSString * touserid;
/** 发言内容 */
@property (nonatomic,copy) NSString * content;
/** 发言人的id */
@property (nonatomic,copy) NSString * userid;
/** 聊天通道目前默认为2  */
@property (nonatomic,copy) NSString * webaddress;
/** 发言人的当时等级  */
@property (nonatomic,copy) NSString * gradeid;
/** 发言人的昵称 */
@property (nonatomic,copy) NSString * nickname;
/** 1表示当前是私聊 0或者null代表（图片和公聊）  */
@property (nonatomic,copy) NSString * istype;
/** 类型2是徒弟发送，1是老师发送 */
@property (nonatomic,copy) NSString * msgtype;
/** 头像 */
@property (nonatomic,copy) NSString * userimg;
/** 高度 */
@property (nonatomic,assign) CGFloat cellH;
/** 直播间私聊高度 */
@property (nonatomic,assign) CGFloat cellHeightPay;


/** 消息时间 */
@property (nonatomic,copy) NSString * time;


/** 消息时间 */
@property (nonatomic,copy) NSString * customTime;


@property (nonatomic,copy) NSString *createtime;

/** 当前历史消息的id */
@property (nonatomic,copy) NSString * wcmid;
/**群发的头像**/
@property (nonatomic,copy) NSString * headimage;



@end
