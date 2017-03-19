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
        
        UITabBar.appearance().barTintColor = UIColor(netHex: "E74E33")
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.5)], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.selected)
        
        UITabBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(netHex: "E74E33")
        UINavigationBar.appearance().tintColor = .white
                
        if data.value(forKey: "introShown") == nil {
            window?.rootViewController = UINavigationController(rootViewController: SettingsTableViewController())
            window?.rootViewController?.navigationItem.title = "Settings"
        } else {
            
            let tabBarController = UITabBarController()
            window?.rootViewController = tabBarController
            tabBarController.tabBar.tintColor = .white
            let home = UINavigationController(rootViewController:
                HomeCollectionViewController(collectionViewLayout: homeFlow()))
            let map = UINavigationController(rootViewController: MapViewController())
            map.navigationItem.title = "Blue Light Map"
            let guide = UINavigationController(rootViewController: MainGuideViewController())
            guide.navigationItem.title = "Emergency Guide"
<<<<<<< HEAD
            let settings = UINavigationController(rootViewController: SettingsTableViewController())
            settings.navigationItem.title = "Settings"
            let map = UINavigationController(rootViewController: MapViewController())
            let controllers = [home, guide, settings, map]
=======
            let controllers = [home, map, guide]
>>>>>>> 51ac28a5f6ceceb0cbba3a1756d3cb151284d9a0
            tabBarController.viewControllers = controllers
            
<<<<<<< HEAD
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: homeAsset), tag: 1)
            guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(named: guideAsset), tag: 2)
            settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: settingsAsset), tag: 3)
            map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: settingsAsset), tag: 4)
=======
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)
            map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 2)
            guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(named: "guide"), tag: 3)
>>>>>>> 51ac28a5f6ceceb0cbba3a1756d3cb151284d9a0
            
            for item in tabBarController.tabBar.items! {
                if let image = item.image {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                }
            }
            
            for navController in controllers {
                let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"),
                                                     style: .plain, target: self, action: #selector(launchSettings))
                navController.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: true)
            }
            
        }
                
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func launchSettings() {
        
        let currentVC = (window?.rootViewController as! UITabBarController).selectedViewController as! UINavigationController
        let settings = UINavigationController(rootViewController: SettingsTableViewController())
        currentVC.present(settings, animated: true) { 
            
        }
        
    }
    
    func homeFlow() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        let usableScreenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: usableScreenWidth / 2, height: usableScreenWidth / 2)
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 0
        
        let deviceHeight = UIScreen.main.bounds.height
        let navHeight = UINavigationController().navigationBar.frame.height
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let tabHeight = UITabBarController().tabBar.frame.height
        
        let visibleScreenHeight = deviceHeight - statusHeight - navHeight - tabHeight
        let insetHeight = ( (visibleScreenHeight - usableScreenWidth) / 2 ) - layout.minimumLineSpacing
        layout.headerReferenceSize = CGSize(width: 0, height: insetHeight)
        
        return layout
        
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
        var vc: HomeCollectionViewController? = nil
        if !(window!.rootViewController is UITabBarController) {
            print("caught error"); handled = false
        } else {
            
            for navController in (window!.rootViewController! as! UITabBarController).childViewControllers {
                let controller = (navController as! UINavigationController).viewControllers.first
                if controller is HomeCollectionViewController {
                    vc = controller as? HomeCollectionViewController
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

/** Create UIColors from hex values */
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: String) {
        let hex = Int(netHex, radix: 16)!
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

