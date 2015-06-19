//
//  BarInformationViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/26/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class BarInformationViewController: UIViewController {
    var barPassedValue : String!
    var imagePassedValue : String!
    @IBOutlet weak var collectionviewCell: UICollectionView!

    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var nameOfBar: UILabel!
    @IBAction func hey(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        nameOfBar.text = barPassedValue
        barImage.image = UIImage(named: imagePassedValue)
       
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
