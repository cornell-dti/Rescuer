// raymone coded this garbage

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var lolISuck = 1
    //var blueLightAnnotations: [MKPointAnnotation]!
    var centerCoordinateArray: [CLLocationCoordinate2D]!
    var centerCoordinate: CLLocationCoordinate2D!
    var centerCoordinate2: CLLocationCoordinate2D!
    var centerCoordinate3: CLLocationCoordinate2D!
    var annotation: MKPointAnnotation!
    var annotation2: MKPointAnnotation!
    var annotation3: MKPointAnnotation!
    var image: UIImage!
    var button: UIButton!
    var allBlueLights: [MKMapPoint]!
    var allAnnotations: [MKPointAnnotation]!
    var currentNumber = 0
    
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
        button.frame = CGRect(x: 300, y: 540, width: 70, height: 70)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(btnTouched), for:.touchUpInside)
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
        
        //print("\nRUNNING DID UPDATE LOCATION")
        //print("locations array: \(locations)")

        
        //mapView.setCenter((locations.first!.coordinate), animated: true)
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        if (lolISuck == 1)
        {
        let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 1500)
        mapView.setCamera(mapCamera, animated: false)
        lolISuck = lolISuck + 1
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

    @nonobjc func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        print ("Did Fail with Error")
        locationManager.stopUpdatingLocation()
        if ((error) != nil)
        {
            print(error)
        }
    }
    

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print (status.rawValue)
//    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation.title! == "My Location")
        {
        return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        
        // Right accessory view
        let image = UIImage(named: "location")
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: UIControlState())
        annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
        
    }

    func btnTouched(){
            let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate, fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 1500)
            mapView.setCamera(mapCamera, animated: true)
            lolISuck = lolISuck + 1
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (view.annotation?.title)!
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
        
    }

    func blueLightSetup(){
    centerCoordinateArray = []
    allAnnotations = []
    
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
        }
    }
}
    
}
