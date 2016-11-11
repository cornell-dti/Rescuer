//
//  UserIsEditingDetailsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 10/28/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    var mode: String!
    var item: (name: String, content: String)!
    var textfield: UITextField!
    var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .darkGray
        
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0
        
        let textfieldLabel = UILabel(frame: CGRect(x: 20, y: navigationHeight + 40, width: 120, height: 50))
        textfieldLabel.text = "\(mode):"
        textfieldLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        textfieldLabel.sizeToFit()
        textfieldLabel.textColor = UIColor.white
        view.addSubview(textfieldLabel)
        
        textfield = UITextField(frame:
            CGRect(x: textfieldLabel.frame.maxX + 16, y: navigationHeight + 40, width: 250, height: 44))
        textfield.backgroundColor = UIColor.white
        textfield.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(textfield)
        
        saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50 ))
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveDismiss), for: .touchUpInside)
        saveButton.center.x = view.frame.width / 2.0
        saveButton.center.y = textfield.frame.maxY + 40
        view.addSubview(saveButton)
        
        textfield.becomeFirstResponder()
        
    }
    
    func saveDismiss() {
        if UserDefaults.standard.value(forKey: "introShown") == nil {
            initalizeMainScreen()
        } else {
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func initalizeMainScreen() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabBarController = UITabBarController()
        let home = UINavigationController(rootViewController: MainTableViewController())
        let blueLight = UIViewController()
        let guide = UIViewController()
        let settings = EditViewController()
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
