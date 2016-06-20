//
//  CellView.h
//  Chat
//
//  Created by 宛越 on 16/6/20.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CellView : NSTableCellView

@property (weak) IBOutlet NSImageView *headeView;
@property (weak) IBOutlet NSTextField *nameView;

@end
