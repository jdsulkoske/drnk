//
//  Parser.swift
//  drnk
//
//  Created by faris shatat on 6/9/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class Parser{
    var jsonFile:NSArray!
    var barSpecialArray = [String]()
    var address = " "
    var name = ""
    var results : NSDictionary!
    init(jsonFile:NSArray){
        self.jsonFile = jsonFile
       
    }
    
    
    
    func parseBarInfo(){
        
      
        for posts in jsonFile {
            address = posts["company_street"] as! String
            name = posts["company_name"] as! String
            results = (posts["deals"] as? NSDictionary)!
            //println(results)
        
        }
        self.parseForSpecial()
    }
    func parseForSpecial(){
     var days = results["friday"] as! NSArray
        println(days)
        for posts in days{
                var barspecial = posts["deal_name"] as! String
                barSpecialArray.append(barspecial)
      
            }
         bar = BarsInformation(name: name, address: address,barImage:"VCImage.png",special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
        arrayOfBars.append(bar)
        }
//        
        
    

}