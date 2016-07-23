//
//  QQLoginViewController.m
//  Chat
//
//  Created by 宛越 on 16/7/13.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "QQLoginViewController.h"

@interface QQLoginViewController ()

@property (weak) IBOutlet NSImageView *image;

//@property (strong,nonatomic)NSString *ptwebqq;
//@property (strong,nonatomic)NSString *vfwebqq;
//@property (nonatomic)long uin;
//@property (nonatomic,strong)NSString *psessionid;

@end

@implementation QQLoginViewController



long Client_ID = 53999199;
NSURLSessionConfiguration *configuration;
AFURLSessionManager *manager;

- (void)viewDidLoad {
    
    configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [super viewDidLoad];
    NSString *serializationQueueDescription = [NSString stringWithFormat:@"%@ serialization queue", self];
    NSLog(@"%@",serializationQueueDescription);
}

-(void) viewDidAppear {
    [self getQRCode];
}

-(void)getQRCode {
    CHAT_LOG(@"login".UTF8String , 0, LogLevel[1], 1, "获取二维码");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:[ApiUrl sharedManager].GET_QR_CODE.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        AFHTTPResponseSerializer* response = [[AFHTTPResponseSerializer alloc] init];
        NSSet* set = [[NSSet alloc]initWithArray:@[@"image/png"]];
        [response setAcceptableContentTypes:set];
        manager.responseSerializer = response;
        
        NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSImage* image = [[NSImage alloc] initWithData:responseObject];
            _image.image = image;
            
            [self verifyQRCode];
        }];
        [task resume];
    });
};

-(void)verifyQRCode {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:[ApiUrl sharedManager].VERIFY_QR_CODE.url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setValue:@"" forHTTPHeaderField:@"Feferer"];
        
        AFHTTPResponseSerializer* response = [[AFHTTPResponseSerializer alloc] init];
        NSSet* set = [[NSSet alloc]initWithArray:@[@"application/x-javascrip"]];
        [response setAcceptableContentTypes:set];
        manager.responseSerializer = response;
        
        NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            //登陆成功
            if ([responseString containsString:@"成功"]) {
                /*----------------   认证成功，获取地址  ------------------*/
                NSArray* array = [responseString componentsSeparatedByString:@","];
                for (int i = 0 ; i < array.count; i ++) {
                    if ([array[i] containsString:@"http://"]) {
                        NSString *url = array[i];
                        if ([url hasPrefix:@"'"]) {
                            url = [url substringFromIndex:1];
                        }
                        if ([url hasSuffix:@"'"]){
                            url = [url substringToIndex:[url length]-1];
                        }
                        NSLog(@"PTWEBQQ url为：%@----------",url);
                        [ApiUrl sharedManager].GET_PTWEBQQ.url = url;
                        break;
                    }
                }
                [self getPtwebqq];
                
            } else if ([responseString containsString:@"已失效"]){
                /*----------------   二维码失效，重新获取二维码  ------------------*/
                [self getQRCode];
            } else {
                /*----------------   其他状态，线程停顿后重新请求  ------------------*/
                [NSThread sleepForTimeInterval:1];
                [self verifyQRCode];
            }
        }];
        [task resume];
        
        
        
        
//        NSURLSession *session =[[NSURLSession alloc] init];
////        while (true) {
////            [NSThread sleepForTimeInterval: 1];
//
//        NSURL *url = [NSURL URLWithString:[ApiUrl sharedManager].VERIFY_QR_CODE.url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//        //NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
//        
//        [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//        }];
        
//            [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",str);
////                [self verifyQRCode];
//            }];
//        }
    });
};

-(void)getPtwebqq {
    if ([[ApiUrl sharedManager].GET_PTWEBQQ.url isEqualToString:@""] ){
        [self getQRCode];
        return;
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[ApiUrl sharedManager].GET_PTWEBQQ.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue: [ApiUrl sharedManager].USER_AGENT forHTTPHeaderField:@	"User-Agent"];
    
    AFHTTPResponseSerializer* response = [[AFHTTPResponseSerializer alloc] init];
    NSSet* set = [[NSSet alloc]initWithArray:@[@"text/html"]];
    [response setAcceptableContentTypes:set];
    manager.responseSerializer = response;
    
    NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self getVfwebqq];
        
    }];
    [task resume];
    
    //获取cookie 中内容；
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] getCookiesForTask:task completionHandler:^(NSArray<NSHTTPCookie *> * _Nullable cookies) {
        for (NSHTTPCookie *cookie in cookies) {
            if ([[cookie name] isEqualToString:@"ptwebqq"]) {
                self.ptwebqq = [cookie value];
                
                [task resume];
                break;
            }
        }
    }];

    };

-(void)getVfwebqq {
    NSLog(@"--------------------------------------getVfwebqq--------------------------------------------------");

    //[[[NSDate alloc] init] timeIntervalSince1970];

    NSString* str = [NSString stringWithFormat:@"%f",[[[NSDate alloc] init] timeIntervalSince1970]*1000];
    str = [str substringToIndex:13];
    [ApiUrl sharedManager].GET_VFWEBQQ.url = [NSString stringWithFormat:@VFWEBQQ_URL, self.ptwebqq , str];
    NSLog(@"vfwebqq url: %@",[ApiUrl sharedManager].GET_VFWEBQQ.url);
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    [[ApiUrl sharedManager] setVFWebQQUrl:self.ptwebqq];
    NSMutableURLRequest* request = [[[AFHTTPRequestSerializer alloc] init] requestWithMethod:@"GET" URLString:[ApiUrl sharedManager].GET_VFWEBQQ.url parameters:nil error:nil];
    [request setValue:[ApiUrl sharedManager].GET_VFWEBQQ.referer  forHTTPHeaderField:@"Referer"];
    [request setValue:[ApiUrl sharedManager].USER_AGENT  forHTTPHeaderField:@"User-Agent"];

    AFHTTPResponseSerializer* response = [[AFJSONResponseSerializer alloc] init];
    manager.responseSerializer = response;
    
//    http://s.web2.qq.com/api/getvfwebqq?ptwebqq=36221d61d573603cf0c9ab7e05a9d8fd9731cb7af0ca63e682f3b5aebd4797cd&clientid=53999199&psessionid=&t=1468474630941
//
    
    NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        [NSJSONSerialization isValidJSONObject:responseObject];
        NSData* data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        
        if (data) {
            id jobject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([jobject isKindOfClass: [NSDictionary class]]) {
                self.vfwebqq = [[jobject valueForKey:@"result"] valueForKey: @"vfwebqq"];
            }
        }
        [self postLogin];
    }];
    [task resume];
};

-(void)postLogin
{
    
    
    
    NSDictionary* rdic = @{@"ptwebqq" : self.ptwebqq ,@"clientid" : [NSNumber numberWithLong:Client_ID] , @"psessionid" : @"" ,@"status" : @"online"};
    NSData * data = [NSJSONSerialization dataWithJSONObject:rdic options:NSJSONWritingPrettyPrinted error:nil];
    if (!data) {
        return;
    }
    NSString* rstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"r": rstr};
    
    NSMutableURLRequest* request = [[[AFHTTPRequestSerializer alloc] init] requestWithMethod:@"POST" URLString:[ApiUrl sharedManager].GET_UIN_AND_PSESSIONID.url parameters:parameters error:nil];
    [request setValue:[ApiUrl sharedManager].USER_AGENT  forHTTPHeaderField:@"User-Agent"];
    [request setValue:[ApiUrl sharedManager].GET_UIN_AND_PSESSIONID.referer  forHTTPHeaderField:@"Referer"];
    
    
    AFHTTPResponseSerializer* response = [[AFHTTPResponseSerializer alloc] init];
    NSSet* set = [[NSSet alloc]initWithArray:@[@"text/html"]];
    [response setAcceptableContentTypes:set];
    manager.responseSerializer = response;
    
    NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSLog(@"---------------分割线------------");
        NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        
        //获取uid 和 psessionid
        [NSJSONSerialization isValidJSONObject:responseObject];
        NSData* data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        if (data) {
            id jobject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([jobject isKindOfClass: [NSDictionary class]]) {
                self.uin = (long)[[jobject valueForKey:@"result"] valueForKey: @"uin"];
                self.psessionid = [[jobject valueForKey:@"result"] valueForKey: @"psessionid"];
                
                [self pollMessage];
            }
        }
    }];
    [task resume];
};

/**
 *  拉去qq消息
 */
-(void) pollMessage
{
    NSLog(@"-------开始拉取消息-------------");
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSDictionary* rdic = @{@"ptwebqq" : self.ptwebqq ,@"clientid" : [NSNumber numberWithLong:Client_ID] , @"psessionid" : self.psessionid ,@"key" : @""};
    NSData * data = [NSJSONSerialization dataWithJSONObject:rdic options:NSJSONWritingPrettyPrinted error:nil];
    if (!data) {
        return;
    }
    NSString* rstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"r": rstr};
    
    NSMutableURLRequest* request = [[[AFHTTPRequestSerializer alloc] init] requestWithMethod:@"POST" URLString:[ApiUrl sharedManager].GET_UIN_AND_PSESSIONID.url parameters:parameters error:nil];
    [request setValue:[ApiUrl sharedManager].USER_AGENT  forHTTPHeaderField:@"User-Agent"];
    [request setValue:[ApiUrl sharedManager].GET_UIN_AND_PSESSIONID.referer  forHTTPHeaderField:@"Referer"];
    
    
    AFHTTPResponseSerializer* response = [[AFHTTPResponseSerializer alloc] init];
    NSSet* set = [[NSSet alloc]initWithArray:@[@"text/html"]];
    [response setAcceptableContentTypes:set];
    manager.responseSerializer = response;
    
    NSURLSessionDataTask* task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSLog(@"---------------分割线------------");
        NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        
        //获取uid 和 psessionid
        [NSJSONSerialization isValidJSONObject:responseObject];
        NSData* data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        if (data) {
            id jobject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([jobject isKindOfClass: [NSDictionary class]]) {
                self.uin = (long)[[jobject valueForKey:@"result"] valueForKey: @"uin"];
                self.psessionid = [[jobject valueForKey:@"result"] valueForKey: @"psessionid"];
                
                [self pollMessage];
            }
        }
    }];
    [task resume];

};

@end
