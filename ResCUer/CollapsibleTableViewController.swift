//
//  CollapsibleTableViewController.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 5/30/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

//
// MARK: - Section Data Structure
//
struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    
    init(name: String, items: [String], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

//
// MARK: - View Controller
//
class CollapsibleTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    var sections = [Section]()
    //var guideSection: GuideSection!
    var value: [(name: String, values: [String])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        self.tabBarController?.tabBar.tintColor = .black
        
        for entry in value {
            let item = Section(name: entry.name, items: entry.values)
            sections.append(item)
        }
        
        /*
        if self.title == "Active Shooter"{
        sections = [
            Section(name: "Run", items: ["If there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuateIf there is an escape path, attempt to evacuate", "Evacuate whether others agree or not", "Leave your belongings behind", "Help others escape if possible", "Prevent others from entering the area", "Meet at a predetermined area, do not leave campus", "Call 911 when you are safe"]),
            Section(name: "Hide", items: ["Lock and/or blockade the door", "Silence your cell phone", "Hide behind large objects", "Remain very quiet"]),
            Section(name: "Fight", items: ["Attempt to incapacitate the shooter", "Improvise weapons", "Act with physical aggression", "Commit to your actions"]),
            Section(name: "Law Enforcement on Scene", items: ["Do exactly as the team of officers instructs", "Do not approach the officers", "Keep your hands visible, fingers spread, and empty"])
        ]
        }
        
        if self.title == "Animal Incidents"{
            sections = [
                Section(name: "Animal Inside Building", items: ["just this"]),
                Section(name: "Unable to Control Animal", items: ["iPad Pro", "iPad Air 2", "iPad mini 4", "Accessories"]),
                Section(name: "Animal Loose on Campus", items: ["iPhone 6s", "iPhone 6", "iPhone SE", "Accessories"]),
            ]
        }
 */
        
     
    }
    
}

//
// MARK: - View Controller DataSource and Delegate
//
extension CollapsibleTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.selectionStyle = .none
        cell.textLabel?.frame.size.width = cell.frame.size.width
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
//        
//        cell.frame.size.width = view.frame.size.width
//        print("label text before func call: \(cell.textLabel?.text)")
//        let secondPart = cell.textLabel?.requiredHeight()
//        return sections[(indexPath as NSIndexPath).section].collapsed! ? 0 : UITableViewAutomaticDimension
//    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}

//
// MARK: - Section Header Delegate
//
extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        
        // Adjust the height of the rows inside the section
        tableView.beginUpdates()
        for i in 0 ..< sections[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
}

extension UILabel {
    
    func requiredHeight() -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        print("label frame: \(label.frame)")
        
        return label.frame.height
    }
}
