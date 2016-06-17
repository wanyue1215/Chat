//
//  ViewController.m
//  Client
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#include "ChatLog.h"
#include "client.h"
#include "Login.h"
#import "AFNetworking.h"
#import "Lang_ZH.h"

@interface ViewController ()<NSTextFieldDelegate>

@property (weak) IBOutlet NSImageView *headerView;
@property (weak) IBOutlet NSTextField *username;
@property (weak) IBOutlet NSSecureTextField *password;
@property (weak) IBOutlet NSButton *loginBtn;

@end

#define     LOGIN_URL         "http://www.test.com/Api/login"



@implementation ViewController

CALayer * bglayer;

- (IBAction)login:(id)sender {
    
    
    if ([_username.stringValue  isEqual: @""] || [_password.stringValue isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:_username.stringValue forKey:@"uname"];
    [params setObject:_password.stringValue forKey:@"upassword"];
    
    NSMutableURLRequest *requestSerializer = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@LOGIN_URL parameters:params error:NULL];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = responseSerializer;
    
    NSURLSessionDataTask* task = [manager dataTaskWithRequest:requestSerializer uploadProgress:NULL downloadProgress:NULL completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"出错%@",error);
        } else {
            NSLog(@"%@",responseObject);
            NSNumber* num = [responseObject objectForKey:@"status"];
            if (num == [NSNumber numberWithInt:200]) {
                //成功；
                
            }
        }
    }];
    [task resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    _headerView.layer.cornerRadius = _headerView.frame.size.height/2;
    _headerView.layer.masksToBounds = true;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:NSControlTextDidChangeNotification object:_username];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:NSControlTextDidChangeNotification object:_password];
    
    
    _loginBtn.acceptsTouchEvents = NO;
}


-(void) viewDidAppear {
    _username.placeholderString = @USERNAME;
    _password.placeholderString = @PASSWORD;
    
//    bglayer = [[CALayer alloc] init];
//    bglayer.frame = CGRectMake(0, 0, _loginBtn.frame.size.width,  _loginBtn.frame.size.width);
//    bglayer.backgroundColor = [[NSColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:1] CGColor];
//    
    
    //[_loginBtn.layer addSublayer:bglayer];
    
//    CALayer* line1 = [[CALayer alloc] init];
//    
//    line1.frame = CGRectMake(20, _username.frame.origin.y + _username.frame.size.height + 1 , self.view.frame.size.width - 40 , 1);
//    line1.backgroundColor = [NSColor blackColor].CGColor;
//    
//    [self.view.layer addSublayer:line1];
//    
//    CALayer* line2 = [[CALayer alloc] init];
//    line1.frame = CGRectMake(20, _password.frame.origin.y + _password.frame.size.height + 1 , self.view.frame.size.width - 40 , 1);
//    line1.backgroundColor = [NSColor blackColor].CGColor;
//    
//    [self.view.layer addSublayer:line2];
}

-(void) textChanged
{
    NSLog(@"text changed");
}

-(void) viewDidDisappear {
    

}

- (void)IM_LOGIN
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"login" forKey:@"cmd"];
    [dic setValue:@"username" forKey:@""];
    
    NSData* data = [Common toJSONDdata:dic];
    NSString * msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    sendMsg([msg UTF8String]);
};

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
