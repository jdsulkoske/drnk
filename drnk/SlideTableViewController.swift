//
//  SlideTableViewController.swift
//  drnk
//
//  Created by drnk LLC on 6/10/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import UIKit
import CoreLocation
var currentUserZip = ""
var currentCity = ""

class SlideTableViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var liquore: UIImageView!
    let locationManager = CLLocationManager()
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.myTableView.backgroundView = UIImageView(image: UIImage(named: "slide"))
//        self.profileImage.layer.cornerRadius = CGRectGetWidth(self.profileImage.frame)/2.15
//        self.profileImage.layer.masksToBounds = true
//        self.profileImage.layer.borderWidth = 1.0
//        self.profileImage.layer.borderColor = UIColor(red: 0/255, green: 186/255, blue: 255/255, alpha: 0.7).CGColor
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.blackColor()
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
//            if error != nil {
//
//                return
//            
//            }
//            if let pm = placemarks?.first {
//    
//                self.displayLocationInfo(pm)
//
//                
//            } else {
//            
//      
//                
//            }
//            
//        })
//    }
    
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
        currentCity = theCity.lowercaseString
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        currentUserZip = "none"
    }

}
