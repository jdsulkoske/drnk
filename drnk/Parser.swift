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
    
    var lsjsonFile:NSArray!
    var lsSpecialArray = [String]()
    var lsAddress = " "
    var lsName = ""
    
    var dayOfTheWeek : Day = Day()
    
    var deals : NSDictionary!
    init(jsonFile:NSArray){
        self.jsonFile = jsonFile
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        dayOfTheWeek.findDay(day)
        dayOfTheWeek.intValueToDayString(dayOfTheWeek.getIntValueOfDay())
      
       
    }
    var lsDeals : NSDictionary!
    init(lsjsonFile:NSArray){
        self.lsjsonFile = lsjsonFile
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        dayOfTheWeek.findDay(day)
        dayOfTheWeek.intValueToDayString(dayOfTheWeek.getIntValueOfDay())
        
        
    }
    
    func parseBarInfo(){
        for posts in jsonFile {
            address = posts["company_street"] as! String
            name = posts["company_name"] as! String
            deals = (posts["deals"] as? NSDictionary)!
            self.parseForSpecial()

        }
        
    }
    
    func parseLSInfo(){
        for posts in jsonFile {
            lsAddress = posts["company_street"] as! String
            lsName = posts["company_name"] as! String
            lsDeals = (posts["deals"] as? NSDictionary)!
            self.parseForLSSpecial()
            
        }
        
    }
    func parseForSpecial(){
     var days = deals[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
        for posts in days{
                var barspecial = posts["deal_name"] as! String
                barSpecialArray.append(barspecial)
            }
         bar = BarsInformation(name: name, address: address,barImage:"VCImage.png",special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
        arrayOfBars.append(bar)
    }
    
    func parseForLSSpecial(){
        var days = lsDeals["everyday"] as! NSArray
        for posts in days{
            var lsSpecial = posts["deal_name"] as! String
            lsSpecialArray.append(lsSpecial)
        }
        liquorStore = LiquorStoresInformation(lsName: lsName, address: lsAddress, lsImage: "VCImage.png", special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
        arrayOfLiquorStores.append(liquorStore)
    }

    

}