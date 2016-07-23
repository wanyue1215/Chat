//
//  SmartQQClient.m
//  Chat
//
//  Created by 宛越 on 7/23/16.
//  Copyright © 2016 yuewan. All rights reserved.
//

#import "SmartQQClient.h"

@interface SmartQQClient ()

@property (strong,nonatomic)NSString *ptwebqq;
@property (strong,nonatomic)NSString *vfwebqq;
@property (nonatomic)long uin;
@property (nonatomic,strong)NSString *psessionid;

@end

@implementation SmartQQClient


long Client_ID = 53999199;
NSURLSessionConfiguration *configuration;
AFURLSessionManager *manager;

- (instancetype)init
{
    self = [super init];
    if (self) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

@end
