//
//  FYNetWork.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/19.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FYTCPNetWorkFinishBlock) (NSString *result);

@interface FYTCPNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientTcpSocket;

- (void)sendRequest:(NSString *)request complete:(FYTCPNetWorkFinishBlock)block;

@end
