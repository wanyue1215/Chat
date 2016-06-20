//
//  ViewController.swift
//  test
//
//  Created by 宛越 on 16/6/20.
//  Copyright © 2016年 yuewan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func touch(sender: AnyObject) {
        
//        NSStoryboard * sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
//        MainWindowController* mainWindowCont = [sb instantiateControllerWithIdentifier:@"mainWindowController"];

        
        let sb = NSStoryboard(name: "Main", bundle: nil);
        let mainWin = sb.instantiateControllerWithIdentifier("mainWindowController") as! MainWindowController;
        
//        NSApp.
        mainWin.showWindow(nil);
        
        if mainWin.window == nil {
            print("error");
        }
        
        
        //presentViewControllerAsModalWindow(mainWin);
//        mainWin.showWindow(self);
//        mainWin.window
        //mainWin.showWindow(nil)
        //mainWin.window?.makeMainWindow()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

