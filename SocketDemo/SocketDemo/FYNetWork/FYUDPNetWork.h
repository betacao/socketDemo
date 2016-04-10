//
//  FYUDPNetWork.h
//  SocketDemo
//
//  Created by changxicao on 16/4/10.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYUDPNetWork : NSObject

@property (strong, nonatomic) GCDAsyncUdpSocket *socket;
+ (instancetype)sharedNetWork;
- (NSString *)sendMessage:(NSString *)message type:(NSInteger)type;
@end
