//
//  TodayViewController.swift
//  Rescuer Today Extension
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import MapKit

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var timer: Timer!
    
    let cellData = [(title: "Home", color: UIColor(netHex: "2474CC")),
                    (title: "Friends", color: UIColor(netHex: "6CB95B")),
                    (title: "Taxi", color: UIColor(netHex: "F9B604")),
                    (title: "Emergency", color: UIColor(netHex: "E62424"))]
    
    let data = UserDefaults(suiteName: "group.rescuer")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = (extensionContext?.widgetMaximumSize(for: .compact))!
        buildView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func buildView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        let layout_Width = (preferredContentSize.width - 20) / 5
        layout.itemSize = CGSize(width: layout_Width, height: preferredContentSize.height - 20)
        
        let viewRect = CGRect(x: 10, y: 10, width: preferredContentSize.width - 20, height: layout.itemSize.height)
        collectionView = UICollectionView(frame: viewRect, collectionViewLayout: layout)
        collectionView.dataSource = self; collectionView.delegate = self
        collectionView.register(TodayViewCollectionCell.self, forCellWithReuseIdentifier: "iconCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.center.y = preferredContentSize.height / 2
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! TodayViewCollectionCell
        cell.setCell(data: cellData[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        // Home
        if indexPath.row == 0 {
            if let address = data.string(forKey: "address") {
                getDirections(forLocation: address, indexPath)
            } else {
                extensionError(indexPath)
            }
        }
            
            // Friends
        else if indexPath.row == 1 {
            
        }
            
            // Taxi
        else if indexPath.row == 2 {
            call(number: "6075888888", indexPath)
        }
            
            // Emergency
        else if indexPath.row == 3 {
            
        }
        
    }
    
    func extensionError(_ indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TodayViewCollectionCell
        cell.botLabel.text = "Error"
        cell.botLabel.sizeToFit()
        cell.botLabel.center.x = cell.contentView.center.x
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(reset), userInfo: nil, repeats: false);
    }
    
    func reset() {
        timer.invalidate()
        collectionView.reloadData()
    }
    
    // MARK: Call Functions
    
    /// Attempts to call phone number, fires callError if there is a failure
    func call(number: String, _ indexPath: IndexPath) {
        if let phoneCallNumber = URL(string: "tel://\(number)") {
            extensionContext?.open(phoneCallNumber, completionHandler: nil)
        } else { extensionError(indexPath) }
    }
    
    // MARK: Location Functions
    
    /// Opens Apple Maps with walking directions from current location to address
    func getDirections(forLocation: String, _ indexPath: IndexPath) {
        CLGeocoder().geocodeAddressString(forLocation, completionHandler: {(placemarks, error) -> Void in
            if (error) != nil {
                self.extensionError(indexPath)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
                mapItem.name = forLocation
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
            }
        })
    }
    
}

/** Create UIColors from hex values */
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: String) {
        let hex = Int(netHex, radix: 16)!
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}
