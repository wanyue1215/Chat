//
//  ViewController.m
//  Server
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"
#import "Server.h"

@implementation ViewController

- (IBAction)buttonTouched:(id)sender {
    NSLog(@"%s","---------------------");
    int i = openServer();
    printf("----------------");
    if (i!=0){
        NSLog(@"%s","开启出错！！！");
    }
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
