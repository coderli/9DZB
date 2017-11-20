//
//  KeyChainStore.h
//  UUIDDemo
//
//  Created by Bean on 2016/11/14.
//  Copyright © 2016年 lubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
