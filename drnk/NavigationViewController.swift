//
//  NavigationViewController.swift
//  drnk
//
//  Created by faris shatat on 5/30/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barTintColor = UIColor.redColor()
        self.navigationBar.translucent = true
        self.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Zapfino", size: 20)! , NSForegroundColorAttributeName: UIColor.whiteColor()]
        

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
