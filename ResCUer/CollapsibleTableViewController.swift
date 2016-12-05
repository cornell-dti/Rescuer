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
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

//
// MARK: - View Controller
//
class CollapsibleTableViewController: UITableViewController {
    
    var sections = [Section]()
    var guideSection: GuideSection!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        self.tabBarController?.tabBar.tintColor = .black
        
        self.title = guideSection.title
        
        var cellHeight = self
        
        if self.title == "Active Shooter"{
        sections = [
            Section(name: "Run", items: ["If there is an escape path, attempt to evacuate", "Evacuate whether others agree or not", "Leave your belongings behind", "Help others escape if possible", "Prevent others from entering the area", "Meet at a predetermined area, do not leave campus", "Call 911 when you are safe"]),
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
        
        cell.textLabel?.text = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.preferredMaxLayoutWidth = CGFloat(1.0)
        let lines = cell.textLabel?.numberOfLines
        print (lines)
        var cellHeight = Double(lines!) * 8.0
        
        return sections[(indexPath as NSIndexPath).section].collapsed! ? 0 : 65.0
    }
    
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
