

import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy - kCLLocationAccuracyBest
          mapView.showsUserLocation = true
        
        if activePlace == 1 {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        } else {
            activePlace = 1
            findAddressOnMap()
        }
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(uilpgr)
    }
    
    
    func findAddressOnMap(){
        var address = arrayOfBars[index].address
        var annotation = MKPointAnnotation()
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                self.mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake (placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.002, 0.002)), animated: true)
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
            }
        })
        
        self.mapView.addAnnotation(annotation)
    }
  
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.mapView)
            
            var newCoordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                var subTitle = ""
                
                if (error == nil) {
                    
                    if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
                        var streetNumber:String = ""
                        var streetName:String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            streetNumber = p.subThoroughfare
                        }
                        
                        if p.thoroughfare != nil {
                            
                            streetName = p.thoroughfare
                        }
                        
                        title = "\(streetNumber) \(streetName)"
                        subTitle = "\(p.subLocality)\(p.subAdministrativeArea),\(p.postalCode)"
                    }
                }
                if title == "" {
                    
                    title = "Added \(NSDate())"
                }
                
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                annotation.subtitle = subTitle
                
                self.mapView.addAnnotation(annotation)
                
                
            })
        }
    }
    
 
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        var latDelta:CLLocationDegrees = 0.01
        
        var lonDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)

        self.mapView.setRegion(region, animated: true)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
