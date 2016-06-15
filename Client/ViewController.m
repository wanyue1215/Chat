//
//  ViewController.m
//  Client
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#include "ChatLog.h"


@implementation ViewController
- (IBAction)btnClick:(id)sender {
    
    
    const char* t = "xxxxxx";
    
    int i  =  10;
    int level = 2;
    int status = 1;
    
    NSAlert* alert = [[NSAlert alloc]init];
    alert.alertStyle = NSWarningAlertStyle;
    [alert addButtonWithTitle:@"测试"];
    
    CHAT_LOG(t, i, level, status, t , "x" , "xxxxxssd" );
}

- (void)viewDidLoad {
    [super viewDidLoad];

    const char* t = "xxxxxx";
    int i  =  10;
    int level = 2;
    int status = 1;
    
    CHAT_LOG(t, i, level, status, t , "x" , "xxxxxssd" );
    // Do any additional setup after loading the view.
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
