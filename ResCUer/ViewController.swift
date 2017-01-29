//
//  ViewController.swift
//  DynamicCellHeightProgrammatic
//
//  Created by Satinder Singh on 7/3/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    fileprivate let bookCellReuseIdentifier = "BookTableViewCellIdentifier"
    fileprivate let bookList = BookDataSource.bookList()
    fileprivate let tableview = UITableView()

    let topics = ["Active Shooter", "Animal Incidents", "Bomb Threat", "Building Evacuation", "Crime", "Earthquake", "Elevator Emergency",
                  "Facility or Utility Problem", "Fire, Smoke, Explosion", "Hazardous Materials", "Medical/Health Emergency", "Severe Weather",
                  "Suspicious Mail or Package", "Workplace Violence"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        configureTableView()
    }
    
    func configureTableView() {
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.register(BookTableViewCell.self, forCellReuseIdentifier: bookCellReuseIdentifier)
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }

}

extension ViewController : UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: bookCellReuseIdentifier, for: indexPath) as! BookTableViewCell
        let book = bookList[indexPath.row]
        cell.nameLabel.text = book.name
        cell.detailLabel.text = book.details
        return cell
    }
}

