//
//  AppDelegate.swift
//  AlumniAppSwift
//
//  Created by Amanda Cohoon on 2015-07-20.
//  Copyright (c) 2015 Amanda Cohoon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Defining colours
    let darkBlueColor = UIColor(red:0.0, green:66/255, blue:129/255, alpha:1.0)
    let lightBlueColor = UIColor(red:120/255, green:206/255, blue:214/255, alpha:1.0)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setting the app's tint and tab bar colour
        self.window!.tintColor = lightBlueColor;
        UITabBar.appearance().backgroundColor = lightBlueColor;
        
        UINavigationBar.appearance().barTintColor = lightBlueColor // Nav bar background color
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent // Status bar text color
        
        /* creates bar for the status bar background */
        var addStatusBar = UIView()
        addStatusBar.frame = CGRectMake(0, 0, 1024, 20); // dimentions of the bar
        //addStatusBar.frame = CGRectMake(0, 0, UIScreen.mainScreen().nativeBounds.width, 20);
        addStatusBar.backgroundColor = lightBlueColor //background color
        self.window?.rootViewController?.view .addSubview(addStatusBar) // at the bar to the view
        /* end status bar background */
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

