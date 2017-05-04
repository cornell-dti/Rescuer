//
//  MapViewController.swift
//  Rescuer
//
//  Created by Matthew Barker on 3/18/17.
//  Copyright © 2017 Cornell SA Tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView = MKMapView()
    var locationManager = CLLocationManager()
    var isInitialView: Bool = true
    var blueLightAnnotations: [MKAnnotation] = []
    var busStopAnnotations: [MKAnnotation] = []
    var coordinates: [CLLocationCoordinate2D] = []
    var closestAnnotationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Emergency Map"
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(netHex: "E74E33")
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        mapView.mapType = .hybrid
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.showsUserLocation = true
        let defaultLocation = CLLocationCoordinate2D(latitude: 42.444986, longitude: -76.481154)
        let mapCamera = MKMapCamera(lookingAtCenter: defaultLocation, fromEyeCoordinate: defaultLocation, eyeAltitude: 2500)
        mapView.setCamera(mapCamera, animated: false)
        view.addSubview(mapView)
        
        createBlueLights()
        createBusStops()
        
        let image = UIImage(named: "Location") as UIImage?
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.frame.size = CGSize(width: 44, height: 44)
        let bounds = UIScreen.main.bounds
        let padding: CGFloat = 20
        let navHeight = tabBarController?.tabBar.frame.height ?? 0
            button.frame.origin = CGPoint(x: bounds.width - button.frame.size.width - padding,
                                          y: bounds.height - navHeight - button.frame.size.height - padding)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(recenterMap), for:.touchUpInside)
        view.addSubview(button)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 10
        
    }
    
    func createBlueLights() {
        
        let json = try! JSON(data: Data(contentsOf: Bundle.main.url(forResource: "BlueLight", withExtension: "json")!))
        for (_, coordinate) in json["elements"] {
            let lat = coordinate["Y"].doubleValue
            let long = coordinate["X"].doubleValue
            let address = coordinate["Address"].stringValue
            let formattedAddress = address.lowercased().localizedCapitalized
            
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let localAnnotation = MKPointAnnotation()
            localAnnotation.coordinate = location
            localAnnotation.title = formattedAddress
            localAnnotation.subtitle = "Blue Light"
            mapView.addAnnotation(localAnnotation)
            
            blueLightAnnotations.append(localAnnotation)
            coordinates.append(location)
        }
    
    }
    
    func createBusStops() {
        
        let json = try! JSON(data: Data(contentsOf: Bundle.main.url(forResource: "BusStops", withExtension: "json")!))
        for (_, stop) in json {
            let lat = stop["coords"]["lat"].doubleValue
            let long = stop["coords"]["lon"].doubleValue
            let address = stop["name"].stringValue
            
            if lat != 0.0 && long != 0.0 {
                let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let localAnnotation = MKPointAnnotation()
                localAnnotation.coordinate = location
                localAnnotation.title = address
                localAnnotation.subtitle = "Bus Stop"
                mapView.addAnnotation(localAnnotation)
                
                busStopAnnotations.append(localAnnotation)
            }
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        if isInitialView {
            let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 2500)
            mapView.setCamera(mapCamera, animated: false)
            isInitialView = false
        }
        
        var blueLights: [MKMapPoint] = []
        for coordinate in coordinates {
            let mapPoint: MKMapPoint = MKMapPointForCoordinate(coordinate)
            blueLights.append(mapPoint)
        }
        
        let currentLocation = MKMapPointForCoordinate(locations.last!.coordinate)
        var bestDistance = MKMetersBetweenMapPoints(currentLocation, blueLights.first!)
        
        for index in 0..<blueLights.count {
            let bluelight = blueLights[index]
            let distance = MKMetersBetweenMapPoints(currentLocation, bluelight)
            if distance < bestDistance {
                bestDistance = distance
                closestAnnotationIndex = index
            }
        }
        
        mapView.selectAnnotation(blueLightAnnotations[closestAnnotationIndex], animated: true)
        
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
    
    // Beta: Restrict map to Tompkins Country, reset map around current location otherwise
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let rect = mapView.visibleMapRect
        let northMapPoint = MKMapPointMake(MKMapRectGetMidX(rect), MKMapRectGetMinY(rect))
        let southMapPoint = MKMapPointMake(MKMapRectGetMidX(rect), MKMapRectGetMaxY(rect))
        let westMapPoint = MKMapPointMake(MKMapRectGetMinX(rect), MKMapRectGetMidY(rect))
        let eastMapPoint = MKMapPointMake(MKMapRectGetMaxX(rect), MKMapRectGetMidY(rect))
        
        let currentLatSpan = MKMetersBetweenMapPoints(northMapPoint, southMapPoint)
        let currentLongSpan = MKMetersBetweenMapPoints(westMapPoint, eastMapPoint)
        let maxLatSpan: CLLocationDistance = 31728 // meters, used below data to calculate
        let maxLongSpan: CLLocationDistance = 44009 // meters, used below data to calculate
        
        /* most extreme points on TCAT Route map
        let north = 42.61321283145329
        let east = -76.28125469914926
        let south = 42.32796328578829
        let west = -76.67690943302259 */
        
        let existsAnnotationsInView = mapView.annotations(in: rect).count != 0
        let constant: CLLocationDistance = 4 // arbitrary number to reduce max span
        let isZoomReasonable = currentLatSpan <= (maxLatSpan / constant) && currentLongSpan <= (maxLongSpan / constant)
        
        print("\(currentLatSpan <= (maxLatSpan / constant)) \(currentLatSpan) ≤ \((maxLatSpan / constant)) && \(currentLongSpan <= (maxLongSpan / constant)) \(currentLongSpan) ≤ \((maxLongSpan / constant))")
        
        if !(existsAnnotationsInView && isZoomReasonable) {
            recenterMap()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // stop any other annotations (e.g. current location) from becoming pin
        if !(annotation is MKPointAnnotation) { return nil }
        
        let identifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        let isBlueLight = blueLightAnnotations.contains(where: { $0 == annotationView!.annotation! })
        annotationView!.image = isBlueLight ? #imageLiteral(resourceName: "pin_blue") : #imageLiteral(resourceName: "pin_red")
        annotationView?.tintColor = isBlueLight ? UIColor(netHex: "4990E2") : UIColor(netHex: "FB3A2F")
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // Launch Apple Maps with walking directions to location
        if let annotation = view.annotation {
            let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            let defaultString = "Selected \(isBlueLight(view) ? "Blue Light" : "Bus Stop")"
            mapItem.name = annotation.title ?? defaultString
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
        
    }
    
    //* Returns true if the MKAnnotationView is a Blue Light. Must have annotation. */
    func isBlueLight(_ view: MKAnnotationView) -> Bool {
        return blueLightAnnotations.contains(where: { $0 == view.annotation! })
    }
    
    //* Recenter map to current location, showing closest Blue Light again */
    func recenterMap() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            let message = "Please enable location services to find the nearest blue light to your current location."
            let alert = UIAlertController(title: "Where you at?", message: message, preferredStyle: .alert)
            let option1 = UIAlertAction(title: "Settings", style: .default) { (action) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                }
            }
            let option2 = UIAlertAction(title: "You'll never find me!", style: .cancel, handler: nil)
            alert.addAction(option1); alert.addAction(option2)
            present(alert, animated: true, completion: nil)
        } else {
            let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate,
                                        fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 1000)
            mapView.setCamera(mapCamera, animated: true)
            if !blueLightAnnotations.isEmpty {
                let selectedAnnotation = blueLightAnnotations[closestAnnotationIndex]
                if selectedAnnotation.coordinate.latitude != 0.0 && selectedAnnotation.coordinate.longitude != 0.0 {
                    mapView.selectAnnotation(selectedAnnotation, animated: true)
                }
            }
        }
        
    }
    
}

func ==(lhs: MKAnnotation, rhs: MKAnnotation) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
