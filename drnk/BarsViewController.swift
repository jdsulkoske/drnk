//
//  FirstViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class BarsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var arrayOfBars: [BarsInformation] = [BarsInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        dateLabel.text = "Hey its \(day)! \nCheckout today's specials!"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpBar()
        

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpBar(){
        
        var bar = BarsInformation(name: "Brother's Bar and Grill", address: "1601 W University Ave Muncie, IN 47303")
        arrayOfBars.append(bar)
       
        bar = BarsInformation(name: "Cleo's Burboun Bar and Shit", address: "1625 W University Ave, Muncie IN 47303")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Pop's Lovely Bar", address: "10799 East County Road 750 North, Brownsburg, IN 46112")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Jake Sulks Wet & Wild Pub", address: "140 Ulen Boulevard Muncie, IN 47303")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "David's Bar", address: "1110 West Neely Avenue Muncie, IN 47303")
        arrayOfBars.append(bar)

        
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfBars.count
        
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell: CustomBarTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomBarTableViewCell
//        
//        if indexPath.row % 2 == 0{
//            cell.backgroundColor = UIColor.darkGrayColor()
//        }
//        else{
//            cell.backgroundColor = UIColor.darkGrayColor()
//        }
        
        let bar = arrayOfBars[indexPath.row]
        cell.setCell(bar.name, addressOfBarText: bar.address)
        cell.detailTextLabel?.text = bar.name
        var image = UIImage(named: "barglass")
        cell.imageView?.image = image
        return cell
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBarInformationSegue"{
            let barInformationViewController = segue.destinationViewController as! BarInformationViewController
            
        }
        
    }
    
    @IBAction func showBarInformation(sender: AnyObject) {
        performSegueWithIdentifier("showBarInformationSegue", sender: sender)    }
    
    
    
    
}

