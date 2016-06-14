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

@implementation ViewController

- (IBAction)buttonTouched:(id)sender {
    
    
    int ret = 0;
    
    ret = connect_db();
    if (ret != 0) {
        NSLog(@"%s","------------- mongoDb open fail ------------");
        return;
    }
    
    ret  = openServer();
    if (ret != 0) {
        NSLog(@"%s","------------- socketServer open fail ------------");
        return;
    }
    
    printf("----------------");
//    if (i!=0){
//        NSLog(@"%s","开启出错！！！");
//    }
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
