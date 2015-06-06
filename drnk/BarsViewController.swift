//
//  FirstViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

var arrayOfBars: [BarsInformation] = [BarsInformation]()
var activePlace = 1
var index : Int!
class BarsViewController: UIViewController, UITableViewDelegate {
    var counter = 1
    var timer = NSTimer()
  
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
   
    var selected:[Bool] = Array(count: 100, repeatedValue: false)
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        //myTableView.reloadData()
//        myTableView.estimatedRowHeight = 121
//        myTableView.rowHeight = UITableViewAutomaticDimension
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        self.setUpBar()
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBar(){
        
       var bar = BarsInformation(name: "Brother's Bar and Grill", address: "1601 W University Ave Muncie, USA")
        arrayOfBars.append(bar)
       
        bar = BarsInformation(name: "Cleo's Burboun Bar and Shit", address: "1625 W University Ave, Muncie, USA")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Pop's Lovely Bar", address: "10799 East County Road 750 North, Brownsburg")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Jake Sulks Wet & Wild Pub", address: "140 Ulen Boulevard Muncie")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "David's Bar", address: "1110 West Neely Avenue Muncie")
        arrayOfBars.append(bar)
        


        
    }
    
    @IBAction func assignRowIndexToButton(sender: UIButton) {
            let row = sender.tag
            selected[row] = true
            index = sender.tag
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfBars.count
        
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell: CustomBarTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomBarTableViewCell
        
        let bar = arrayOfBars[indexPath.row]
        index = cell.tag
        cell.addressOfBar.tag = indexPath.row
        if selected[indexPath.row] {
            cell.addressOfBar.enabled = false
        }
        else{
            cell.addressOfBar.enabled = true
        }
        
        cell.setCell(bar.name, addressOfBarText: bar.address)
        cell.detailTextLabel?.text = bar.name

        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
     func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        return indexPath
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBarInformationSegue"{
            let barInformationViewController = segue.destinationViewController as! BarInformationViewController
            
        }
        if segue.identifier == "newPlace" {
            
            activePlace = -1
            
        }

        
    }
    
    @IBAction func showBarInformation(sender: AnyObject) {
        performSegueWithIdentifier("showBarInformationSegue", sender: sender)
        
    }
    
        
    
    
}

