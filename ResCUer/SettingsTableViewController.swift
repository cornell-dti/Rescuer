//
//  SettingsTableViewController.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var address = ""
    var numbers = [(name: String, content: String)]()
    
    let data = UserDefaults(suiteName: "group.rescuer")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if data.value(forKey: "introShown") == nil {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissIntro))
            
            let message = "Thanks for downloading the app and putting your safety first! To get the most use out of the app, enter your current address and up to three important contacts."
            let alertController = UIAlertController(title: "Welcome to Rescuer!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "You got it!", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
            
        }
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "editCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ///UIApplication.shared.statusBarStyle = .default
        //self.tabBarController?.tabBar.tintColor = .black
                
        // Load saved data, if any
        if let savedAddress = data.value(forKey: "address") as? String {
            address = savedAddress
        }
        
        if data.value(forKey: "error") as? Bool == true {
             let message = "We couldn't find a valid name or phone number for this contact. Try again, or type the info in manually."
             let alertController = UIAlertController(title: "Couldn't Add Contact", message: message, preferredStyle: .alert)
             let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(action)
             present(alertController, animated: true, completion: nil)
            data.set(false, forKey: "error")
        }
        
        numbers = []
        for index in 0...2 {
            let name = data.value(forKey: "contact_\(index)_name") as? String
            let content = data.value(forKey: "contact_\(index)_content") as? String
            if name != nil && content != nil { numbers.append((name!, content!)) }
        }
        
        tableView.reloadData()
        
    }
        
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Address" : "Contacts"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 { return numbers.count + 1 < 3 ? numbers.count + 1 : 3 }
        else { return 1 }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "editCell")
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Home"
            cell.detailTextLabel?.text = address
        } else {
            if indexPath.row == numbers.count {
                cell.textLabel?.text = "Add New Contact"
                cell.detailTextLabel?.text = ""
            } else {
                cell.textLabel?.text = numbers[indexPath.row].name
                cell.detailTextLabel?.text = numbers[indexPath.row].content
            }
        }

        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let editingVC = EditTableViewController()
        if indexPath.section == 0 { editingVC.address = address }
        else {
            editingVC.item = (indexPath.row == numbers.count) ? ("Name", "Phone Number") : numbers[indexPath.row]
        }
        
        editingVC.mode = indexPath.section == 0 ? "Address" : "Contact Info"
        editingVC.title = indexPath.section == 0 ? "Home" :
            "Name" == editingVC.item.name ? "New Contact" : editingVC.item.name
        editingVC.index = indexPath.row
        
        navigationController?.pushViewController(editingVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return (indexPath.section == 1 &&
            indexPath.row != numbers.count || indexPath.section == 1 && numbers.count == 3) ? .delete : .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            numbers.remove(at: indexPath.row)
            
            for index in 0...2 {
                if indexPath.row < index {
                    data.set(data.value(forKey: "contact_\(index)_name"), forKey: "contact_\(index - 1)_name")
                    data.set(data.value(forKey: "contact_\(index)_content"), forKey: "contact_\(index - 1)_content")
                }
                if index == 2 && numbers.count == 2 {
                    data.set(nil, forKey: "contact_\(index)_name")
                    data.set(nil, forKey: "contact_\(index)_content")
                }
            }
            
            if numbers.count != 2 { tableView.deleteRows(at: [indexPath], with: .middle) }
            else { tableView.reloadData() }

        }
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    /// MARK: Intro functions
    
    func dismissIntro() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        let home = UINavigationController(rootViewController:
            HomeCollectionViewController(collectionViewLayout: appDelegate.homeFlow()))
        let map = UINavigationController(rootViewController: MapViewController())
        map.navigationItem.title = "Blue Light Map"
        let guide = UINavigationController(rootViewController: MainGuideViewController())
        guide.navigationItem.title = "Emergency Guide"
<<<<<<< HEAD
        let settings = UINavigationController(rootViewController: SettingsTableViewController())
        settings.navigationItem.title = "Settings"
        let map = UINavigationController(rootViewController: MapViewController())
        map.navigationItem.title = "Map"
        let controllers = [home, guide, settings, map]
        tabBarController.viewControllers = controllers
        appDelegate.window?.rootViewController = tabBarController
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: appDelegate.homeAsset), tag: 1)
        guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(named: appDelegate.guideAsset), tag: 2)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: appDelegate.settingsAsset), tag: 3)
        map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: appDelegate.settingsAsset), tag: 4)
=======
        let controllers = [home, map, guide]
        tabBarController.viewControllers = controllers
        appDelegate.window?.rootViewController = tabBarController
        
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
                                                 style: .plain, target: self, action: #selector(appDelegate.launchSettings))
            navController.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: true)
        }
        
        let desiredViewController = home
        
        let snapshot: UIView = appDelegate.window!.snapshotView(afterScreenUpdates: true)!
        desiredViewController.view.addSubview(snapshot);
        
        data.set(true, forKey: "introShown")
        
        UIView.animate(withDuration: 0.8, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview()
        })
        
    }

}
