//
//  AppDelegate.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

/// Saved shortcut item used as a result of an app launch, used later when app is activated.
var launchedShortcutItem: UIApplicationShortcutItem?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum ShortcutIdentifier: String {
        case Home
        case Friends
        case Taxi
        case Emergency
        
        // MARK: Initializers
        
        init?(fullIdentifier: String) {
            guard let shortIdentifier = fullIdentifier.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: shortIdentifier)
        }
        
        // MARK: Properties
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }

    var window: UIWindow?
    let data = UserDefaults(suiteName: "group.rescuer")!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
        }
        
        window = UIWindow()
                
        if data.value(forKey: "introShown") == nil {
            window?.rootViewController = UINavigationController(rootViewController: SettingsTableViewController())
            window?.rootViewController?.navigationItem.title = "Settings"
        } else {
            let tabBarController = UITabBarController()

            let home = UINavigationController(rootViewController: MainTableViewController())
            let guide = UINavigationController(rootViewController: MainGuideViewController())
            guide.navigationItem.title = "Emergency Guide"
            let settings = UINavigationController(rootViewController: SettingsTableViewController())
            settings.navigationItem.title = "Settings"
            let controllers = [home, guide, settings]
            tabBarController.viewControllers = controllers
            window?.rootViewController = tabBarController
            
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)
            guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(named: "guide"), tag: 2)
            settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 3)
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
        
        guard let shortcut = launchedShortcutItem else { return }
        let _ = handleShortCutItem(shortcut)
        launchedShortcutItem = nil
        
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullIdentifier: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: MainTableViewController? = nil
        if !(window!.rootViewController is UITabBarController) {
            print("caught error"); handled = false
        } else {
            
            for navController in (window!.rootViewController! as! UITabBarController).childViewControllers {
                let controller = (navController as! UINavigationController).viewControllers.first
                if controller is MainTableViewController {
                    vc = controller as? MainTableViewController
                }
            }
            
            switch (shortCutType) {
            case ShortcutIdentifier.Home.type:
                vc?.zeroSelected(); handled = true; break
            case ShortcutIdentifier.Friends.type:
                vc?.oneSelected(); handled = true; break
            case ShortcutIdentifier.Taxi.type:
                vc?.twoSelected(); handled = true; break
            case ShortcutIdentifier.Emergency.type:
                vc?.threeSelected(); handled = true; break
            default: break
            }
            
        }

        return handled
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

