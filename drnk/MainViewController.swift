//
//  ViewController.swift
//  drnktoo
//
//  Created by Jake Sulkoske on 6/8/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func showMenu(sender: UIBarButtonItem) {
        revealViewController().tapGestureRecognizer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
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
