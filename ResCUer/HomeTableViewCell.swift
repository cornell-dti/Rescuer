//
//  MainTableViewCell.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/3/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var cellDimensions: (cellHeight: CGFloat, separation: CGFloat) = (0, 0)
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
        
        mainView = UIView()
        mainView.layer.cornerRadius = 8
        contentView.addSubview(mainView)
        
        titleLabel = UILabel(frame: CGRect())
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 36)
        mainView.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Something bad happened"); fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(data: (title: String, color: UIColor)) {
        
        mainView.frame.size.height = cellDimensions.cellHeight - (2 * cellDimensions.separation)
        mainView.frame.size.width = contentView.frame.width * 0.9
        mainView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: cellDimensions.cellHeight / 2)
        mainView.backgroundColor = data.color
        
        titleLabel.text = data.title
        titleLabel.setNeedsDisplay()
        titleLabel.frame.size = titleLabel.intrinsicContentSize
        titleLabel.center = CGPoint(x: mainView.frame.width / 2, y: mainView.frame.height / 2)
        
        
    }

}
