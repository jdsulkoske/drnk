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
var index : Int?
var bar : BarsInformation!
class BarsViewController: UIViewController, UITableViewDelegate {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!

    var timer = NSTimer()
   
    var selected:[Bool] = Array(count: 100, repeatedValue: false)
    let data = DataConnection()
    var barNameToPass : String?
    var cellIndex : Int?
    var barImageToPass : String?
    
    
    override func loadView() {
        super.loadView()
        updateData()
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.navigationController?.toolbar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationController?.toolbar.tintColor = UIColor(red: 0/255, green: 178/255, blue: 255/255, alpha: 1)
     
        self.navigationController?.navigationBarHidden = true
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
       
    }
    
    
   
  
    private func updateData(){
        if arrayOfBars.isEmpty{
        self.data.getData { (responseObject, error) -> Void in
            var parser = Parser(jsonFile: responseObject!)
            parser.parseBarInfo()
            dispatch_async(dispatch_get_main_queue()){
                self.setUpBar()
                self.myTableView.reloadData()
                
            }
            return
        }
        }
        else{
            println("do nothing")
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func viewDidDisappear(animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          }
    
    
   
    func setUpBar(){
        
        bar = BarsInformation(name: "Brother's Bar and Grill", address: "1601 W University Ave Muncie, USA", barImage:"drnklogo.png")
        arrayOfBars.append(bar)
       
        bar = BarsInformation(name: "Cleo's Burboun Bar and Shit", address: "1625 W University Ave, Muncie, USA", barImage:"drnklogo.png")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Pop's Lovely Bar", address: "10799 East County Road 750 North, Brownsburg", barImage:"drnklogo.png")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "Jake Sulks Wet & Wild Pub", address: "140 Ulen Boulevard Muncie", barImage:"drnklogo.png")
        arrayOfBars.append(bar)

        bar = BarsInformation(name: "David's Bar", address: "1110 West Neely Avenue Muncie", barImage:"drnklogo.png")
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
        cellIndex = indexPath.row
        
        let bar = arrayOfBars[indexPath.row]
        index = cell.tag
        cell.addressOfBar.tag = indexPath.row

        
        cell.setCell(bar.name, addressOfBarText: bar.address, image: bar.barImage)
        cell.detailTextLabel?.text = bar.name

        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        barNameToPass = arrayOfBars[indexPath.row].name
        barImageToPass = arrayOfBars[indexPath.row].barImage
        performSegueWithIdentifier("showBarInformationSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBarInformationSegue"{
            let barInformationViewController = segue.destinationViewController as! BarInformationViewController
            barInformationViewController.barPassedValue = barNameToPass
            barInformationViewController.imagePassedValue = barImageToPass
        }
        if segue.identifier == "newPlace" {
            
            activePlace = -1
            
        }
        
    }
}

