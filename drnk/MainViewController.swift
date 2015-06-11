//
//  ViewController.swift
//  drnktoo
//
//  Created by Jake Sulkoske on 6/8/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func showSlideMenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//        self.navigationController?.navigationBarHidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "barsSegue"{
//            let barViewController = segue.destinationViewController as! BarsViewController
//            
//        }
//    }
//    override func viewWillAppear(animated: Bool) {
//        navigationController?.navigationBarHidden = true
//        super.viewWillAppear(animated)
//    }
//    
//    
//    override func viewWillDisappear(animated: Bool) {
//        if (navigationController?.topViewController != self) {
//            navigationController?.navigationBarHidden = false
//        }
//        super.viewWillDisappear(animated)
//    }
//
//    @IBAction func showBarsView(sender: AnyObject) {
//        
//        performSegueWithIdentifier("barsSegue", sender: sender)
//    }
//
//    @IBAction func showMapView(sender: AnyObject) {
//        performSegueWithIdentifier("mapSegue", sender: sender)
//    }
//
//    @IBAction func showStoresView(sender: AnyObject) {
//        performSegueWithIdentifier("storesSegue", sender: sender)
//    }

}
