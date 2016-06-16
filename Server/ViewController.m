//
//  ViewController.m
//  Server
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#import "Server.h"
#import "mongoClient.h"

@interface ViewController ()

@property (weak) IBOutlet NSButton *btn;

@property (assign) BOOL ifButtonSelected;

@end

@implementation ViewController

- (IBAction)buttonTouched:(id)sender {
    
    //已经开启
    if(_ifButtonSelected) {
        freeDb();
        closeSocketSever();
        
        _ifButtonSelected = NO;
        _btn.title = @"开启服务";
        exit(0);
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int ret = 0;
        ret = connect_db();
        
        if (ret != 0) {
            NSLog(@"%s","------------- mongoDb open fail ------------");
            return;
        }
        
        ret = openServer();
        if (ret != 0) {
            NSLog(@"%s","------------- socketServer open fail ------------");
            return;
        }
        
    });
    _ifButtonSelected = YES;
    _btn.title = @"关闭服务";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
