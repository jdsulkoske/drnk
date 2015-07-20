//
//  AboutUsContainerViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 7/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
var aboutUsArray : [AboutUS]! = [AboutUS]()


class AboutUsContainerViewController: UIViewController {
    
    @IBOutlet weak var businessNumber: UIButton!
    @IBOutlet weak var address: UIButton!
    @IBOutlet weak var todaysHours: UILabel!
    
    var addressPassedValue : String!
    
    var data : DataConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = DataConnection(typeOfBusiness: "bars")
        self.updateData()

        address.setTitle(addressPassedValue, forState: UIControlState.Normal)
        self.address.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    
    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            
            if  responseObject == nil{
                

                
                
            } else {
                
               // self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                    aboutUsArray.removeAll(keepCapacity: true)
                dispatch_async(dispatch_get_main_queue()){
                    self.data.getData { (responseObject, error) -> Void in
                    parser.findAboutUs()
                    let info = aboutUsArray[0]
                    self.businessNumber.setTitle(info.phone, forState: UIControlState.Normal)
                    self.todaysHours.text = info.currentdayHours
                    self.businessNumber.titleLabel?.adjustsFontSizeToFitWidth = true
                    self.reloadInputViews()
                    
                    
                }
                }
                
                //self.refresher.endRefreshing()
                
            }
        }

        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            
            activePlace = -1
            
        }
    }
    
    
    @IBAction func MakePhoneCall(sender: AnyObject) {
        
        var number = businessNumber.titleLabel?.text!
        
        if number == "Could not retrieve phone number" {
            
        } else {
        
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + number!)!)
            
        }
        
        
    }
    
}