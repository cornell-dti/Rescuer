// raymone coded this garbage

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
<<<<<<< HEAD
    var lolISuck = 1
    //var blueLightAnnotations: [MKPointAnnotation]!
    var centerCoordinateArray: [CLLocationCoordinate2D]!
=======
    var isInitialView: Bool = true
    var blueLightAnnotations: [MKPointAnnotation]!
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
    var centerCoordinate: CLLocationCoordinate2D!
    var centerCoordinate2: CLLocationCoordinate2D!
    var centerCoordinate3: CLLocationCoordinate2D!
    var annotation: MKPointAnnotation!
    var annotation2: MKPointAnnotation!
    var annotation3: MKPointAnnotation!
    var image: UIImage!
    var button: UIButton!
<<<<<<< HEAD
    var allBlueLights: [MKMapPoint]!
    var allAnnotations: [MKPointAnnotation]!
    var currentNumber = 0
=======
    var giveDirections1 = false
    var giveDirections2 = false
    var giveDirections3 = false
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Blue Light Map"
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(netHex: "E74E33")
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // Do any additional setup after loading the view.
        mapView = MKMapView()
        locationManager = CLLocationManager()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.showsUserLocation = true
        blueLightSetup()
//        
//        annotation = MKPointAnnotation()
//        centerCoordinate = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.484568582589557)
//        annotation.coordinate = centerCoordinate
//        annotation.title = "Blue Light 1"
//        annotation.subtitle = "Tap for directions"
//        mapView.addAnnotation(annotation)
//
//        annotation2 = MKPointAnnotation()
//        centerCoordinate2 = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.485558582589557)
//        annotation2.coordinate = centerCoordinate2
//        annotation2.title = "Blue Light 2"
//        annotation2.subtitle = "Tap for directions"
//        mapView.addAnnotation(annotation2)
//        
//        annotation3 = MKPointAnnotation()
//        centerCoordinate3 = CLLocationCoordinate2D(latitude: 42.44676609054141145, longitude: -76.484558582589557)
//        annotation3.coordinate = centerCoordinate3
//        annotation3.title = "Blue Light 3"
//        annotation3.subtitle = "Tap for directions"
//        mapView.addAnnotation(annotation3)
        
        view.addSubview(mapView)
        
        image = UIImage(named: "LocationArrowAttempt") as UIImage?
        button = UIButton(type: UIButtonType.custom) as UIButton
        button.frame.size = CGSize(width: 44, height: 44)
        let bounds = UIScreen.main.bounds
        let padding: CGFloat = 20
        let navHeight = tabBarController?.tabBar.frame.height ?? 0
            button.frame.origin = CGPoint(x: bounds.width - button.frame.size.width - padding,
                                          y: bounds.height - navHeight - button.frame.size.height - padding)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(recenterMap), for:.touchUpInside)
        view.addSubview(button)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            //locationManager.requestLocation()
            mapView.showsUserLocation = true
            locationManager.distanceFilter = 10
            //print ("The location services are enabled.")
            //print (mapView.userLocation.coordinate)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
<<<<<<< HEAD
        //print("\nRUNNING DID UPDATE LOCATION")
        //print("locations array: \(locations)")
=======
        // print("\nRUNNING DID UPDATE LOCATION")
        // print("locations array: \(locations)")
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1

        //mapView.setCenter((locations.first!.coordinate), animated: true)
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
<<<<<<< HEAD
        if (lolISuck == 1)
        {
        let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 1500)
        mapView.setCamera(mapCamera, animated: false)
        lolISuck = lolISuck + 1
=======
        if isInitialView {
            let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 2500)
            mapView.setCamera(mapCamera, animated: false)
            isInitialView = false
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
        }
        
        allBlueLights = []
        
        for bl in centerCoordinateArray {
            let mapPoint: MKMapPoint = MKMapPointForCoordinate(bl)
            allBlueLights.append(mapPoint)
        }
        
        //let one = MKMapPointForCoordinate(centerCoordinate)
        //let two = MKMapPointForCoordinate(centerCoordinate2)
        //let three = MKMapPointForCoordinate(centerCoordinate3)
        
        let currentLocation = MKMapPointForCoordinate(locations.last!.coordinate)
        //print (currentLocation)

        var bestDistance = MKMetersBetweenMapPoints(currentLocation, allBlueLights[0])
        var bestMapPoint = allBlueLights[0]
        
        for bluelight in allBlueLights {
            let distance = MKMetersBetweenMapPoints(currentLocation, bluelight)
            
            if distance < bestDistance {
                
                bestDistance = distance
                bestMapPoint = bluelight
                //print (bestDistance)
            }
        }
        
        
        if (bestDistance < 50000)
        {
        //print (allBlueLights.count)
        //print (allAnnotations.count)
            for bluelight in allBlueLights{
                  currentNumber = allBlueLights.index(where: { (bluelight) -> Bool in
                    (bestMapPoint.x == bluelight.x) && (bestMapPoint.y == bluelight.y)
                })!
                if (bestMapPoint.x == bluelight.x) && (bestMapPoint.y == bluelight.y)
                {
                    //print (currentNumber)
                    mapView.selectAnnotation(allAnnotations[currentNumber], animated: true);
                }
            }
        
        }
        
    }
<<<<<<< HEAD

    @nonobjc func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        print ("Did Fail with Error")
=======
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
<<<<<<< HEAD

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print (status.rawValue)
//    }
=======
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print (status.rawValue)
    }
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
    
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
        
        if !isInitialView && (mapView.getZoomLevel() > 3 || mapView.region.span.latitudeDelta > latDelta ||
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
<<<<<<< HEAD
        
        // Right accessory view
        let image = UIImage(named: "location")
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: UIControlState())
        annotationView?.rightCalloutAccessoryView = button
=======
    
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(directionsToBlueLight))
        annotationView!.addGestureRecognizer(gestureRecognizer)
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
        
        return annotationView
        
    }
<<<<<<< HEAD

    func btnTouched(){
            let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate, fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 1500)
=======
    
    func directionsToBlueLight(sender: UITapGestureRecognizer) {
        
        if let annotation = (sender.view as? MKPinAnnotationView)?.annotation {
            let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = annotation.title ?? "Selected Blue Light Location"
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
        
    }
    
    func recenterMap(){
        print("recent camera")
            let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate,
                                        fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 1000)
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
            mapView.setCamera(mapCamera, animated: true)
    }
    
}

fileprivate let MERCATOR_OFFSET: Double = 268435456
fileprivate let MERCATOR_RADIUS: Double = 85445659.44705395

extension MKMapView {
    
    func getZoomLevel() -> Double {
        
<<<<<<< HEAD
        let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (view.annotation?.title)!
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
=======
        let reg = self.region
        let span = reg.span
        let centerCoordinate = reg.center
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
        
        // Get the left and right most lonitudes
        let leftLongitude = centerCoordinate.longitude - (span.longitudeDelta / 2)
        let rightLongitude = centerCoordinate.longitude + (span.longitudeDelta / 2)
        let mapSizeInPixels = self.bounds.size
        
        // Get the left and right side of the screen in fully zoomed-in pixels
        let leftPixel = self.longitudeToPixelSpaceX(longitude: leftLongitude)
        let rightPixel = self.longitudeToPixelSpaceX(longitude: rightLongitude)
        let pixelDelta = abs(rightPixel - leftPixel)
        
        let zoomScale = Double(mapSizeInPixels.width) / pixelDelta
        let zoomExponent = log2(zoomScale)
        let zoomLevel = zoomExponent + 20
        
        return zoomLevel
    }

    func blueLightSetup(){
    centerCoordinateArray = []
    allAnnotations = []
    
<<<<<<< HEAD
    if let path = Bundle.main.url(forResource: "blueLight", withExtension: "json") {
        
        do {
            let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                    if let blueLightArray = jsonResult.value(forKey: "elements") as? NSArray {
                        for (_, element) in blueLightArray.enumerated() {
                            if let element = element as? NSDictionary {
                                let y = element.value(forKey: "Y") as! String
                                let x = element.value(forKey: "X") as! String
                                let name = element.value(forKey: "Address") as! String
                                let clcoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(y)!, longitude: CLLocationDegrees(x)!)
                                let localAnnotation: MKPointAnnotation = MKPointAnnotation()
                                centerCoordinateArray.append(clcoordinate)
                                localAnnotation.coordinate = clcoordinate
                                localAnnotation.title = name
                                localAnnotation.subtitle = "Tap for directions"
                                allAnnotations.append(localAnnotation)
                                mapView.addAnnotation(localAnnotation)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
        } catch let error as NSError {
            print("Error: \(error)")
=======
    func setCenter(coordinate: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool) {
        
        let zoom = min(zoomLevel, 28)
        
        let span = self.coordinateSpan(centerCoordinate: coordinate, zoomLevel: zoom)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        self.setRegion(region, animated: true)
    }
    
    // MARK: - Private func
    
    private func coordinateSpan(centerCoordinate: CLLocationCoordinate2D, zoomLevel: Int) -> MKCoordinateSpan {
        
        // Convert center coordiate to pixel space
        let centerPixelX = self.longitudeToPixelSpaceX(longitude: centerCoordinate.longitude)
        let centerPixelY = self.latitudeToPixelSpaceY(latitude: centerCoordinate.latitude)
        
        // Determine the scale value from the zoom level
        let zoomExponent = 20 - zoomLevel
        let zoomScale = NSDecimalNumber(decimal: pow(2, zoomExponent)).doubleValue
        
        // Scale the map’s size in pixel space
        let mapSizeInPixels = self.bounds.size
        let scaledMapWidth = Double(mapSizeInPixels.width) * zoomScale
        let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale
        
        // Figure out the position of the top-left pixel
        let topLeftPixelX = centerPixelX - (scaledMapWidth / 2)
        let topLeftPixelY = centerPixelY - (scaledMapHeight / 2)
        
        // Find delta between left and right longitudes
        let minLng: CLLocationDegrees = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX)
        let maxLng: CLLocationDegrees = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX + scaledMapWidth)
        let longitudeDelta: CLLocationDegrees = maxLng - minLng
        
        // Find delta between top and bottom latitudes
        let minLat: CLLocationDegrees = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY)
        let maxLat: CLLocationDegrees = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY + scaledMapHeight)
        let latitudeDelta: CLLocationDegrees = -1 * (maxLat - minLat)
        
        return MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }
    
    private func longitudeToPixelSpaceX(longitude: Double) -> Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * .pi / 180.0)
    }
    
    private func latitudeToPixelSpaceY(latitude: Double) -> Double {
        if latitude == 90.0 {
            return 0
        } else if latitude == -90.0 {
            return MERCATOR_OFFSET * 2
        } else {
            return round(MERCATOR_OFFSET - MERCATOR_RADIUS * Double(logf((1 + sinf(Float(latitude * .pi) / 180.0)) / (1 - sinf(Float(latitude * .pi) / 180.0))) / 2.0))
>>>>>>> 7d8fea7261a83fe0dfc03141325866473a0f86f1
        }
    }
}
    
    private func pixelSpaceXToLongitude(pixelX: Double) -> Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / .pi
    }
    
    
    private func pixelSpaceYToLatitude(pixelY: Double) -> Double {
        return (.pi / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / .pi
    }
}
