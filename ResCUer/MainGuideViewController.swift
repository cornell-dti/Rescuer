//
//  MainGuideViewController.swift
//  ResCUer
//
//  Created by Raymone Radi  on 12/3/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

    
var guideSections = [GuideSection]()

class GuideSection
    
{
    
    var title: String
    var text: String
    
    init(title: String, text: String)
    {
        self.title = title
        self.text = text
    }
    
}



class MainGuideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = .white
        
        title = "Emergency Guide"
        
        tableView = UITableView(frame: view.frame)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        
        
        guideSections.append(GuideSection(title: "Active Shooter", text: ""))
        guideSections.append(GuideSection(title: "Animal Incidents", text: "weriherw"))
        guideSections.append(GuideSection(title: "Bomb Threat", text: ""))
        guideSections.append(GuideSection(title: "Building Evacuation", text: ""))
        guideSections.append(GuideSection(title: "Crime", text: ""))
        guideSections.append(GuideSection(title: "Earthquake", text: ""))
        guideSections.append(GuideSection(title: "Elevator Emergency", text: ""))
        guideSections.append(GuideSection(title: "Facility or Utility Problem", text: ""))
        guideSections.append(GuideSection(title: "Fire, Smoke, Explosion", text: ""))
        guideSections.append(GuideSection(title: "Hazardous Materials", text: ""))
        guideSections.append(GuideSection(title: "Medical/Health Emergency", text: ""))
        guideSections.append(GuideSection(title: "Severe Weather", text: ""))
        guideSections.append(GuideSection(title: "Suspicious Mail or Package", text: ""))
        guideSections.append(GuideSection(title: "Workplace Violence", text: " "))
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Reuse")
        cell.textLabel?.text = guideSections[indexPath.row].title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guideSection = guideSections[indexPath.row]
        
        let guideDetailViewController = CollapsibleTableViewController()
        guideDetailViewController.guideSection = guideSection
        
        navigationController?.pushViewController(guideDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
