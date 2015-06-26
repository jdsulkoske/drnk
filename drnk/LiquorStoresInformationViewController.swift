//
//  LiquorStoresInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/21/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class LiquorStoresInformationViewController: UIViewController {
    var liquoreStoreNamePasssedValue : String!
    var liquoreStoreImagePassedValue : String!
    var liquoreStoreAddressPassed : String!
    @IBOutlet weak var liqoureStoreImage: UIImageView!
    @IBOutlet weak var liquoreStoreName: UILabel!
    @IBOutlet weak var liqoureStoreAddrress: UILabel!
    @IBAction func backButton(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var nameOfBar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        liquoreStoreName.text = liquoreStoreNamePasssedValue
        liqoureStoreAddrress.text = liquoreStoreAddressPassed
        liqoureStoreImage.image = UIImage(named: liquoreStoreImagePassedValue)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
}
