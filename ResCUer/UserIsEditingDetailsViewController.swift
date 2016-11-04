//
//  UserIsEditingDetailsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class UserIsEditingDetailsViewController: UIViewController {

    var homeCoordinates: String!
    var usersFriendsNumber: String!
    var addressTextField: UITextField!
    var contactNumberTextfield: UITextField!
    var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Address and Friend's Number"
        
        view.backgroundColor = .darkGray
        
        let addressLabel = UILabel(frame: CGRect(x: 30, y: 80, width: 120, height: 50))
        addressLabel.text = "Address:"
        addressLabel.textColor = UIColor.white
        view.addSubview(addressLabel)
        
        let usersFriendsNumberLabel = UILabel(frame: CGRect(x: 30, y: 130, width: 120, height: 50))
        usersFriendsNumberLabel.text = "Number:"
        usersFriendsNumberLabel.textColor = UIColor.white
        view.addSubview(usersFriendsNumberLabel)
        
        addressTextField = UITextField(frame: CGRect(x: 100, y: 90, width: 250, height: 30))
        addressTextField.backgroundColor = UIColor.white
        addressTextField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(addressTextField)
        
        contactNumberTextfield = UITextField(frame: CGRect(x: 100, y: 140, width: 250, height: 30))
        contactNumberTextfield.backgroundColor = UIColor.white
        contactNumberTextfield.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(contactNumberTextfield)
        
        updateButton = UIButton(frame: CGRect(x: 50, y: 200, width: 200, height: 50 ))
        updateButton.setTitle("Update", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.addTarget(self, action: #selector(updateInfoFunction), for: .touchUpInside)
        view.addSubview(updateButton)
        
        if let friendsNumber = UserDefaults.standard.string(forKey: "friendsNumber"){
            contactNumberTextfield.text = friendsNumber
            
            if let homeAddress = UserDefaults.standard.string(forKey: "homeAddress"){
                addressTextField.text = homeAddress
            }
        }
    
    }
    
    func updateInfoFunction() {
        UserDefaults.standard.set(contactNumberTextfield.text, forKey: "friendsNumber")
        UserDefaults.standard.set(addressTextField.text, forKey: "homeAddress")
    }
    
}
