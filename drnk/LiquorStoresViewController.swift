//
//  SecondViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class LiquorStoresViewController: UIViewController {

    @IBOutlet weak var liquorStoreTableVIew: UITableView!
    
    var arrayOfLiquorStores: [LiquorStoresInformation] = [LiquorStoresInformation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.setUpLiquorStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLiquorStore(){
        var ls1 = LiquorStoresInformation(lsName: "Muncie Liquors", lsAddress: "1110 West Neely Avenue", lsImage: "BeerGlass.png")
        var ls2 = LiquorStoresInformation(lsName: "Friendly Package", lsAddress: "10213 Nicole Drive", lsImage: "Headphones.png")
        var ls3 = LiquorStoresInformation(lsName: "Muncie Liquors", lsAddress: "909 West Riverside", lsImage: "redsolocupicon.png")
        var ls4 = LiquorStoresInformation(lsName: "Another Liquor Store", lsAddress: "505 North EverWood Dr.", lsImage: "VCImage.png")
        
        arrayOfLiquorStores.append(ls1)
        arrayOfLiquorStores.append(ls2)
        arrayOfLiquorStores.append(ls3)
        arrayOfLiquorStores.append(ls4)

    }

}

