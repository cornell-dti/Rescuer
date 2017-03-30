// raymone coded this garbage

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var lolISuck = 1
    var blueLightAnnotations: [MKPointAnnotation]!
    var centerCoordinate: CLLocationCoordinate2D!
    var centerCoordinate2: CLLocationCoordinate2D!
    var centerCoordinate3: CLLocationCoordinate2D!
    var annotation: MKPointAnnotation!
    var annotation2: MKPointAnnotation!
    var annotation3: MKPointAnnotation!
    var timeIncrementer = 0
    var image: UIImage!
    var button: UIButton!
    var giveDirections1 = false
    var giveDirections2 = false
    var giveDirections3 = false
    
    
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
        
        annotation = MKPointAnnotation()
        centerCoordinate = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.484568582589557)
        annotation.coordinate = centerCoordinate
        annotation.title = "Blue Light 1"
        annotation.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation)
        
        annotation2 = MKPointAnnotation()
        centerCoordinate2 = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.485558582589557)
        annotation2.coordinate = centerCoordinate2
        annotation2.title = "Blue Light 2"
        annotation2.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation2)
        
        annotation3 = MKPointAnnotation()
        centerCoordinate3 = CLLocationCoordinate2D(latitude: 42.44676609054141145, longitude: -76.484558582589557)
        annotation3.coordinate = centerCoordinate3
        annotation3.title = "Blue Light 3"
        annotation3.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation3)
        view.addSubview(mapView)
        
        image = UIImage(named: "location") as UIImage?
        button = UIButton(type: UIButtonType.custom) as UIButton
        button.frame = CGRect(x: 340, y: 580, width: 30, height: 30)
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
            print ("The location services are enabled.")
            print (mapView.userLocation.coordinate)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("\nRUNNING DID UPDATE LOCATION")
        print("locations array: \(locations)")

        
        //mapView.setCenter((locations.first!.coordinate), animated: true)
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        if (lolISuck == 1)
        {
        let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 2500)
        mapView.setCamera(mapCamera, animated: false)
        lolISuck = lolISuck + 1
        }
        
        let one = MKMapPointForCoordinate(centerCoordinate)
        let two = MKMapPointForCoordinate(centerCoordinate2)
        let three = MKMapPointForCoordinate(centerCoordinate3)
        let currentLocation = MKMapPointForCoordinate(mapView.userLocation.coordinate)
        
        
        let allBlueLights = [one, two, three]
        blueLightAnnotations = [annotation, annotation2, annotation3]
        var bestDistance = MKMetersBetweenMapPoints(currentLocation, one)
        var bestMapPoint = one
        
        for bluelight in allBlueLights {
            let distance = MKMetersBetweenMapPoints(currentLocation, bluelight)
            
            if distance < bestDistance {
                
                bestDistance = distance
                bestMapPoint = bluelight
                print (bestDistance)
            }
        }
        
        if (bestDistance < 50000)
            
        {
        
        if (bestMapPoint.x == one.x) && (bestMapPoint.y == one.y) {mapView.selectAnnotation(annotation, animated: true);}
        if (bestMapPoint.x == two.x) && (bestMapPoint.y == two.y) {mapView.selectAnnotation(annotation2, animated: true);}
        if (bestMapPoint.x == three.x) && (bestMapPoint.y == three.y) {mapView.selectAnnotation(annotation3, animated: true);}
            
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
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print (status.rawValue)
    }
    
    
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
    
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(directionsToBlueLight(withSender:)))
//        annotationView!.addGestureRecognizer(gestureRecognizer)
        
        // Right accessory view
        let image = UIImage(named: "location")
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: UIControlState())
        annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
        
    }
//    
//    func directionsToBlueLight(withSender sender: MKAnnotation) {
//        
//        
//    }
    
    func btnTouched(){
            let mapCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate, fromEyeCoordinate: mapView.userLocation.coordinate, eyeAltitude: 4500)
            mapView.setCamera(mapCamera, animated: true)
            lolISuck = lolISuck + 1
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: launchOptions)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if ((view.annotation?.title)! == "Blue Light 1"){
            
            
            
        }
        
        if ((view.annotation?.title)! == "Blue Light 2"){
            
        }
        
        if ((view.annotation?.title)! == "Blue Light 3"){
            
        }
        
    }
    
}
