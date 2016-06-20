//
//  ViewController.m
//  Client
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#import "MainWindowController.h"

#define     LOGIN_URL         "http://www.test.com/Api/login"

//@import AFNetworking;

@interface ViewController ()<NSTextFieldDelegate>

@property (weak) IBOutlet NSImageView *headerView;
@property (weak) IBOutlet NSTextField *username;
@property (weak) IBOutlet NSSecureTextField *password;
@property (weak) IBOutlet NSButton *loginBtn;

@end


@implementation ViewController

CALayer * bglayer;

- (IBAction)login:(id)sender {
    
    if ([_username.stringValue  isEqual: @""] || [_password.stringValue isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:_username.stringValue forKey:@"uname"];
    [params setObject:_password.stringValue forKey:@"upassword"];
    
//    NSMutableURLRequest *requestSerializer = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@LOGIN_URL parameters:params error:NULL];
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    //NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = responseSerializer;
    NSURLSessionDataTask* task = [manager POST:@LOGIN_URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSNumber* status = [responseObject valueForKey:@"status"];
        if (status == [NSNumber numberWithUnsignedInt:200]) {
            
            
//            MainWindowController*mainWindowCont =  [[MainWindowController alloc] init];
            NSStoryboard * sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
            MainWindowController* mainWindowCont = [sb instantiateControllerWithIdentifier:@"mainWindowController"];
            
            
//            SplitController* con = [sb instantiateControllerWithIdentifier:@"mainController"];
//            con.view.bounds = CGRectMake(0, 0, 800, 600);
            [[NSApplication sharedApplication].keyWindow close];
            
            [NSApp runModalForWindow:mainWindowCont.window];
//            [mainWindowCont showWindow:NULL];
//            [self presentViewControllerAsModalWindow:con];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
//    
//    AFURLSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
//    manager.responseSerializer = responseSerializer;
//    
//    NSURLSessionDataTask* task = [manager dataTaskWithRequest:requestSerializer uploadProgress:NULL downloadProgress:NULL completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"出错%@",error);
//        } else {
//            NSLog(@"%@",responseObject);
//            
//            
//            
////            NSDictionary* dic = (NSDictionary*)responseObject;
////            [dic objectForKey:@"msg"];
//            NSLog(@"xx");
//            
////            [NSDictionary dictionaryWithObject:responseObject forKey:]
//            
////            NSNumber* num = [responseObject objectForKey:@"status"];
////            if (num == [NSNumber numberWithInt:200]) {
////                
////                NSStoryboard * sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
////                NSWindowController* controller = [sb instantiateControllerWithIdentifier:@"mainWindow"];
//////                [self presentViewControllerAsSheet:controller];
////                
////                //成功；
////                [NSApplication.sharedApplication addWindowsItem:controller.window title:@"window" filename:YES] ;
////            }
//        }
//    }];
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
