//
//  BarInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/26/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class BarInformationViewController: UIViewController, UITableViewDelegate {
    var barPassedValue : String!
    var imagePassedValue : String!
    let daysOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var selectedIndexPath : NSIndexPath?
    @IBOutlet weak var barImage: UIImageView!
   
    @IBOutlet weak var nameOfBar: UILabel!
    @IBAction func hey(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        nameOfBar.text = barPassedValue
        barImage.image = UIImage(named: imagePassedValue)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomBarInfoCell
        cell.date.text = daysOfWeek[indexPath.row]
        
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
       
        (cell as! CustomBarInfoCell).ignoreFrameChanges()
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
