//
//  MainTableViewCell.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/3/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.darkGray
        
        titleLabel = UILabel()
        titleLabel.center = contentView.center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 36)
        contentView.addSubview(titleLabel)
        
        mainView = UIView(frame: contentView.frame)
        print("mainView.frame \(mainView.frame)")
        //mainView.frame.size.width -= contentView.frame.width / 4
        //mainView.frame.size.height -= contentView.frame.height / 8
        //mainView.center = CGPoint(x: contentView.frame.width / 2, y: contentView.frame.height / 2)
         print("mainView.frame \(mainView.frame)")
        contentView.addSubview(mainView)
        
        mainView.layer.cornerRadius = 16
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Something bad happened"); fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(data: (title: String, color: UIColor)) {
        titleLabel.text = data.title
        mainView.backgroundColor = data.color
    }

}
