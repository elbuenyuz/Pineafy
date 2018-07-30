//
//  AppDelegate.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/24/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        STPPaymentConfiguration.shared().publishableKey = "pk_test_g6do5S237ekq10r65BnxO6S0"
        
        ///navigation controllers
        let navigationBarAppearace = UINavigationBar.appearance()
        let font = UIFont(name: "JosefinSlab-Bold", size: 30.0)!
        
        navigationBarAppearace.barTintColor = UIColor(red:0.40, green:0.31, blue:0.42, alpha:1.0)
        navigationBarAppearace.isTranslucent = false

        navigationBarAppearace.prefersLargeTitles = false
        
        //Get rid of black bar underneath navbar
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.setBackgroundImage(UIImage(), for: .default)
        // change navigation item title color
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: font
            ]
        
        let largeAtt = [            
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: font ??
                UIFont.systemFont(ofSize: 25)
            ]
                
        navigationBarAppearace.largeTitleTextAttributes = largeAtt
        navigationBarAppearace.titleTextAttributes = attrs
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: TabBar())
//        GADMobileAds.configure(withApplicationID: "ca-app-pub-3772088375813274~1208338343")
//
        return true
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }

}

