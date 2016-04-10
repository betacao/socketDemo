//
//  AppDelegate.h
//  SocketDemo
//
//  Created by changxicao on 16/4/10.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *pinCode;
@property (strong, nonatomic) NSString *receivedStream;
+ (AppDelegate *)appDelegate;
@end

