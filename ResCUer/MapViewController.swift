// raymone coded this garbage

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mapView = MKMapView()
    var locationManager = CLLocationManager()
    var isInitialView: Bool = true
    var annotations: [MKPointAnnotation] = []
    var coordinates: [CLLocationCoordinate2D] = []
    
    var closestAnnotationIndex = 0
    var selectedAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Blue Light Map"
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(netHex: "E74E33")
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // Do any additional setup after loading the view.
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        createBlueLights()
        
        let image = UIImage(named: "LocationArrowAttempt") as UIImage?
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
            localAnnotation.subtitle = "Tap for directions"
            mapView.addAnnotation(localAnnotation)
            
            annotations.append(localAnnotation)
            coordinates.append(location)
        }
    
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //mapView.setCenter((locations.first!.coordinate), animated: true)
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
        
        selectedAnnotation = annotations[closestAnnotationIndex]
        mapView.selectAnnotation(selectedAnnotation, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if UserDefaults.standard.object(forKey: "latDelta")  == nil {
            let json = try! JSON(data: Data(contentsOf: Bundle.main.url(forResource: "BlueLight", withExtension: "json")!))
            
            var minLat = Double.greatestFiniteMagnitude; var maxLat = -1 * Double.greatestFiniteMagnitude
            var minLong = Double.greatestFiniteMagnitude; var maxLong = -1 * Double.greatestFiniteMagnitude
            for (_ , coordinate) in json["elements"] {
                
                let long = coordinate["X"].doubleValue
                if long > maxLong { maxLong = long }
                else if long < minLong { minLong = long }
                
                let lat = coordinate["Y"].doubleValue
                if lat > maxLat { maxLat = lat }
                else if lat < minLat { minLat = lat }
                
            }
            
            let infintyCheck = !(minLat == Double.infinity || maxLat == -1 * Double.infinity ||
                minLong == Double.infinity || maxLong == -1 * Double.infinity)
            
            if infintyCheck {
                UserDefaults.standard.set(maxLat - minLat, forKey: "latDelta")
                UserDefaults.standard.set(maxLong - minLong, forKey: "longDelta")
            }
            
        }
        
        let latDelta = UserDefaults.standard.value(forKey: "latDelta") as! Double
        let longDelta = UserDefaults.standard.value(forKey: "longDelta") as! Double
        
        if !isInitialView && (mapView.region.span.latitudeDelta > latDelta ||
            mapView.region.span.longitudeDelta > longDelta) {
                // recenterMap()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title! == "My Location" {
            return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
    
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(directionsToBlueLight))
        annotationView!.addGestureRecognizer(gestureRecognizer)
        
        return annotationView
        
    }
    
    func directionsToBlueLight(sender: UITapGestureRecognizer) {
        
        if let annotation = (sender.view as? MKPinAnnotationView)?.annotation {
            if selectedAnnotation == annotation {
                let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = annotation.title ?? "Selected Blue Light Location"
                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
                mapItem.openInMaps(launchOptions: launchOptions)
            }
            selectedAnnotation = annotation as! MKPointAnnotation
        }
        
    }
    
    func recenterMap() {
        print("recenter map")
        let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate,
                                    fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 1000)
        mapView.setCamera(mapCamera, animated: true)
        selectedAnnotation = annotations[closestAnnotationIndex]
        mapView.selectAnnotation(selectedAnnotation, animated: true)
    }
    
}

func ==(lhs: MKAnnotation, rhs: MKAnnotation) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
