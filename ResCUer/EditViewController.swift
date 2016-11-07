//
//  UserIsEditingDetailsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var homeCoordinates: String!
    var usersFriendsNumber: String!
    var addressTextField: UITextField!
    var contactNumberTextfield: UITextField!
    var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Preferences"
        
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
        updateButton.center.x = view.frame.width / 2.0
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
    
}
