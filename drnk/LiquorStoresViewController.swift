//
//  SecondViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
var arrayOfLiquorStores: [LiquorStoresInformation] = [LiquorStoresInformation]()
var liquorStore : LiquorStoresInformation!

class LiquorStoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var liquoreStoreAddressToPass : String!
    var liqoureStoreNameToPass : String!
    var liqoureStoreImageToPass : String!
    @IBOutlet weak var networkMessage: UILabel!
    
    
    let data = DataConnection(typeOfBusiness: "liquorstores")
    var refresher: UIRefreshControl!
    @IBOutlet weak var menuButton: UIBarButtonItem!
//    @IBAction func showSlideMenu(sender: UIBarButtonItem) {
//        toggleSideMenuView()
//    }
    @IBOutlet weak var liquorStoreTableVIew: UITableView!
    var selected:[Bool] = Array(count: 100, repeatedValue: false)
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        self.liquorStoreTableVIew.addSubview(refresher)
        refresher.backgroundColor = UIColor(red: 0, green: 182, blue: 255, alpha: 1)
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
         self.updateData()
    }
    override func viewDidAppear(animated: Bool) {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func updateData(){
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
                self.networkMessage.hidden = false
                self.networkMessage.text = "Network is unavailable"
                self.refresher.endRefreshing()
            }
            else{
                self.networkMessage.hidden = true
                var parser = Parser(jsonFile: responseObject!)
                arrayOfLiquorStores.removeAll(keepCapacity: true)
                parser.parseLSInfo()
                dispatch_async(dispatch_get_main_queue()){
                    
                    //self.setUpBar()
                    self.liquorStoreTableVIew.reloadData()
                }
                
            }
            self.refresher.endRefreshing()
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLiquorStore(){
//        var ls1 = LiquorStoresInformation(lsName: "Muncie Liquors", address: "1110 West Neely Avenue", lsImage: "municeLiquors.png")
//        var ls2 = LiquorStoresInformation(lsName: "Friendly Package", address: "10213 Nicole Drive", lsImage: "friendly.png")
//        var ls3 = LiquorStoresInformation(lsName: "Muncie Liquors", address: "909 West Riverside", lsImage: "municeLiquors.png")
//        var ls4 = LiquorStoresInformation(lsName: "Another Liquor Store", address: "505 North EverWood Dr.", lsImage: "VCImage.png")
        
//        arrayOfLiquorStores.append(ls1)
//        arrayOfLiquorStores.append(ls2)
//        arrayOfLiquorStores.append(ls3)
//        arrayOfLiquorStores.append(ls4)

    }
    @IBAction func assignIndexRowToButtonInLiqourStoreView(sender: AnyObject) {
        let row = sender.tag
        selected[row] = true
        index = sender.tag
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            
        }
    }
    

    

}

