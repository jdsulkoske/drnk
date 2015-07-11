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
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}
