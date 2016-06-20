//
//  SpliteController.m
//  Chat
//
//  Created by 宛越 on 16/6/18.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "SplitController.h"
#import <ContactsUI/ContactsUI.h>

@interface SplitController ()<NSSplitViewDelegate>

@end

@implementation SplitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title = @"test";
    self.view.frame = CGRectMake(0, 0, 800, 600);
    
    self.splitView.delegate = self;
}


- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview
{
    [super splitView:splitView canCollapseSubview:subview];
    return NO;
};
@end
