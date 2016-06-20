//
//  AppDelegate.swift
//  test
//
//  Created by 宛越 on 16/6/20.
//  Copyright © 2016年 yuewan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let sb = NSStoryboard(name: "Main", bundle: nil);
        let mainWin = sb.instantiateControllerWithIdentifier("mainWindowController") as! MainWindowController;
        
        //        NSApp.
        mainWin.showWindow(nil);
        
        if mainWin.window == nil {
            print("error");
        }
        
        mainWin.showWindow(self);
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

