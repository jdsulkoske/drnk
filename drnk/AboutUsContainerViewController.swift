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

    @IBOutlet weak var address: UIButton!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var todaysHours: UILabel!
    
    var addressPassedValue : String!
   
    var data : DataConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = DataConnection(typeOfBusiness: "bars")
        self.updateData()

        address.setTitle(addressPassedValue, forState: UIControlState.Normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    
    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            
            if  responseObject == nil{
                
//                self.networkMessage.hidden = false
//                self.networkMessage.text = "Network Unavailable"
//                self.refresher.endRefreshing()
                
                println("nothing")
                
            } else {
                
               // self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                detailTableViewArray.removeAll(keepCapacity: true)
                dispatch_async(dispatch_get_main_queue()){
                    parser.findInfoForBars()
                    let info = aboutUsArray[0]
                    self.phoneNumber.text = info.phone
                    self.todaysHours.text = info.currentdayHours
                    self.reloadInputViews()
                    
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
}