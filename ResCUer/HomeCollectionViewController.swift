//
//  HomeCollectionViewController.swift
//  Rescuer
//
//  Created by Matthew Barker on 3/18/17.
//  Copyright © 2017 Cornell SA Tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

private let reuseIdentifier = "cell"
let data = UserDefaults(suiteName: "group.rescuer")!

class HomeCollectionViewController: UICollectionViewController {
    
    // For one line titles, use \n to make the two line titles look nice
    let cellData = [(title: "Get Directions Home", color: UIColor(netHex: "2474CC"), image: "directions"),
                    (title: "Call Friends\n", color: UIColor(netHex: "6CB95B"), image: "friends"),
                    (title: "Call Taxi Service\n", color: UIColor(netHex: "F9B604"), image: "taxi"),
                    (title: "Emergency Services", color: UIColor(netHex: "E62424"), image: "emergency")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Cornell Rescuer"
        collectionView!.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(netHex: "E74E33")
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.setCell(data: cellData[indexPath.row])    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 { zeroSelected() } // Home
        else if indexPath.row == 1 { oneSelected() } // Friends
        else if indexPath.row == 2 { twoSelected() } // Taxi
        else if indexPath.row == 3 { threeSelected() } // Emergency
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    /// MARK: Action Functions
    
    /** Get Directions Home */
    func zeroSelected() {
        if let address = data.string(forKey: "address") {
            getDirections(forLocation: address)
        } else { addressError("") }
    }
    
    /** Call A Friend */
    func oneSelected() {
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
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /** Call A Taxi */
    func twoSelected() {
        confirmCall(number: "(607) 588-8888", recipient: "Taxi Service")
    }
    
    func threeSelected() {
        
        let subtitle = "Who do you want to call? Tap More Information to determine the best option for your emergency."
        let alertController = UIAlertController(title: "Emergency Options", message: subtitle, preferredStyle: .alert)
        
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
        
        let fourthOption = UIAlertAction(title: "More Information", style: UIAlertActionStyle.default) { action in
            let information = "A 911 Emergency situation requires an immediate police, fire, or medical response to preserve life or property, including: Assault or immediate danger of; Weapons; Crime in progress; Fire; Chemicals; Severely impaired respiratory ability; Loss of consciousness; Drowning; Serious injury or illness (e.g. heart attack, stroke)\n\nContact Cornell Police, NOT 911, to report a non-emergency on-campus incident or for information and general assistance. (e.g. minor auto accidents, crimes no longer in progress, loud parties, missing property, power outages)\n\nCayuga Medical Center is Ithaca's nearest major hospital."
            let alertController2 = UIAlertController(title: "Emergency Contact Information", message: information, preferredStyle: .alert)
            let goBack = UIAlertAction(title: "Go Back", style: UIAlertActionStyle.default) { action in
                self.threeSelected()
            }
            alertController2.addAction(goBack)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(firstOption)
        alertController.addAction(secondOption)
        alertController.addAction(thirdOption)
        alertController.addAction(fourthOption)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
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
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    /// Attempts to call phone number, fires callError if there is a failure
    func call(number: String) {
        
        let number2 = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        // this is my parsing solution, pretty optimized if you ask me
        // if user doesnt enter a valid number theres a problem (we need to check if there are letters or things other than numbers and - and () and " "
        
        
        if let phoneCallNumber = URL(string: "tel://\(number2)") {
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
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
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
