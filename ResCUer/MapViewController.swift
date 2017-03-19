// raymone coded this garbage

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var lolISuck = 1
    var blueLightAnnotations: [MKPointAnnotation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        title = "Map"
        // Do any additional setup after loading the view.
        mapView = MKMapView()
        locationManager = CLLocationManager()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.484568582589557)
        annotation.coordinate = centerCoordinate
        annotation.title = "Blue Light 1"
        annotation.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation)
        
        let annotation2 = MKPointAnnotation()
        let centerCoordinate2 = CLLocationCoordinate2D(latitude: 42.449209054141145, longitude: -76.485558582589557)
        annotation2.coordinate = centerCoordinate2
        annotation2.title = "Blue Light 2"
        annotation2.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation2)
        
        let annotation3 = MKPointAnnotation()
        let centerCoordinate3 = CLLocationCoordinate2D(latitude: 42.44676609054141145, longitude: -76.484558582589557)
        annotation3.coordinate = centerCoordinate3
        annotation3.title = "Blue Light 3"
        annotation3.subtitle = "Tap for directions"
        mapView.addAnnotation(annotation3)
        
        let one = MKMapPointForCoordinate(centerCoordinate)
        let two = MKMapPointForCoordinate(centerCoordinate2)
        let three = MKMapPointForCoordinate(centerCoordinate3)
        let currentLocation = MKMapPointForCoordinate(mapView.userLocation.coordinate)
        print ("current location")
        print (currentLocation)
        
        let allBlueLights = [one, two, three]
        blueLightAnnotations = [annotation, annotation2, annotation3]
        var bestDistance = MKMetersBetweenMapPoints(currentLocation, one)
        var bestMapPoint = one
        
        for bluelight in allBlueLights {
            
            if MKMetersBetweenMapPoints(currentLocation, bluelight) < bestDistance {
                bestDistance = MKMetersBetweenMapPoints(currentLocation, bluelight)
                bestMapPoint = bluelight
            }
        }
        
        print ("best map point: ")
        print (bestMapPoint)
        print ("one")
        print (one)
        
        if (bestMapPoint.x == one.x) && (bestMapPoint.y == one.y) {mapView.selectAnnotation(annotation, animated: true)}
        if (bestMapPoint.x == two.x) && (bestMapPoint.y == two.y) {mapView.selectAnnotation(annotation2, animated: true)}
        if (bestMapPoint.x == three.x) && (bestMapPoint.y == three.y) {mapView.selectAnnotation(annotation3, animated: true)}
        
        view.addSubview(mapView)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            //locationManager.requestLocation()
            mapView.showsUserLocation = true
            print ("The location services are enabled.")
            print (mapView.userLocation.coordinate)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("Did Update Locations")
        print (locations.first!.coordinate)
        //mapView.setCenter((locations.first!.coordinate), animated: true)
        print (locations[0].coordinate)
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print (coord)
        
        if (lolISuck == 1)
        {
        let mapCamera = MKMapCamera(lookingAtCenter: coord, fromEyeCoordinate: coord, eyeAltitude: 2500)
        print (mapCamera)
        print (mapView)
        mapView.setCamera(mapCamera, animated: false)
        lolISuck = lolISuck + 1
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
        }else{
            annotationView?.annotation = annotation
        }
    
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(directionsToBlueLight))
        annotationView!.addGestureRecognizer(gestureRecognizer)
        
        return annotationView
    }
    
    func directionsToBlueLight() {
        print ("cool")
    }
    
    
}
