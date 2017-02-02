//
//  ViewController.swift
//  DynamicCellHeightProgrammatic
//
//  Created by Satinder Singh on 7/3/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let bookCellReuseIdentifier = "BookTableViewCellIdentifier"
    let tableview = UITableView()
    
    var pageTitle: String = ""
    var library: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pageTitle
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
    
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: bookCellReuseIdentifier, for: indexPath) as! BookTableViewCell
        let book = library[indexPath.row]
        cell.nameLabel.text = book.name
        cell.detailLabel.text = book.details
        return cell
    }
}

