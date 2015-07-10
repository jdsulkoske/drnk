//
//  ContainerViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 7/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class TodayContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "segmentedControlTapped:", name: "SCTapped", object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
