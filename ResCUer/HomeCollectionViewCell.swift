//
//  HomeCollectionViewCell.swift
//  Rescuer
//
//  Created by Matthew Barker on 3/18/17.
//  Copyright © 2017 Cornell SA Tech. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    var backgroundCircle: UIView!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        backgroundCircle = UIView(frame: CGRect(origin: .zero, size:
            CGSize(width: contentView.frame.width * 0.75, height: contentView.frame.height * 0.75)))
        backgroundCircle.layer.cornerRadius = backgroundCircle.frame.size.width / 2
        backgroundCircle.clipsToBounds = true
        backgroundCircle.layer.shadowColor = UIColor.black.cgColor
        backgroundCircle.layer.shadowOpacity = 0.6
        backgroundCircle.layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundCircle.layer.shadowRadius = 2
        backgroundCircle.layer.shadowPath = UIBezierPath(roundedRect: backgroundCircle.bounds,
                                                         cornerRadius: backgroundCircle.layer.cornerRadius).cgPath
        backgroundCircle.layer.masksToBounds = false
        backgroundCircle.center = contentView.center
        backgroundCircle.center.y -= 0
        contentView.addSubview(backgroundCircle)
        
        imageView = UIImageView()
        imageView.frame = CGRect(origin: .zero, size:
            CGSize(width: backgroundCircle.frame.width * 0.5, height: backgroundCircle.frame.height * 0.5))
        imageView.center = backgroundCircle.center
        contentView.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect())
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        titleLabel.text = "Title Label"
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(data: (title: String, color: UIColor, image: String)) {
        
        backgroundCircle.backgroundColor = data.color
        
        imageView.image = UIImage(named: data.image)
        
        titleLabel.text = data.title
        titleLabel.sizeToFit()
        titleLabel.frame.size.width = backgroundCircle.frame.width
        titleLabel.center.x = backgroundCircle.center.x
        titleLabel.frame.origin.y = backgroundCircle.frame.maxY + 8
        
    }
    
}
