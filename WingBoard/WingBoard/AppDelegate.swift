//
//  AppDelegate.swift
//  MorseCode
//
//  Created by Bryan Marks 2016
//  Copyright (c) Bryan Marks 2016. All rights reserved.
//

import UIKit
import AppsFlyerTracker


//import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerTracker.shared().appleAppID = "xxxx"
        AppsFlyerTracker.shared().appsFlyerDevKey = "xxxx"
        
                
       
//
        // Override point for customization after application launch.
//        let token = "05096578a308d8c8b4e4cc92ffd949b9"
//        let mixpanel = Mixpanel.sharedInstanceWithToken(token)
//        mixpanel.track("Opened App")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppsFlyerTracker.shared().trackAppLaunch()
        AppsFlyerTracker.shared().trackEvent("Test", withValue: "test")
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: [AFEventParamCurrency : "USD",AFEventParamRevenue: 6 , AFEventParamScore: 100])
        

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

