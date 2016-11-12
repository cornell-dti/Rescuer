//
//  MainTableViewController.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/3/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainTableViewController: UITableViewController {
    
    let cellData = [(title: "Home", color: UIColor(netHex: "2474CC")),
                     (title: "Friends", color: UIColor(netHex: "6CB95B")),
                    (title: "Taxi", color: UIColor(netHex: "F9B604")),
                    (title: "Emergency", color: UIColor(netHex: "E62424"))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.darkGray
        tableView.isScrollEnabled = false
        title = "Cornell Rescuer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonSystemItem.edit, target: self, action: #selector(editTapped))

        UIView.animate(withDuration: 0.8, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: { _ in
                
        })

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func cellDimensions() -> (cellHeight: CGFloat, separation: CGFloat) {
        let height = view.frame.height
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabHeight = tabBarController?.tabBar.frame.height ?? 0
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView?
        let statusBarHeight = statusBar?.frame.height ?? 0
        
        /*
         
         There are 5 "spaces" between all the buttons
            1) Navigation Controller Bottom to First Button
            2) First Button to Second Button
            ...
            5) Last Button to Tab Controller Top
         Each cell has two borders, top and bottom, so one of those is
         the available space divided by 5 spaces, divided again in half
         
         */
        
        let viewableSpace = height - navigationHeight - tabHeight - statusBarHeight
        let totalCellHeight = viewableSpace / CGFloat(4)
        
        let buttonHeight = totalCellHeight * 0.8
        let totalSeparation = viewableSpace - (buttonHeight * 4)
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
        
            let address = UserDefaults.standard.string(forKey: "homeAddress")
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
                if (error) != nil {
                    self.addressError(address!)
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
                    mapItem.name = address
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
                }
            })
            
        }
        
        //  Friend Options Pop Up
        else if indexPath.row == 1 {
            navigationController?.pushViewController(FriendsTableViewController(), animated: true)
        }
        
        // Call Taxi
        else if indexPath.row == 2 { confirmationThenCall(number: "6075888888") }
        
        else if indexPath.row == 3 {
            navigationController?.pushViewController(EmergencyTableViewController(), animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// Show settings page
    func editTapped(){
        navigationController?.pushViewController(EditViewController(), animated: true)
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
        let message = number == "" ? "You have not entered a valid phone number. " : "The phone number \(number) is not valid. "
        let alertController = UIAlertController(title: "Invalid Phone Number", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in }
            alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addressError(_ address: String) {
        let message = address == "" ? "You have not entered a valid home address." : "The address \(address) is not valid. "
        let alertController = UIAlertController(title: "Invalid Home Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func confirmationThenCall(number: String) {
        let message = "Are you sure that you want to call " + (number) + "?"
        let alertController = UIAlertController(title: "Confirm Call", message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in self.call(number: number)
        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
