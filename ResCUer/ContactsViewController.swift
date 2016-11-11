//
//  ContactsViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit
import ContactsUI

class ContactsViewController: UIViewController, CNContactPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
        
        
    }

    private func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]){
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value 
                print("number is = \(phoneNumber)")
            }
        }
    }
    
    private func contactPickerDidCancel(picker: CNContactPickerViewController){
        navigationController?.pushViewController(EditViewController(), animated: true)
    }


}
