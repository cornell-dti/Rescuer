//
//  UserIsEditingDetailsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class EditViewController: UIViewController {

    var homeCoordinates: String!
    var usersFriendsNumber: String!
    var addressTextField: UITextField!
    var contactNumberTextfield1: UITextField!
    var contactNumberTextfield2: UITextField!
    var contactNumberTextfield3: UITextField!
    var updateButton: UIButton!
    var pickContactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Preferences"
        
        view.backgroundColor = .darkGray
        
        let addressLabel = UILabel(frame: CGRect(x: 30, y: 80, width: 120, height: 50))
        addressLabel.text = "Address:"
        addressLabel.textColor = UIColor.white
        view.addSubview(addressLabel)
        
        let usersFriendsNumberLabel1 = UILabel(frame: CGRect(x: 30, y: 130, width: 120, height: 50))
        usersFriendsNumberLabel1.text = "Number:"
        usersFriendsNumberLabel1.textColor = UIColor.white
        view.addSubview(usersFriendsNumberLabel1)
        
        let usersFriendsNumberLabel2 = UILabel(frame: CGRect(x: 30, y: 160, width: 120, height: 50))
        usersFriendsNumberLabel2.text = "Number:"
        usersFriendsNumberLabel2.textColor = UIColor.white
        view.addSubview(usersFriendsNumberLabel2)
        
        let usersFriendsNumberLabel3 = UILabel(frame: CGRect(x: 30, y: 190, width: 120, height: 50))
        usersFriendsNumberLabel3.text = "Number:"
        usersFriendsNumberLabel3.textColor = UIColor.white
        view.addSubview(usersFriendsNumberLabel3)
        
        addressTextField = UITextField(frame: CGRect(x: 100, y: 90, width: 250, height: 30))
        addressTextField.backgroundColor = UIColor.white
        addressTextField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(addressTextField)
        
        contactNumberTextfield1 = UITextField(frame: CGRect(x: 100, y: 140, width: 250, height: 30))
        contactNumberTextfield1.backgroundColor = UIColor.white
        contactNumberTextfield1.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(contactNumberTextfield1)
        
        contactNumberTextfield2 = UITextField(frame: CGRect(x: 100, y: 170, width: 250, height: 30))
        contactNumberTextfield2.backgroundColor = UIColor.white
        contactNumberTextfield2.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(contactNumberTextfield2)
        
        contactNumberTextfield3 = UITextField(frame: CGRect(x: 100, y: 200, width: 250, height: 30))
        contactNumberTextfield3.backgroundColor = UIColor.white
        contactNumberTextfield3.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(contactNumberTextfield3)
        
        updateButton = UIButton(frame: CGRect(x: 50, y: 260, width: 200, height: 50 ))
        updateButton.setTitle("Update", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.addTarget(self, action: #selector(updateInfoFunction), for: .touchUpInside)
        updateButton.center.x = view.frame.width / 2.0
        view.addSubview(updateButton)
        
        pickContactButton = UIButton(frame: CGRect(x: 50, y: 300, width: 200, height: 50 ))
        pickContactButton.setTitle("Pick Contact", for: .normal)
        pickContactButton.setTitleColor(.white, for: .normal)
        pickContactButton.addTarget(self, action: #selector(pickContactButtonPushed), for: .touchUpInside)
        pickContactButton.center.x = view.frame.width / 2.0
        view.addSubview(pickContactButton)
        
        if let friendsNumber = UserDefaults.standard.string(forKey: "friendsNumber"){
            contactNumberTextfield1.text = friendsNumber
            
        if let friendsNumber2 = UserDefaults.standard.string(forKey: "friendsNumber2"){
            contactNumberTextfield2.text = friendsNumber2
                
        if let friendsNumber3 = UserDefaults.standard.string(forKey: "friendsNumber3"){
            contactNumberTextfield3.text = friendsNumber3
            
            
            if let homeAddress = UserDefaults.standard.string(forKey: "homeAddress"){
                addressTextField.text = homeAddress
            }
        }
    
            }}}
    
    func updateInfoFunction() {
    
        UserDefaults.standard.set(contactNumberTextfield1.text, forKey: "friendsNumber")
        UserDefaults.standard.set(contactNumberTextfield2.text, forKey: "friendsNumber2")
        UserDefaults.standard.set(contactNumberTextfield3.text, forKey: "friendsNumber3")
        UserDefaults.standard.set(addressTextField.text, forKey: "homeAddress")
        
        
        if UserDefaults.standard.value(forKey: "introShown") == nil {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let tabBarController = UITabBarController()
            let home = UINavigationController(rootViewController: MainTableViewController())
            let blueLight = UIViewController()
            let guide = UIViewController()
            let controllers = [home, blueLight, guide]
            tabBarController.viewControllers = controllers
            appDelegate.window?.rootViewController = tabBarController
            home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), tag: 1)
            blueLight.tabBarItem = UITabBarItem(title: "Blue Light", image: UIImage(), tag: 2)
            guide.tabBarItem = UITabBarItem(title: "Guide", image: UIImage(), tag: 3)
            
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
            
        } else {

            let _ = navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    func pickContactButtonPushed(){
        navigationController?.pushViewController(ContactsViewController(), animated: true)
    }
    
}
