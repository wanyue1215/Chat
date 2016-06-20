//
//  CellView.m
//  Chat
//
//  Created by 宛越 on 16/6/20.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "CellView.h"

@interface CellView ()


@end

@implementation CellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    _headeView.layer.cornerRadius = _headeView.frame.size.height/2;
    _headeView.layer.masksToBounds = YES;
}

@end
