//
//  SecondViewController.swift
//  drnk
//
//  Created by drnk LLC on 5/25/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import UIKit

var arrayOfLiquorStores: [LiquorStoresInformation] = [LiquorStoresInformation]()
var liquorStore : LiquorStoresInformation!
var lsIndex : Int!

class LiquorStoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var locationButton: UIBarButtonItem!
    @IBOutlet weak var networkMessage: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var liquorStoreTableVIew: UITableView!
    
    var liquoreStoreAddressToPass : String!
    var liqoureStoreNameToPass : String!
    var liqoureStoreImageToPass : String!
    var refresher: UIRefreshControl!
    let data = DataConnection(typeOfBusiness: "liquorstore=true")
    var selected:[Bool] = Array(count: 100, repeatedValue: false)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.networkMessage.hidden = true
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSForegroundColorAttributeName: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)])
        refresher.addTarget(self, action: #selector(LiquorStoresViewController.updateData), forControlEvents: UIControlEvents.ValueChanged)
        
        self.liquorStoreTableVIew.addSubview(refresher)
        
        refresher.backgroundColor = UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1)
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.updateData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        segue = "lsViewController"
        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
    }
    
    func updateData(){
        networkMessage.hidden = true
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
                
                self.networkMessage.hidden = false
                self.networkMessage.text = "Network Unavailable"
                self.refresher.endRefreshing()
                
            } else {
                
                self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                arrayOfLiquorStores.removeAll(keepCapacity: true)
               
                dispatch_async(dispatch_get_main_queue()){
                    
                    parser.parseLSInfo("lsTableView")
                    self.liquorStoreTableVIew.reloadData()
                    
                    
                }
                
                
            }
            
            self.refresher.endRefreshing()
            return
        }
        
    }
    
    @IBAction func assignIndexRowToButtonInLiqourStoreView(sender: AnyObject) {
        
        let row = sender.tag
        selected[row] = true
        index = sender.tag
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayOfLiquorStores.count == 0{
            self.networkMessage.text = "Sorry, there doesn't seem to be any businesses in your area that utilize drnk! You can check out specials in other cities by changing your preferred location below!"
            self.networkMessage.hidden = false
        } else {
            self.networkMessage.hidden = true
        }
        
        return arrayOfLiquorStores.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomLiquorStoresTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomLiquorStoresTableViewCell
        
        let liquorStore = arrayOfLiquorStores[indexPath.row]
        
        index = cell.tag
        cell.addressOfLiquorStore.tag = indexPath.row

        
        cell.setLiquorStoreCell(liquorStore.liquorStoreName, addressLabel: liquorStore.address, image: liquorStore.liquorStoreImage,special1: liquorStore.special1,special2: liquorStore.special2,special3: liquorStore.special3)
        
        cell.detailTextLabel?.text = liquorStore.liquorStoreName
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        liqoureStoreNameToPass = arrayOfLiquorStores[indexPath.row].liquorStoreName
        liqoureStoreImageToPass = arrayOfLiquorStores[indexPath.row].liquorStoreImage
        liquoreStoreAddressToPass = arrayOfLiquorStores[indexPath.row].address
        
        performSegueWithIdentifier("LSDetailViewSegue", sender: self)
        lsIndex = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showLocationForLiquorStore" {
            
            activePlace = 2
            
        } else if segue.identifier == "LSDetailViewSegue" {
            
            let lsInformationViewController = segue.destinationViewController as! LiquorStoresInformationViewController
            lsInformationViewController.liquoreStoreNamePasssedValue = liqoureStoreNameToPass
            lsInformationViewController.liquoreStoreImagePassedValue = liqoureStoreImageToPass
            lsInformationViewController.liquoreStoreAddressPassed = liquoreStoreAddressToPass
            
        } else if segue.identifier == "locationPopupSegue" {
        
            let vc = segue.destinationViewController 
            
            let controller = vc.popoverPresentationController
            
            if controller != nil {
            
                controller?.delegate = self
                
            }
            
        }
        
    }
    
    @IBAction func locationButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("locationPopupSegue", sender: self)
        
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    

}