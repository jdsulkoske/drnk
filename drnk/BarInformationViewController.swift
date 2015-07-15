//
//  BarInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/26/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
var doNothing = false
var detailTableViewArray : [BarInfo] = [BarInfo]()
let daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
var detailViewIndex : Int!
var segue : String!
class BarInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var barsController: UISegmentedControl!
    @IBOutlet weak var networkMessage: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var nameOfBar: UILabel!
    @IBOutlet weak var addressOfBar: UILabel!

    var barPassedValue : String!
    var imagePassedValue : String!
    var addressPassedValie : String!
    var refresher : UIRefreshControl!
    var data = DataConnection(typeOfBusiness: "bars")
    var selectedIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        barsController.layer.cornerRadius = -0.5;
        barsController.layer.borderWidth = 2.5;
        barsController.layer.borderColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1).CGColor

        refresher = UIRefreshControl()
        firstView.hidden = true
        secondView.hidden = false
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.backgroundColor = UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1)
        refresher.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.detailTableView.addSubview(refresher)
       
        detailTableView.dataSource = self
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        nameOfBar.text = barPassedValue
        barImage.image = UIImage(named: imagePassedValue)
        addressOfBar.text = addressPassedValie
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.updateData()
        segue = "detailVC"
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
    }
    
    func updateData(){
        
        data.getData { (responseObject, error) -> Void in
            
            if  responseObject == nil{
                
                self.networkMessage.hidden = false
                self.networkMessage.text = "Network Unavailable"
                self.refresher.endRefreshing()
                
            } else {
                
                self.networkMessage.hidden = true
                let parser = Parser(jsonFile: responseObject!)
                
                self.data.getData({ (responseObject, error) -> () in
                    parser.parseBarInfo("barInfo")
                    self.detailTableView.reloadData()
                })
                
                
                self.refresher.endRefreshing()
                
            }
            
           // self.refresher.endRefreshing()
            
        }
        
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if detailTableViewArray.count > 0{
            
            return daysOfWeek.count
            
        } else {
            
            return 0
            
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomBarInfoCell
        let special = detailTableViewArray[indexPath.row]
        cell.date.text = daysOfWeek[indexPath.row]
        cell.setCell(special.special1, special2: special.special2, special3: special.special3, special4: special.special4, special5: special.special5)
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            
            selectedIndexPath = nil
            
        } else {
            
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
            
        } else {
            
            return CustomBarInfoCell.defaultHeight
            
        }
        
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch barsController.selectedSegmentIndex {
            
        case 0:
            
            firstView.hidden = true
            secondView.hidden = false
            
        case 1:
            
            firstView.hidden = true
            secondView.hidden = true
            
        case 2:
            
            firstView.hidden = false
            secondView.hidden = true
            
        default:
            
            break;
            
        }
        
    }
    
    

    @IBAction func backButton(sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InfoSegue"{
            
            doNothing = true
            
            let aboutUSVC = segue.destinationViewController as! AboutUsContainerViewController
            aboutUSVC.addressPassedValue = addressPassedValie

        }
    }

    override func viewDidDisappear(animated: Bool) {
        
        detailTableViewArray.removeAll(keepCapacity: true)
        self.detailTableView.reloadData()

    }
    
    
}