//
//  LiquorStoresInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/21/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
var lsDetailArray: [LiquorStoreDetail] = [LiquorStoreDetail]()
class LiquorStoresInformationViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    var liquoreStoreNamePasssedValue : String!
    var liquoreStoreImagePassedValue : String!
    var liquoreStoreAddressPassed : String!
    
    var data : DataConnection!
    @IBOutlet weak var liqoureStoreImage: UIImageView!
    @IBOutlet weak var liquoreStoreName: UILabel!
    @IBOutlet weak var liqoureStoreAddrress: UILabel!
    @IBAction func backButton(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var nameOfBar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        data = DataConnection(typeOfBusiness: "liquorstores")
        liquoreStoreName.text = liquoreStoreNamePasssedValue
        liqoureStoreAddrress.text = liquoreStoreAddressPassed
        liqoureStoreImage.image = UIImage(named: liquoreStoreImagePassedValue)
        updateData()
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(){
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
//                self.networkMessage.hidden = false
//                self.networkMessage.text = "Network is unavailable"
//                self.refresher.endRefreshing()
            }
            else{
                //self.networkMessage.hidden = true
                var parser = Parser(jsonFile: responseObject!)
                lsDetailArray.removeAll(keepCapacity: true)
                
                dispatch_async(dispatch_get_main_queue()){
                    parser.parseLSInfo("lsDetail")
                    //self.setUpBar()
                    self.myTableView.reloadData()
                }
                
            }
           // self.refresher.endRefreshing()
            return
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
    
}
