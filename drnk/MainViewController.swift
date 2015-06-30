//
//  ViewController.swift
//  drnktoo
//
//  Created by Jake Sulkoske on 6/8/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBAction func showSlideMenu(sender: UIBarButtonItem) {
            self.revealViewController()

    }
    @IBAction func drnk(sender: AnyObject) {
        self.revealViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBarHidden = true
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
