//
//  MainPageViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    var blueHomeButton: UIButton!
    var greenFriendButton: UIButton!
    var yellowTaxiButton: UIButton!
    var redPoliceButton: UIButton!
    var homeLabel: UILabel!
    var friendLabel: UILabel!
    var taxiLabel: UILabel!
    var policeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cornell Rescuer" // naming the navigation bar on the top
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        view.backgroundColor = UIColor.darkGray // setting the color of the main background
        
        blueHomeButton = UIButton(frame: CGRect(x: 20.0, y: 84 , width: screenWidth / 1.1 , height: (screenHeight - 64) / 5.0 ))
        //blueHomeButton.backgroundColor = UIColor.blue
        blueHomeButton.layer.cornerRadius = (40)
        blueHomeButton.setBackgroundImage(UIImage(named: "home"), for: .normal)
        blueHomeButton.addTarget(self, action: #selector(blueButtonWasPressedFunction), for: .touchUpInside)
        
        greenFriendButton = UIButton(frame: CGRect(x: 20.0, y: 234 , width: screenWidth / 1.1 , height: (screenHeight - 64) / 5.0 ))
        //greenFriendButton.backgroundColor = UIColor(red:0.43, green:0.83, blue:0.08, alpha:1.0)
        greenFriendButton.layer.cornerRadius = 40
        greenFriendButton.addTarget(self, action: #selector(greenButtonWasPressedFunction), for: .touchUpInside)
        greenFriendButton.setBackgroundImage(UIImage(named: "friend"), for: .normal)
        
        yellowTaxiButton = UIButton(frame: CGRect(x: 20.0, y: 384 , width: screenWidth / 1.1, height: (screenHeight - 64) / 5.0 ))
        //yellowTaxiButton.backgroundColor = UIColor(red:0.86, green:0.80, blue:0.01, alpha:1.0)
        yellowTaxiButton.layer.cornerRadius = 40
        yellowTaxiButton.setBackgroundImage(UIImage(named: "taxi"), for: .normal)
        yellowTaxiButton.addTarget(self, action: #selector(yellowButtonWasPressedFunction), for: .touchUpInside)
        
        redPoliceButton = UIButton(frame: CGRect(x: 20.0, y: 534 , width: screenWidth / 1.1 , height: (screenHeight - 64) / 5.0 ))
        //redPoliceButton.backgroundColor = UIColor.red
        redPoliceButton.layer.cornerRadius = 40
        redPoliceButton.setBackgroundImage(UIImage(named: "police"), for: .normal)
        redPoliceButton.addTarget(self, action: #selector(redButtonWasPressedFunction), for: .touchUpInside)
        
        
        homeLabel = UILabel(frame: CGRect(x: 140, y: 115, width: 120, height: 50))
        homeLabel.text = "Home"
        homeLabel.textColor = .white
        homeLabel.font = homeLabel.font.withSize(35)
        
        friendLabel = UILabel(frame: CGRect(x: 140, y: 265, width: 120, height: 50))
        friendLabel.text = "Friend"
        friendLabel.textColor = .white
        friendLabel.font = friendLabel.font.withSize(35)
        
        taxiLabel = UILabel(frame: CGRect(x: 150, y: 415, width: 120, height: 50))
        taxiLabel.text = "Taxi"
        taxiLabel.textColor = .white
        taxiLabel.font = taxiLabel.font.withSize(35)
        
        policeLabel = UILabel(frame: CGRect(x: 140, y: 565, width: 120, height: 50))
        policeLabel.text = "Police"
        policeLabel.textColor = .white
        policeLabel.font = policeLabel.font.withSize(35)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", style: .plain, target: self, action: #selector(changeWasTapped))
        
        //navigationItem.rightBarButtonItem?.image = UIImage(named: <#T##String#>)
        
        view.addSubview(blueHomeButton)
        view.addSubview(greenFriendButton)
        view.addSubview(yellowTaxiButton)
        view.addSubview(redPoliceButton)
        //view.addSubview(homeLabel)
        //view.addSubview(friendLabel)
        //view.addSubview(taxiLabel)
        //view.addSubview(policeLabel)
    }

    func changeWasTapped(){
        navigationController?.pushViewController(UserIsEditingDetailsViewController(), animated: true)
    }

    func redButtonWasPressedFunction()
    {
        if let phoneCallNumber = URL(string: "tel://\(255111)") {
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
    
    func yellowButtonWasPressedFunction()
    {
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
    
    func greenButtonWasPressedFunction()
    {
        if let friendsNumber = UserDefaults.standard.string(forKey: "friendsNumber"),
        let phoneCallNumber = URL(string: "tel://\(friendsNumber)"){
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
    
    func blueButtonWasPressedFunction()
    {
        if let homeAddress = UserDefaults.standard.string(forKey: "homeAddress"),
            let homeAddressString = String("http://maps.apple.com/?address=" + homeAddress + ""),
            let theHomeAddressURL = URL(string: homeAddressString)
        {
            print ("http://maps.apple.com/?address=" + homeAddress + "\"")
            if (UIApplication.shared.canOpenURL(theHomeAddressURL)) {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(theHomeAddressURL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(theHomeAddressURL)
                }
            }
        }
    }


}
