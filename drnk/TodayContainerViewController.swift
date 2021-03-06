//
//  ContainerViewController.swift
//  drnk
//
//  Created by drnk LLC on 7/10/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import UIKit
var todaysSpecialArray : [TodaysDeal] = [TodaysDeal]()
class TodayContainerViewController: UIViewController,UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    var data : DataConnection!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("segmentedControlTapped:"), name: "SCTapped", object: nil)
        
        data = DataConnection(typeOfBusiness: "bar=true")
        
    }

    override func viewDidAppear(animated: Bool) {
        
        updateData()
    
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
                
                self.updateData()
                
            } else {
                
               // self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                todaysSpecialArray.removeAll(keepCapacity: true)
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    parser.findTodaysSpecial()
                    
                    self.myTableView.reloadData()
                    
                    
                }
                
            }
            
        }
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysSpecialArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TodayDealCustomCell
        let special = todaysSpecialArray[indexPath.row]
       
        
//        if ( indexPath.row % 2 == 0 ) {
//            
//            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//            
//        } else {
//            
//            cell.backgroundColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
//            
//        }
        
        cell.setCell(special.special)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        todaysSpecialArray.removeAll(keepCapacity: true)
        self.myTableView.reloadData()
        
    }
    
}
