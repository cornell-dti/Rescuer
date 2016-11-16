//
//  TableViewController.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

//
//  UserIsEditingDetailsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var address = ""
    var numbers = [(name: String, content: String)]()
    
    let data = UserDefaults(suiteName: "group.rescuer")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        if data.value(forKey: "introShown") == nil {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                UIBarButtonSystemItem.done, target: self, action: #selector(dismissIntro))
            
            let message = "Thanks for downloading the app and putting your safety first! To get the most use out of the app, enter your current address and up to three important contacts."
            let alertController = UIAlertController(title: "Welcome to Rescuer!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "You got it!", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            
        }
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "editCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, if any
        if let savedAddress = data.value(forKey: "address") as? String {
            address = savedAddress
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
        
        editingVC.mode = indexPath.section == 0 ? "Address" : "Number"
        editingVC.title = indexPath.section == 0 ? "Home" : editingVC.item.name
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

    /// MARK: Intro functions
    
    func dismissIntro() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabBarController = UITabBarController()
        let home = UINavigationController(rootViewController: MainTableViewController())
        let guide = UIViewController()
        let settings = UINavigationController(rootViewController: SettingsTableViewController())
        let controllers = [home, guide, settings]
        tabBarController.viewControllers = controllers
        appDelegate.window?.rootViewController = tabBarController
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), tag: 1)
        guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(), tag: 2)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(), tag: 3)
        
        let desiredViewController = UINavigationController(rootViewController: MainTableViewController())
        
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
