//
//  ViewController.m
//  SocketDemo
//
//  Created by changxicao on 16/4/10.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "ViewController.h"
#import "FYUDPNetWork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    FYUDPNetWork *udp = [FYUDPNetWork sharedNetWork];
    [udp sendMessage:@"123" type:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
