//
//  EmergencyTableViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 11/7/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class EmergencyTableViewController: UITableViewController {

    let cellData = [(title: "Cornell Police", color: UIColor(netHex: "E51B29")),
                    (title: "Ithaca Police", color: UIColor(netHex: "E23F4A")),
                    (title: "Gannett Health", color: UIColor(netHex: "CC555D"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: { _ in
               
        })

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.darkGray
        tableView.isScrollEnabled = false
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func cellDimensions() -> (cellHeight: CGFloat, separation: CGFloat) {
        let height = view.frame.height
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabHeight = tabBarController?.tabBar.frame.height ?? 0
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView?
        let statusBarHeight = statusBar?.frame.height ?? 0
        
        
        let viewableSpace = height - navigationHeight - tabHeight - statusBarHeight
        let totalCellHeight = viewableSpace / CGFloat(3)
        
        let buttonHeight = totalCellHeight * 0.6
        let totalSeparation = viewableSpace - (buttonHeight * 3)
        let separation = totalSeparation / 10.0
        
        return (totalCellHeight, separation)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellDimensions().cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell() //tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        cell.cellDimensions = cellDimensions()
        cell.setCell(data: cellData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            confirmationThenCall(number: "607251111")
        }
        
        else if indexPath.row == 1 {
           confirmationThenCall(number: "911")
        }
            
        else if indexPath.row == 2 {
            confirmationThenCall(number: "6072555155")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /// Attempts to call phone number, fires callError if there is a failure
    func call(number: String) {
        if let phoneCallNumber = URL(string: "tel://\(number)") {
            if UIApplication.shared.canOpenURL(phoneCallNumber) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(phoneCallNumber, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(phoneCallNumber)
                }
            } else { callError(number) }
        } else { callError(number) }
    }
    
    /// Presents a UIAlert in the MainTableView Controller informing users of the invalid phone number
    func callError(_ number: String) {
        let message = "\(number) isn't a valid phone number. Please make sure you entered a valid phone number."
        let alertController = UIAlertController(title: "Invalid Phone Number", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func callError2(_ address: String) {
        let message = "\(address) isn't a valid home address. Please make sure you entered a valid address."
        let alertController = UIAlertController(title: "Invalid Home Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func confirmationThenCall(number: String) {
        let message = "Are you sure that you want to call " + (number) + "?"
        let alertController = UIAlertController(title: "Confirm Call", message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.call(number: number)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

