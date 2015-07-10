//
//  Parser.swift
//  drnk
//
//  Created by faris shatat on 6/9/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

var addressArray = [String]()
class Parser{
    private var jsonFile:NSArray!
    private var bar : BarsTableInfo!
    private var special : BarInfo!
    private var barSpecialArray = [String]()
    private var barInfoArray = [String]()
    private var address = " "
    private var name = ""
    private var businessId = ""
    
    private var lsSpecialArray = [String]()
    private var lsAllArray = [String]()
    private var lsAddress = " "
    private var lsName = ""
    
    private var dayOfTheWeek : Day = Day()
    private var lsDeals : NSDictionary!
    private var deals : NSDictionary!
    
    init(jsonFile:NSArray){
        self.jsonFile = jsonFile
        let date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        dayOfTheWeek.findDay(day)
        dayOfTheWeek.intValueToDayString(dayOfTheWeek.getIntValueOfDay())
        
        
    }
    
    //MARK: BARS FUNCTIONS
    
    func parseBarInfo(type:String){
        
        for posts in jsonFile{
            
            address = posts["company_street"] as! String
            name = posts["company_name"] as! String
            businessId = posts["id"] as! String
            deals = (posts["deals"] as? NSDictionary)!
            
            if type == "barView"{
                
                findSpecials()
                
            } else {
                
                parseSpecialForWeek()
                
            }
            
        }
        
    }
    
    private func parseSpecialForWeek(){
        
        if let file = jsonFile[detailViewIndex!]["deals"] as? NSDictionary{
            
            for(var i = 0; i<daysOfWeek.count; i++){
                
                var days = file[daysOfWeek[i].lowercaseString] as! NSArray
                
                for deal in days{
                    
                    var specialForDay = deal["deal_name"] as! String
                    var specialPrice = deal["price"] as! String
                    
                    if specialPrice == "0.00" {
                        
                        specialPrice = ""
                        
                    } else {
                        
                        specialPrice = "$" + specialPrice
                        
                    }
                    
                    if specialForDay != ""{
                        
                        barInfoArray.append(specialPrice + " " + specialForDay)
                        
                    }
                    
                }
                
                if barInfoArray.count >= 5{
                    
                    special = BarInfo(special1: barInfoArray[0], special2:barInfoArray[1], special3: barInfoArray[2], special4: barInfoArray[3], special5: barInfoArray[4])
                    
                } else {
                    
                    restructureBarInfoTable()
                    
                }
                
                detailTableViewArray.append(special)
                
                barInfoArray.removeAll(keepCapacity: true)
                
            }
            
        }
        
    }
    
    func restructureBarInfoTable(){
        if barInfoArray.count == 0 {
            
            special = BarInfo(special1: "Sorry, no specials", special2: "-", special3: "-", special4: "-", special5: "-")
            
        } else {
            
            var number = 10 - barInfoArray.count
            
            for numbers in 0...number{
                
                barInfoArray.append("-")
                
            }
            
            special = BarInfo(special1: barInfoArray[0], special2:barInfoArray[1], special3: barInfoArray[2], special4: barInfoArray[3], special5: barInfoArray[4])
        }
        
    }
    
    private func findSpecials(){
        
        var days = deals[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
        
        for posts in days{
            
            var barspecial = posts["deal_name"] as! String
            var specialPrice = posts["price"] as! String
            var isFeatured = posts["featured"] as! Int
            
            if specialPrice == "0.00" {
                
                specialPrice = ""
                
            } else {
                
                specialPrice = "$" + specialPrice + " "
                
            }
            
            if isFeatured == 1 {
                
                if specialPrice != ""{
                    
                    barSpecialArray.append(specialPrice + barspecial)
                    
                }
                
            }
            
        }
        
        structureBarFeaturedArray(barSpecialArray)
        arrayOfBars.append(bar)
        barSpecialArray.removeAll(keepCapacity: true)
        
    }
    
    func structureBarFeaturedArray(array:NSArray){
        
        if barSpecialArray.count >= 3{
            
            bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
            
        } else {
            
            rearrangeBarFeaturedArray()
            
        }
        
    }
    
    func rearrangeBarFeaturedArray(){
        
        if barSpecialArray.count == 0 {
            
            getNonFeaturedBarDeals()
            
            if barSpecialArray.count == 0 {
                
                bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: "Sorry, no features today", special2:"-",special3: "-")
                
            } else {
                
                addMoreBarSpecials(barInfoArray)
                
                if barSpecialArray.count >= 3 {
                    
                    bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                    
                } else {
                    
                    bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: "Sorry, no features today", special2:"-",special3: "-")
                    
                }
                
            }
            
        } else {
            
            getNonFeaturedBarDeals()
            
            if barSpecialArray.count >= 3 {
                
                bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                
            } else {
                
                addMoreBarSpecials(barSpecialArray)
                
                bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                
                
            }
        }
        
    }
    
    func getNonFeaturedBarDeals(){
        
        var days = deals[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
        
        for posts in days{
            
            var barspecial = posts["deal_name"] as! String
            var specialPrice = posts["price"] as! String
            var isFeatured = posts["featured"] as! Int
            
            if specialPrice == "0.00" {
                
                specialPrice = ""
                
            } else {
                
                specialPrice = "$" + specialPrice + " "
                
            }
            
            if isFeatured != 1 {
                
                if specialPrice != ""{
                    
                    barSpecialArray.append(specialPrice + barspecial)
                    
                }
                
            }
            
        }
        
    }
    
    func addMoreBarSpecials(array:NSArray){
        
        for numbers in 0...5{
            
            barSpecialArray.append("-")
            
        }
        
    }
    
    
    //MARK: LIQUOR STORES FUNCTIONS
    
    func parseLSInfo(){
        
        for posts in jsonFile {
            
            lsAddress = posts["company_street"] as! String
            lsName = posts["company_name"] as! String
            businessId = posts["id"] as! String
            lsDeals = (posts["deals"] as? NSDictionary)!
            
            self.parseForLSSpecial()
            
        }
        
    }
    
    private func parseForLSSpecial(){
        
        var days = lsDeals["everyday"] as! NSArray
        
        for posts in days{
            
            var lsSpecial = posts["deal_name"] as! String
            var lsSpecialPrice = posts["price"] as! String
            var featuredSpecial = posts["featured"] as! Int
            
            if lsSpecialPrice == "0.00" {
                
                lsSpecialPrice = ""
                
            } else {
                
                lsSpecialPrice = "$" + lsSpecialPrice + " "
                
            }
            
            if featuredSpecial == 1 {
                
                if lsSpecial != "" {
                    
                    lsSpecialArray.append(lsSpecialPrice + lsSpecial)
                    
                }
                
            }
            
        }
        
        checkLiquorDealCount()
        
        lsSpecialArray.removeAll(keepCapacity: true)
        
    }
    
    func checkLiquorDealCount(){
        
        if lsSpecialArray.count == 0
        {
            
            checkRegularDeals()
            
            if lsSpecialArray.count == 0 {
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName, address: lsAddress, lsImage: lsName, special1: "No specials", special2: "-", special3: "-")
                
                arrayOfLiquorStores.append(liquorStore)
                
            } else {
                
                addMoreLiquorSpecials(arrayOfLiquorStores)
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName, address: lsAddress, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            }
            
        } else {
            
            checkRegularDeals()
            
            if lsSpecialArray.count < 3 {
                
                addMoreLiquorSpecials(lsSpecialArray)
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName, address: lsAddress, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            } else {
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName, address: lsAddress, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            }
            
        }
        
    }
    
    func addMoreLiquorSpecials(array:NSArray){
        
        if array.count <= 3 {
            
            for numbers in 0...5{
                
                lsSpecialArray.append("-")
                
            }
            
        }
        
    }
    
    func checkRegularDeals(){
        
        var days = lsDeals["everyday"] as! NSArray
        
        for posts in days{
            
            var lsSpecial = posts["deal_name"] as! String
            var lsSpecialPrice = posts["price"] as! String
            var featuredSpecial = posts["featured"] as! Int
            
            if lsSpecialPrice == "0.00" {
                
                lsSpecialPrice = ""
                
            } else {
                
                lsSpecialPrice = "$" + lsSpecialPrice + " "
                
            }
            
            if featuredSpecial != 1 {
                
                if lsSpecial != "" {
                    
                    lsSpecialArray.append(lsSpecialPrice + lsSpecial)
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: MAP FUNCTIONS
    
    func parseForStreet(){
        
        for posts in jsonFile{
            
            var street = posts["company_street"] as! String
            println(street)
            //var city = posts["company_city"] as! String
            //let address = street + city
            let address = "224 S College Ave Muncie"
            addressArray.append(address)
            let add = "1515 N Mckinley Ave Muncie"
            addressArray.append(add)
            let ad = "713 W Ashland Muncie"
            addressArray.append(ad)
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}