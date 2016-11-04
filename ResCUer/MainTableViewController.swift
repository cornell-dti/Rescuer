//
//  MainTableViewController.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/3/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let cellData = [(title: "Home", color: UIColor.blue),
                    (title: "Friends", color: UIColor.green),
                    (title: "Taxi", color: UIColor.yellow),
                    (title: "Emergency", color: UIColor.red)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.darkGray

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height
        let navigationHeight = navigationController!.navigationBar.frame.height
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView?
        let statusBarHeight = statusBar?.frame.height
        // let spacing =
        return (height - navigationHeight - statusBarHeight!) / CGFloat(4)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell() //tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        //cell.selectionStyle = .none
        cell.setCell(data: cellData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }
        
        else if indexPath.row == 1 {
            
        }
        
        else if indexPath.row == 2 {
            if let phoneCallNumber = URL(string: "tel://\(6075888888)") {
                if (UIApplication.shared.canOpenURL(phoneCallNumber)) {
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(phoneCallNumber, options: [:], completionHandler: nil)
                    }
                    else {
                        UIApplication.shared.openURL(phoneCallNumber)
                    }
                }
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
