//
//  LiquorStoresInformationViewController.swift
//  drnk
//
//  Created by drnk LLC on 6/21/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import UIKit
var lsDetailArray: [LiquorStoreDetail] = [LiquorStoreDetail]()
class LiquorStoresInformationViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var networkMessage: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var liqoureStoreImage: UIImageView!
    @IBOutlet weak var liquoreStoreName: UILabel!
   
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameOfBar: UILabel!
    var doNothing = false
    var liquoreStoreNamePasssedValue : String!
    var liquoreStoreImagePassedValue : String!
    var liquoreStoreAddressPassed : String!
    var data : DataConnection!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        segmentedControl.layer.cornerRadius = -0.5;
        segmentedControl.layer.borderWidth = 2.5;
        segmentedControl.layer.borderColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1).CGColor
        
        secondView.hidden = true
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        self.liqoureStoreImage.layer.cornerRadius = CGRectGetWidth(self.liqoureStoreImage.frame)/3.0
        self.liqoureStoreImage.layer.masksToBounds = true
        self.liqoureStoreImage.layer.borderWidth = 1.0
        
        data = DataConnection(typeOfBusiness: "liquorstore=true")
        liquoreStoreName.text = liquoreStoreNamePasssedValue
        liqoureStoreImage.image = UIImage(named: liquoreStoreImagePassedValue)
   
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
                self.networkMessage.hidden = false
                self.networkMessage.text = "Network Unavailable"
                
            } else {
                
                self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                lsDetailArray.removeAll(keepCapacity: true)
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.data.getData { (responseObject, error) -> Void in
                    parser.parseLSInfo("lsDetail")
                    self.myTableView.reloadData()
                    }
                }
                
            }
    
            return
            
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        
        updateData()
        segue = "lsDetailVC"
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lsDetailArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:DetailLiquoreStoreCustomCell = tableView.dequeueReusableCellWithIdentifier("cell") as! DetailLiquoreStoreCustomCell
        
        let liquorStore = lsDetailArray[indexPath.row]
        
        cell.setLiquorStoreCell(liquorStore.special)
        
        return cell
        
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            
            secondView.hidden = true
            
        case 1:
            
            secondView.hidden = false
            
        default:
            
            break;
            
        }
        
    }
    

    
    @IBAction func backButton(sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LSInfoSegue"{
            
            doNothing = true
            
            let aboutUSVC = segue.destinationViewController as! LSAboutUSViewController
            aboutUSVC.addressPassed = liquoreStoreAddressPassed
            
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        lsDetailArray.removeAll(keepCapacity: true)
        self.myTableView.reloadData()
        
    }
    
}
