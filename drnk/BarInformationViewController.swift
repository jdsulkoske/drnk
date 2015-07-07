//
//  BarInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/26/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

var detailTableViewArray : [BarInfo] = [BarInfo]()
let daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

var detailViewIndex : Int!
class BarInformationViewController: UIViewController, UITableViewDelegate {
    var barPassedValue : String!
    var imagePassedValue : String!
    var refresher : UIRefreshControl!
    var data = DataConnection(typeOfBusiness: "bars")
    var selectedIndexPath : NSIndexPath?
    @IBOutlet weak var barImage: UIImageView!
  
    @IBOutlet weak var detailTableView: UITableView!
   
    @IBOutlet weak var nameOfBar: UILabel!
    @IBAction func backButton(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.backgroundColor = UIColor(red: 0, green: 182, blue: 255, alpha: 1)
        refresher.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.detailTableView.addSubview(refresher)
       
        //detailTableView.dataSource = self
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        nameOfBar.text = barPassedValue
        barImage.image = UIImage(named: imagePassedValue)
        println("viewDidLoad")
        self.updateData()
             }

    

    
    func updateData(){
        data.getData { (responseObject, error) -> Void in
            if  responseObject == nil{
                    println("nothing")
            }
            else{
                let parser = Parser(jsonFile: responseObject!)
                detailTableViewArray.removeAll(keepCapacity: true)
                dispatch_async(dispatch_get_main_queue()){
                    parser.parseBarInfo("barInfo")
                    self.detailTableView.reloadData()
            }
        self.refresher.endRefreshing()
                
            }
           // self.refresher.endRefreshing()
            
        }
        
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailTableViewArray.count > 0{
            println(detailViewIndex)
            return daysOfWeek.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomBarInfoCell
        cell.date.text = daysOfWeek[indexPath.row]
      
        
        let special = detailTableViewArray[indexPath.row]
        
     cell.setCell(special.special1, special2: special.special2, special3: special.special3, special4: special.special4, special5: special.special5)
      
       
        return cell
    }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
            
        }
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath{
            indexPaths += [previous]
            
        }
        if let current = selectedIndexPath{
            indexPaths += [current]
        }
        if indexPaths.count > 0{
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CustomBarInfoCell).watchFrameChanges()
        

    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath{
            return CustomBarInfoCell.expandingHeight
            
        }
        else{
            return CustomBarInfoCell.defaultHeight
        }
    }
    
    
}
