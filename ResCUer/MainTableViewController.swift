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
    
    let data = UserDefaults(suiteName: "group.rescuer")!
    
    let cellData = [(title: "Home", color: UIColor(netHex: "2474CC")),
                     (title: "Friends", color: UIColor(netHex: "6CB95B")),
                    (title: "Taxi", color: UIColor(netHex: "F9B604")),
                    (title: "Emergency", color: UIColor(netHex: "E62424"))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.darkGray
        tableView.isScrollEnabled = false
        
        //let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView?
        //let statusBarHeight = statusBar?.frame.height ?? 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.barTintColor = UIColor(netHex: "E74E33")
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        title = "Cornell Rescuer"
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: { _ in
                
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        self.tabBarController?.tabBar.tintColor = .black
        //self.tabBarController?.tabBar.backgroundColor = UIColor.darkGray.withAlphaComponent(0.75)
        //self.tabBarController?.tabBar.shadowImage = UIImage()
        //self.tabBarController?.tabBar.tintColor = .white
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
        let tabHeight = tabBarController?.tabBar.frame.height ?? 0
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView?
        let statusBarHeight = statusBar?.frame.height ?? 0
        let navHeight = self.navigationController?.navigationBar.frame.height ?? 0

        let viewableSpace = height - tabHeight - statusBarHeight - navHeight
        let totalCellHeight = viewableSpace / CGFloat(4)
        
        let buttonHeight = totalCellHeight * 0.7
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
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("row selected: \(indexPath.row)")
        
        // Home
        if indexPath.row == 0 {
    
            if let address = data.string(forKey: "address") {
                getDirections(forLocation: address)
            } else { addressError("") }
            
        }
        
        // Friends
        else if indexPath.row == 1 {
            
            var accum = 0
            for index in 0...2 {
                if data.value(forKey: "contact_\(index)_content") is String {
                    accum += 1
                }
            }
            
            var alertController: UIAlertController!; var actions = [UIAlertAction]()
            if accum == 0 {
                
                alertController = UIAlertController(title: "No Friends Found", message: "Please add some friends in the settings page.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Hey, I have friends!", style: UIAlertActionStyle.cancel, handler: nil)
                actions.append(action)
                
            } else {
                
                alertController = UIAlertController(title: "Call a Friend", message: "Who do you want to call?", preferredStyle: .alert)
                
                for i in 1...accum {
                    if let number: String = data.value(forKey: "contact_\(i - 1)_content") as! String?,
                        let name: String = data.value(forKey: "contact_\(i - 1)_name") as! String? {
                        
                        let action = UIAlertAction(title: name, style: UIAlertActionStyle.default) {
                            action in self.call(number: number)
                        }
                        
                        actions.append(action)
                    }
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                actions.append(cancel)
                
            }
            
            for action in actions { alertController.addAction(action) }
            self.present(alertController, animated: true, completion: nil)
            
            /*
            
            if accum == 0 {
                
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            
            if accum == 1 {
                
                if let number1: String = data.value(forKey: "contact_\(0)_content") as! String?,
                    let name1: String = data.value(forKey: "contact_\(0)_name") as! String?
                    
                {
                let alertController = UIAlertController(title: "Call a Friend", message: "Who do you want to call?", preferredStyle: .alert)
                
                let firstOption = UIAlertAction(title: name1, style: UIAlertActionStyle.default)
                {
                    action in self.call(number: number1)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                
                alertController.addAction(firstOption)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                }
            }
            
            if accum == 2 {
                
                if let number1: String = data.value(forKey: "contact_\(0)_content") as! String?,
                    let name1: String = data.value(forKey: "contact_\(0)_name") as! String?,
                    let number2: String = data.value(forKey: "contact_\(1)_content") as! String?,
                    let name2: String = data.value(forKey: "contact_\(1)_name") as! String?
                    
                    {
                        
                    let alertController = UIAlertController(title: "Call a Friend", message: "Who do you want to call?", preferredStyle: .alert)
                    
                    let firstOption = UIAlertAction(title: name1, style: UIAlertActionStyle.default)
                    {
                        action in self.call(number: number1)
                    }
                    
                    let secondOption = UIAlertAction(title: name2, style: UIAlertActionStyle.default)
                    {
                        action in self.call(number: number2)
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alertController.addAction(firstOption)
                    alertController.addAction(secondOption)
                    alertController.addAction(cancelAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    }
                
                
            }
            
            if accum == 3 {
                
                if let number1: String = data.value(forKey: "contact_\(0)_content") as! String?,
                    let name1: String = data.value(forKey: "contact_\(0)_name") as! String?,
                    let number2: String = data.value(forKey: "contact_\(1)_content") as! String?,
                    let name2: String = data.value(forKey: "contact_\(1)_name") as! String?,
                    let number3: String = data.value(forKey: "contact_\(2)_content") as! String?,
                    let name3: String = data.value(forKey: "contact_\(2)_name") as! String?
                    
                    
                {
                    
                    
                    
                    let firstOption = UIAlertAction(title: name1, style: UIAlertActionStyle.default)
                    {
                        action in self.call(number: number1)
                    }
                    
                    let secondOption = UIAlertAction(title: name2, style: UIAlertActionStyle.default)
                    {
                        action in self.call(number: number2)
                    }
                    
                    let thirdOption = UIAlertAction(title: name3, style: UIAlertActionStyle.default)
                    {
                        action in self.call(number: number3)
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alertController.addAction(firstOption)
                    alertController.addAction(secondOption)
                    alertController.addAction(thirdOption)
                    alertController.addAction(cancelAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
             
             } */
            
        }
        
        // Taxi
        else if indexPath.row == 2 { confirmCall(number: "(607) 588-8888", recipient: "Taxi Service") }
        
        // Emergency
        else if indexPath.row == 3 {
            
            let alertController = UIAlertController(title: "Emergency Options", message: "Who do you want to call?", preferredStyle: .alert)
            
            let firstOption = UIAlertAction(title: "Cornell Police", style: UIAlertActionStyle.default)
            {
                action in self.call(number: "607-255-1111")
            }
            
            let secondOption = UIAlertAction(title: "Ithaca Police (911)", style: UIAlertActionStyle.default)
            {
                action in self.call(number: "911")
            }
            
            let thirdOption = UIAlertAction(title: "Cayuga Medical Center", style: UIAlertActionStyle.default)
            {
                action in self.call(number: "607-274-4411")
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(firstOption)
            alertController.addAction(secondOption)
            alertController.addAction(thirdOption)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Call Functions
    
    /// Presents a UIAlert where the user can confirm the call and do so
    func confirmCall(number: String, recipient: String) {
        let message = "Are you sure that you want to call \(number)?"
        let alertController = UIAlertController(title: "Call \(recipient)", message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.default) {
            action in self.call(number: number)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
    
    // MARK: Location Functions
    
    /// Opens Apple Maps with walking directions from current location to address
    func getDirections(forLocation: String) {
        CLGeocoder().geocodeAddressString(forLocation, completionHandler: {(placemarks, error) -> Void in
            if (error) != nil {
                self.addressError(forLocation)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
                mapItem.name = forLocation
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
            }
        })
    }
    
    /// Present alert for an invalid address
    func addressError(_ address: String) {
        let message = address == "" ? "You have not entered a valid home address." : "The address \(address) is not valid. "
        let alertController = UIAlertController(title: "Invalid Home Address", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(action)
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
