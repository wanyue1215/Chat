//
//  ViewController.m
//  Client
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#include "ChatLog.h"
#include "client.h"

@implementation ViewController
- (IBAction)btnClick:(id)sender {
    
    NSAlert* alert = [[NSAlert alloc]init];
    alert.alertStyle = NSWarningAlertStyle;
    [alert addButtonWithTitle:@"测试"];
    
    if(initSocket() ==0 ){
        NSLog(@"%@",@"连接成功");
        [self IM_LOGIN];
    }
    //CHAT_LOG(t, i, level, status, t , "x" , "xxxxxssd" );
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)IM_LOGIN
{
    sendMsg("as");
};

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}



@end
