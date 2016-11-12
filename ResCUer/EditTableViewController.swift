//
//  EditingTableViewController.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    var mode: String!
    var index: Int!
    var item: (name: String, content: String)!
    var address: String!
    let data = UserDefaults(suiteName: "group.rescuer")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "editingCell")
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "\(mode!)" : nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mode! == "Address" { return 1 }
        else { return section == 0 ? 2 : 1 }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = EditTableViewCell()
            (cell as! EditTableViewCell).mode = mode
            
            if mode! == "Number" {
                
                if item == ("Name", "Phone Number") {
                    (cell as! EditTableViewCell).textfield.placeholder =
                        (indexPath.row == 0) ? item.name: item.content
                } else {
                    (cell as! EditTableViewCell).textfield.text =
                        (indexPath.row == 0) ? item.name: item.content
                }
                
            } else {
                
                if address == "" {
                    (cell as! EditTableViewCell).textfield.placeholder = "Address"
                } else {
                    (cell as! EditTableViewCell).textfield.text = address
                }
                
            }
            
            if indexPath.row == 0 {
                //(cell as! EditTableViewCell).textfield.becomeFirstResponder()
            }
            
        }
        
        else if indexPath.section == 1 {
            cell.textLabel?.text = "Save"
            cell.textLabel?.textColor = UIColor(netHex: "0E7AFE")
            cell.textLabel?.textAlignment = .center
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Save and pop
        if indexPath.section == 1 {
            saveData()
            let _ = navigationController?.popViewController(animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func saveData() {
        if mode! == "Address" {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditTableViewCell
            if cell.textfield.text == "" {
                emptyTextfieldAlert()
            } else {
                data.set(cell.textfield.text, forKey: "address")
            }
        } else {
            let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditTableViewCell
            let numberCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! EditTableViewCell
            item = (name: nameCell.textfield.text!, content: numberCell.textfield.text!)
            if item.name == "" || item.content == "" {
                emptyTextfieldAlert()
            } else {
                data.set(nameCell.textfield.text!, forKey: "contact_\(index!)_name")
                data.set(numberCell.textfield.text!, forKey: "contact_\(index!)_content")
            }
            
        }
    }
    
    func emptyTextfieldAlert() {
        let message = "You left at lest textfield blank! Be on the safe side and please fill it in."
        let alertController = UIAlertController(title: "Hold up, Danger Danger", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Safety first!", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

}
