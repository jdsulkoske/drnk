//
//  SlideTableViewController.swift
//  drnk
//
//  Created by drnk LLC on 6/10/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SlideTableViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var liquore: UIImageView!
    let locationManager = CLLocationManager()
    @IBOutlet var myTableView: UITableView!
    
    var userCurrentCity = ""
    var data = DataConnection(typeOfBusiness: "bar=true")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        self.myTableView.backgroundView = UIImageView(image: UIImage(named: "slide"))
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.blackColor()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) -> Void in
            if error != nil {
                
                return
                
            }
            if let pm = placemarks?.first {
                
                self.displayLocationInfo(pm)
                
            } else {
                
                
                
            }
            
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        let theCity = placemark.locality!
        let newString = theCity.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        userCurrentCity = newString.lowercaseString
        seedPerson()
        
    }
    
    func seedPerson(){
        let moc = DataController().managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Session", inManagedObjectContext: moc) as! Session
        entity.setValue(userCurrentCity, forKey: "currentCity")
        do{
            try moc.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }

}
