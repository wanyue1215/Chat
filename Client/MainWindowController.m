//
//  MainWindowController.m
//  Chat
//
//  Created by 宛越 on 16/6/20.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithWindowNibName:@"MainWindowController"];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
}

@end
