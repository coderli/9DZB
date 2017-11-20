//
//  JDPrivateChatModel.m
//  jiuduzhibo
//
//  Created by 上海灏月 on 2017/6/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JDPrivateChatModel.h"

#import "JDAccountTool.h"
#import "JDAccount.h"




#define kPrivateChatIconWH 30    // 当前用户头像宽高
#define kPrivateChatMsgMargin 30 // 消息距离边缘距离
#define kPrivateChatMargin 10    // 消息之间间距
#define kPrivateChatIconToContent 15 // 同一条消息，头像到文字之间距离



@implementation JDPrivateChatModel


- (CGFloat)cellH
{
    NSInteger userid = [self.userid integerValue]; // 发送者的userid
    NSInteger localUserid = [[JDAccountTool account].userid integerValue]; // 自己的userid
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    
    CGSize size = CGSizeMake(kWidth - kPrivateChatIconWH - kPrivateChatMargin - kPrivateChatMsgMargin - kPrivateChatIconToContent - kPrivateChatIconToContent, MAXFLOAT);
    
    CGSize currentSize = [self.content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    
    float cellHeight = 0;
    
    if (userid == localUserid) { // 消息是本人
        
        CGFloat h = currentSize.height < kPrivateChatIconWH ? kPrivateChatIconWH : currentSize.height;
        
        if ([self.customTime isEqualToString:@""])
        {
            
            cellHeight = h + kPrivateChatMargin + kPrivateChatIconToContent + kPrivateChatIconToContent;
            
        }else{
            cellHeight = h + kPrivateChatMargin + kPrivateChatIconToContent + kPrivateChatIconToContent + 15;
            
        }
        
        
    } else { // 消息不是本人
        
        CGFloat h = currentSize.height < kPrivateChatIconWH ? kPrivateChatIconWH : currentSize.height;
        
        if ([self.customTime isEqualToString:@""]) {
            
            cellHeight = h + kPrivateChatMargin + kPrivateChatIconToContent + kPrivateChatIconToContent;
            
        }else{
            cellHeight = h + kPrivateChatMargin + kPrivateChatIconToContent + kPrivateChatIconToContent + 15;
            
        }
        
    }

    return cellHeight;
}


- (CGFloat)cellHeightPay
{
    NSInteger userid = [self.userid integerValue]; // 发送者的userid
    NSInteger localUserid = [[JDAccountTool account].userid integerValue]; // 自己的userid
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    
    CGSize size = CGSizeMake(kWidth - kPrivateChatIconWH - kPrivateChatMargin - kPrivateChatMsgMargin - kPrivateChatIconToContent - kPrivateChatIconToContent, MAXFLOAT);
    
    CGSize currentSize = [self.content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    
    float cellHeight = 0;
    CGFloat h = currentSize.height < kPrivateChatIconWH ? kPrivateChatIconWH : currentSize.height;

    if (userid == localUserid) { // 消息是本人
        
        cellHeight = h + kPrivateChatMargin  + kPrivateChatIconToContent+kPrivateChatIconToContent;
                    
    } else { // 消息不是本人
        
        cellHeight = h + kPrivateChatMargin + kPrivateChatIconToContent+kPrivateChatIconToContent;
            
    }
    
    return cellHeight;
}
@end
