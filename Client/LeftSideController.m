//
//  LeftSideController.m
//  Chat
//
//  Created by 宛越 on 16/6/18.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "LeftSideController.h"

@interface LeftSideController ()<NSTableViewDelegate,NSTableViewDataSource>
//@property (weak) IBOutlet NSScrollView *scollView;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation LeftSideController

-(void) awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
//    tableView.delegate = self;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    for (int i = 0; i<5; i++) {
        NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(10, i*40, 150, 30)];
        
        NSString *title = @"test";
        button.title = title;
        
//        [_scollView addSubview:button];
        
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 5;
};

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 60;
};
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cell = [[NSTableCellView alloc] init];
    NSButton* btn = [[NSButton alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, 100, 50))];
    btn.title = @"test";
    [cell addSubview:btn];
    return cell;
};

@end


