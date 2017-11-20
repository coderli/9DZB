//
//  JDWSTool.h
//  jiuduzhibo
//
//  Created by 上海灏月 on 2017/6/8.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDWSTool,SRWebSocket;

@protocol JDWSToolDelegate <NSObject>

@optional


/**
 ws连接成功
 */
- (void)ws_webSocketDidOpen;

/**
 ws连接成功，开始发送信息
 */
- (void)ws_webSocketDidReceiveMessage:(id)message;

/**
 ws连接失败
 */
- (void)ws_webSocketDidFailWithError:(NSError *)error;
@end

@interface JDWSTool : NSObject
/** 当前用户的id */
@property (nonatomic,copy) NSString * client_id;


@property (nonatomic,copy) NSString * hostString;

/**当前与你私聊对应的用户id*/
@property (nonatomic,copy) NSString * messageID;

@property (nonatomic,copy) NSString * messageType;


/** 连接ws地址 */
@property (nonatomic,weak) id<JDWSToolDelegate> delegate;


/**
 ws初始化连接

 @return 返回连接ws
 */
+ (instancetype)shareInstance;




/**
 ws开始发送信息

 @param data 开始发送信息
 */
- (void)ws_sendMessage:(id)data;

/**
 ws关闭
 */
- (void)ws_close;

//重连
- (void)ws_connectSocket;
@end
