//
//  LSAboutUsViewController.swift
//  Pods
//
//  Created by faris shatat on 7/13/15.
//
//

import Foundation
class LSAboutUSViewController: UIViewController{
    
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var todaysHoursLabel: UILabel!
    var addressPassed : String!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var data : DataConnection!
    
    override func viewDidLoad() {
        data = DataConnection(typeOfBusiness: "liquorstores")

        addressButton.setTitle(addressPassed, forState: UIControlState.Normal)
        updateData()
    }
    
    
    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            
            if  responseObject == nil{
                
                
            } else {
                
                // self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                aboutUsArray.removeAll(keepCapacity: true)
                dispatch_async(dispatch_get_main_queue()){
                    parser.findAboutUs()
                    let info = aboutUsArray[0]
                    self.phoneNumberLabel.text = info.phone
                    self.todaysHoursLabel.text = info.currentdayHours
                    self.reloadInputViews()
                    
                }
                
                //self.refresher.endRefreshing()
                
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            
            activePlace = 2
            
        }
    }
    
}