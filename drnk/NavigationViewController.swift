//
//  NavigationViewController.swift
//  drnk
//
//  Created by faris shatat on 5/30/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
import Alamofire

class NavigationViewController: ENSideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationBar.translucent = false
        self.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 20)! , NSForegroundColorAttributeName: UIColor(red: 0/255, green: 178/255, blue: 255/255, alpha: 1)]
        self.navigationBar.tintColor = UIColor(red: 0/255, green: 178/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBarHidden = false
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}