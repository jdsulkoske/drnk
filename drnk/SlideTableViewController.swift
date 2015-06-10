//
//  SlideTableViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class SlideTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var destinationVC: UIViewController!
        
        if indexPath.row == 1{
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController?
            
        } else if indexPath.row == 2{
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController?
        } else if indexPath.row == 3{
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController?
        } else if indexPath.row == 4{
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController?
        }
        
        sideMenuController()?.setContentViewController(destinationVC)
    }
    


}
