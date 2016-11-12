//
//  TodayViewCollectionCell.swift
//  Rescuer Today Extension
//
//  Created by Matthew Barker on 6/19/16.
//
//

import UIKit

class TodayViewCollectionCell: UICollectionViewCell {
    
    var topLabel: UILabel!
    var iconImage: UIImageView!
    var botLabel: UILabel!
    
    let data = UserDefaults.standard
    
    let space: CGFloat = 4
    
    override init(frame: CGRect) { super.init(frame: frame)
        
        // Icon Image
        iconImage = UIImageView()
        contentView.addSubview(iconImage)
        
        // Bottom Label
        botLabel = UILabel()
        botLabel.textColor = .black
        botLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(botLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("something bad happened"); fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(data: (title: String, color: UIColor)) {
                
        // Icon Image
        iconImage.image = UIImage()
        iconImage.backgroundColor = data.color
        iconImage.layer.cornerRadius = 10
        iconImage.layer.borderColor = UIColor.white.withAlphaComponent(1).cgColor
        iconImage.layer.borderWidth = 2
        iconImage.frame.size = CGSize(width: 64 * 0.9, height: 64 * 0.9)
        iconImage.center = contentView.center
        
        // Bottom Label
        botLabel.text = data.title
        botLabel.sizeToFit()
        let botLabel_Y = contentView.bounds.height - space - botLabel.frame.height
        botLabel.frame = CGRect(x: space, y: botLabel_Y,
                                width: botLabel.frame.width, height: botLabel.frame.height)
        botLabel.center.x = contentView.frame.width / 2.0
        
        iconImage.center.y -= botLabel.frame.height / 2 + 2
        botLabel.center.y += 2
        
    }
    
}


