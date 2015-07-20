//
//  SlideTableViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
import CoreLocation
var currentUserZip = ""

class SlideTableViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var liquore: UIImageView!
    let locationManager = CLLocationManager()
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
      
    
   
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.blackColor()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("Error: ")
                return
            
            }
            if placemarks.count > 0 {
            
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)

                
            } else {
            
                println("Error with data")
                
            }
            
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
    
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.locality)
        println(placemark.postalCode)
        currentUserZip = placemark.postalCode
        println(placemark.administrativeArea)
        println(placemark.country)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        currentUserZip = "none"
    }

}
