//
//  SecondViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
var arrayOfLiquorStores: [LiquorStoresInformation] = [LiquorStoresInformation]()

class LiquorStoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
//    @IBAction func showSlideMenu(sender: UIBarButtonItem) {
//        toggleSideMenuView()
//    }
    @IBOutlet weak var liquorStoreTableVIew: UITableView!
    var selected:[Bool] = Array(count: 100, repeatedValue: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpLiquorStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLiquorStore(){
        var ls1 = LiquorStoresInformation(lsName: "Muncie Liquors", address: "1110 West Neely Avenue", lsImage: "drnklogo.png")
        var ls2 = LiquorStoresInformation(lsName: "Friendly Package", address: "10213 Nicole Drive", lsImage: "Headphones.png")
        var ls3 = LiquorStoresInformation(lsName: "Muncie Liquors", address: "909 West Riverside", lsImage: "redsolocupicon.png")
        var ls4 = LiquorStoresInformation(lsName: "Another Liquor Store", address: "505 North EverWood Dr.", lsImage: "VCImage.png")
        
        arrayOfLiquorStores.append(ls1)
        arrayOfLiquorStores.append(ls2)
        arrayOfLiquorStores.append(ls3)
        arrayOfLiquorStores.append(ls4)

    }
    @IBAction func assignIndexRowToButtonInLiqourStoreView(sender: AnyObject) {
        let row = sender.tag
        selected[row] = true
        index = sender.tag
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLiquorStores.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomLiquorStoresTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomLiquorStoresTableViewCell
        
        let liquorStore = arrayOfLiquorStores[indexPath.row]
        
        index = cell.tag
        cell.addressOfLiquorStore.tag = indexPath.row
   
        

        
        cell.setLiquorStoreCell(liquorStore.liquorStoreName, addressLabel: liquorStore.address, image: liquorStore.liquorStoreImage)
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLocationForLiquorStore" {
            
            activePlace = 2
            
        } else if segue.identifier == "ShowLSInfoSegue" {
            let lsInformationViewController = segue.destinationViewController as! LiquorStoresInformationViewController
            
            
        }
    }

}

