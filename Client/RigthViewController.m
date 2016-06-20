//
//  RigthViewController.m
//  Chat
//
//  Created by 宛越 on 16/6/18.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "RigthViewController.h"

@interface RigthViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@end

@implementation RigthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 600, 600);

}

-(void)viewDidAppear {
    
    self.headerView.layer.borderWidth = 1;
    self.headerView.layer.borderColor = [NSColor lightGrayColor].CGColor;

}




@end
