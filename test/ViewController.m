//
//  ViewController.m
//  test
//
//  Created by 宛越 on 16/6/17.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)test:(id)sender {
    //NSViewController* viewController = [[NSViewController alloc] init];
    
    NSStoryboard * sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSViewController* viewController = [sb instantiateControllerWithIdentifier:@"viewCon"];
    viewController.view.bounds = CGRectMake(0, 0, 800, 600);
    
    
//    [self presentViewControllerAsModalWindow:viewController];
    [self presentViewController:viewController asPopoverRelativeToRect:self.view.frame ofView:self.view preferredEdge:NSMinXEdge behavior:NSPopoverBehaviorApplicationDefined];

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
