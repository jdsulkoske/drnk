//
//  PopoverViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/11/16.
//  Copyright © 2016 Sulk. All rights reserved.
//

import UIKit
import CoreData

class PopoverViewController: UIViewController, UIPickerViewDelegate {

    let moc = DataController().managedObjectContext
    let cities = ["Muncie", "Broadripple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 250, height: 200)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
    
        return 1
        
    }
    
    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return cities.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return cities[row]
    }

    @IBAction func doneButton(sender: AnyObject)
    {
        let thisVC = PopoverViewController()
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            thisVC.dismissViewControllerAnimated(false, completion: nil);
        });
        let lsVC = LiquorStoresViewController()
        lsVC.viewDidLoad()
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let city = cities[row].lowercaseString
        let moc = DataController().managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Session", inManagedObjectContext: moc) as! Session
        entity.setValue(city, forKey: "currentCity")
        do{
            try moc.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    
    }
}
