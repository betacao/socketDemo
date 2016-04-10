//
//  FYNetWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/19.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYTCPNetWork.h"
#import "GCDAsyncSocket.h"

@interface FYTCPNetWork()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *sendTcpSocket;
@property (copy, nonatomic) FYTCPNetWorkFinishBlock finishBlock;
@end

@implementation FYTCPNetWork

+ (instancetype) shareNetEngine
{
    static FYTCPNetWork *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;
}

- (void)createClientTcpSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("client tdp socket", NULL);
    // 1. 创建一个 udp socket用来和服务端进行通讯
    self.sendTcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    // 2. 连接服务器端. 只有连接成功后才能相互通讯 如果60s连接不上就出错
    NSString *host = @"120.27.151.216";
    uint16_t port = 11104;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
    // 连接必须服务器在线
}


- (void)sendRequest:(NSString *)request complete:(FYTCPNetWorkFinishBlock)block
{
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    // 发送消息 这里不需要知道对象的ip地址和端口
    [self.sendTcpSocket writeData:data withTimeout:60 tag:0];
    self.finishBlock = block;
}

#pragma mark - 代理方法表示连接成功/失败 回调函数
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    // 等待数据来啊
    [sock readDataWithTimeout:-1 tag:0];;
}
// 如果对象关闭了 这里也会调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"连接失败 %@", err);
    // 断线重连
    NSString *host = @"120.27.151.216";
    uint16_t port = 11104;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"消息发送成功");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    __weak typeof(self) weakSelf = self;
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(weakSelf.finishBlock){
            weakSelf.finishBlock(response);
            weakSelf.finishBlock = nil;
        }
    });
    [sock readDataWithTimeout:-1 tag:0];;
}

@end
