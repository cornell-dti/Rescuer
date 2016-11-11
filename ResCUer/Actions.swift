//
//  Actions.swift
//  ResCUer
//
//  Created by Matthew Barker on 11/11/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// Opens Apple Maps with directions from current location to address
func getDirections(forAddress: String) {
    
    CLGeocoder().geocodeAddressString(forAddress, completionHandler: {(placemarks, error) -> Void in
        
        if (error) != nil {
            //self.addressError(address)
        }
        
        if let placemark = placemarks?.first {
            let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
            mapItem.name = forAddress
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
        }
    })
    
}

/// Attempts to call phone number, fires callError if there is a failure
func call(number: String) {
    if let phoneCallNumber = URL(string: "tel://\(number)") {
        if UIApplication.shared.canOpenURL(phoneCallNumber) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(phoneCallNumber, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(phoneCallNumber)
            }
        } else { /* callError(number) */ }
    } else { /* callError(number) */ }
}



