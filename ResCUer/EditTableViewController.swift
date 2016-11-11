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

class EditViewController: UITableViewController {
    
    let addresses: [(name: String, content: String)] = [
        (name: "Dorm", content: "8234 Low Rise 8, Ithaca NY"),
        (name: "Home", content: "Warwick, NY")
    ]
    
    let numbers: [(name: String, content: String)] = [
        (name: "Mom", content: "111-111-1111"),
        (name: "RA", content: "222-222-2222"),
        (name: "Dcotor", content: "333-333-3333")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "introShown") == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                UIBarButtonSystemItem.done, target: self, action: #selector(dismissIntro))
        }
        
        // load core data into numbers / addresses
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "editCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Addresses" : "Contacts"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? addresses.count : numbers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "editCell")
            cell.textLabel?.text = addresses[indexPath.row].name
            cell.detailTextLabel?.text = addresses[indexPath.row].content
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "editCell")
            cell.textLabel?.text = numbers[indexPath.row].name
            cell.detailTextLabel?.text = numbers[indexPath.row].content
        }

        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // launch editing view controller
        
        let editingVC = EditingTableViewController()
        editingVC.item = indexPath.section == 0 ? addresses[indexPath.row] : numbers[indexPath.row]
        editingVC.mode = indexPath.section == 0 ? "Address" : "Number"
        editingVC.title = editingVC.item.name
        
        navigationController?.pushViewController(editingVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func dismissIntro() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabBarController = UITabBarController()
        let home = UINavigationController(rootViewController: MainTableViewController())
        let blueLight = UIViewController()
        let guide = UIViewController()
        let settings = UINavigationController(rootViewController: EditViewController())
        let controllers = [home, blueLight, guide, settings]
        tabBarController.viewControllers = controllers
        appDelegate.window?.rootViewController = tabBarController
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), tag: 1)
        blueLight.tabBarItem = UITabBarItem(title: "Blue Light", image: UIImage(), tag: 2)
        guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(), tag: 3)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(), tag: 3)
        
        let desiredViewController = UINavigationController(rootViewController: MainTableViewController())
        
        let snapshot: UIView = appDelegate.window!.snapshotView(afterScreenUpdates: true)!
        desiredViewController.view.addSubview(snapshot);
        
        UserDefaults.standard.set(true, forKey: "introShown")
        
        UIView.animate(withDuration: 0.8, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview()
        })
        
    }

}
