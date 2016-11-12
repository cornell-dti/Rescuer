//
//  AppDelegate.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let data = UserDefaults(suiteName: "group.rescuer")!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
                
        if data.value(forKey: "introShown") == nil {
            window?.rootViewController = UINavigationController(rootViewController: SettingsTableViewController())
        } else {
            let tabBarController = UITabBarController()
            let home = UINavigationController(rootViewController: MainTableViewController())
            let guide = UIViewController()
            let settings = UINavigationController(rootViewController: SettingsTableViewController())
            let controllers = [home, guide, settings]
            tabBarController.viewControllers = controllers
            window?.rootViewController = tabBarController
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), tag: 1)
            guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(), tag: 2)
            settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(), tag: 3)
        }
                
        window?.makeKeyAndVisible()
        
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
    }


}

