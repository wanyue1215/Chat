//
//  ApiUrl.m
//  Chat
//
//  Created by 宛越 on 16/7/13.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ApiUrl.h"


@implementation Urls

- (instancetype)initWithURL:(NSString*)url AndFeferer:(NSString*)referer
{
    self = [super init];
    if (self) {
        self.url = url;
        self.referer = referer;
    }
    return self;
}

@end


@implementation ApiUrl

static ApiUrl* sharedInstance;

+(instancetype)sharedManager {
    if (sharedInstance == NULL) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
};

- (instancetype)init
{
    self = [super init];
    if (self) {
        _USER_AGENT = @"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36";

        
        _GET_QR_CODE = [[Urls alloc] initWithURL:@GET_QR_CODE_URL AndFeferer:@GET_QR_CODE_REFERER];
        _VERIFY_QR_CODE = [[Urls alloc]initWithURL:@VERIFY_QR_CODE_URL AndFeferer:@VERIFY_QR_REFERER];
        _GET_PTWEBQQ = [[Urls alloc] initWithURL:@"" AndFeferer:@PTWEBQQ_REFERER];
        
        _GET_VFWEBQQ = [[Urls alloc]initWithURL:[NSString stringWithFormat:@VFWEBQQ_URL, @"",@""] AndFeferer:@VFWEBQQ_REFERER];
        _GET_UIN_AND_PSESSIONID = [[Urls alloc] initWithURL:@GET_UIN_AND_PSESSIONID_URL AndFeferer:@GET_UIN_AND_PSESSIONID_REFERER];
    }
    return self;
};

-(void) setVFWebQQUrl:(NSString* )url
{
    NSDate* date = [[NSDate alloc ]init];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSString * timestr = [NSString stringWithFormat:@"%f",time];
    timestr = [timestr substringToIndex:13];
    
    _GET_VFWEBQQ.url = [NSString stringWithFormat:@VFWEBQQ_URL, url,timestr];
};

@end
