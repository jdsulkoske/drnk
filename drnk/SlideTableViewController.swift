//
//  SlideTableViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class SlideTableViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.blackColor()
    }

}
