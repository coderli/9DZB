//
//  JDWSTool.m
//  jiuduzhibo
//
//  Created by 上海灏月 on 2017/6/8.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JDWSTool.h"
#import "SRWebSocket.h"               // ws三方库
//#import "JDNewMessageChatParams.h"
#import <MJExtension/MJExtension.h>

#import "JDPrivateChatModel.h"
#import "JDAccountTool.h"
#import "JDAccount.h"
#import <AudioToolbox/AudioServices.h>

#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface JDWSTool ()<SRWebSocketDelegate>

/** facebook聊天 */
@property (nonatomic,strong) SRWebSocket * webSocket;
/** 重连次数 */
@property (nonatomic,assign) NSInteger reConnectCount;

@end

@implementation JDWSTool

+ (instancetype)shareInstance {
    
    static JDWSTool *wsTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wsTool = [[JDWSTool alloc] init];
    });
    
    return wsTool;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化重连次数为0
        self.reConnectCount = 1;
        
        [self ws_connectSocket];
    }
    return self;
}


#pragma mark - socket连接
// 连接
- (void)ws_connectSocket {
    
    [self ws_close];
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WS_IP]] protocols:@[@"chat",@"superchat"]];
    
    self.webSocket.delegate = self;
    
    [self.webSocket open];
    
}

// 关闭
- (void)ws_close {
    
    self.webSocket.delegate = nil;
    
    [self.webSocket close];
}
// 发送信息
- (void)ws_sendMessage:(id)data {
    [self.webSocket send:data];
}

#pragma mark WebSocket代理方法
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ws_webSocketDidOpen)]) {
        [self.delegate ws_webSocketDidOpen];
    }
    
    if ([JDAccountTool judgeLogin]) { // 如果登录，那么连接ws
        JDAccount *account = [JDAccountTool account];
        //主播去除私信功能
        if ([account.usertype isEqualToString:@"1"]) {
        JDWSTool *wsTool = [JDWSTool shareInstance];
        NSString *userid          = [JDAccountTool account].userid;
        NSData *data              = [userid dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64Userid    = [data base64EncodedStringWithOptions:0];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"fuserid"]          = base64Userid;
        dict[@"type"]             = @"p2pChatLogin";
        dict[@"app"]              = @"1";
//        dict[@"accesstoken"]              =  account.token;
        NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [wsTool ws_sendMessage:[NSData dataWithData:dictData]];
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData * data     = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString * type   = dic[@"type"];
    if ([type isEqualToString:@"ping"]) {
        NSDictionary *dict=@{@"type":@"ping"};

        NSData *pingData=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        if (self.webSocket.readyState == SR_OPEN) {
            
            [self.webSocket send:[NSData dataWithData:pingData]];
        }
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ws_webSocketDidReceiveMessage:)]) {
            [self.delegate ws_webSocketDidReceiveMessage:message];
        }
    }
    if ([type isEqualToString:@"p2pchat"]){
        if ([JDAccountTool judgeLogin]) {
            JDPrivateChatModel *model = [JDPrivateChatModel mj_objectWithKeyValues:dic];
            JDAccount *account = [JDAccountTool account];

        if (self.messageID == nil || [self.messageID isEqualToString:@""]) {
            
            if ([account.userid isEqualToString:model.touserid]) {
                
                AudioServicesPlaySystemSound(1007);
            }
        }else{
            
            if ([self.messageType isEqualToString:@""] || self.messageType == nil) {
                
                if ([self.messageID isEqualToString:model.touserid] ||[account.userid isEqualToString:model.touserid]) {
                    
                    NSLog(@"正在与当前id私聊无需提示声音");
                    
                }else{
                    AudioServicesPlaySystemSound(1007);
                    
                }
 
            }else if ([self.messageType isEqualToString:@"payType"]){
                
                if ([self.messageID isEqualToString:model.userid]) {
                    
                    NSLog(@"正在与当前id私聊无需提示声音");
                    
                }else{
                    if ([account.userid isEqualToString:model.touserid]) {
                        
                        AudioServicesPlaySystemSound(1007);

                    }
                }

            }
            

        }
        }

        
        
    }else if ([type isEqualToString:@"groupChat"]){
        if (self.messageID == nil || [self.messageID isEqualToString:@""]) {

        AudioServicesPlaySystemSound(1007);
            
        }
    }

}



- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    JDLog(@"连接断开，清空socket对象，清空该清空的东西，还有关闭心跳！");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self netWork];
    });
    
}


-(void)netWork
{
    
    WeakSelf(ws);
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == 0)
        {
            //无网络
            return;
        }
        
        else if (status == 1)
        {
            [ws ws_connectSocket];
        }
        
        else if (status == 2)
        {
            [ws ws_connectSocket];
        }
        else
        {
            
        }
    }];
}



- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self netWork];
    });

    
}


@end
