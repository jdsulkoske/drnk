//
//  Parser.swift
//  drnk
//
//  Created by faris shatat on 6/9/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

var addressArray = [String]()
var nameOfBusinessArray = [String]()
class Parser{
    private var jsonFile : NSArray!
    private var bar : BarsTableInfo!

    private var special : BarInfo!
    private var barSpecialArray = [String]()
    private var barInfoArray = [String]()
    private var todayArray = [String]()
    private var address = " "
    private var name = ""
    private var businessId = ""
    private var lsSpecial : LiquorStoreDetail!
    private var todaysSpecial: TodaysDeal!
    private var lsSpecialArray = [String]()
    private var lsAllArray = [String]()
    
    
    private var lsAddress = " "
    private var lsName = ""
    
    private var dayOfTheWeek : Day = Day()
    private var lsDeals : NSDictionary!
    private var deals : NSDictionary!
    private var type : String?
    init(jsonFile:NSArray){
        self.jsonFile = jsonFile
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.stringFromDate(date)
        dayOfTheWeek.findDay(day)
        dayOfTheWeek.intValueToDayString(dayOfTheWeek.getIntValueOfDay())
        
    }
    
    //MARK: BARS FUNCTIONS
    
    func parseBarInfo(type:String){
        
        for posts in jsonFile{
            if let street = posts["company_street"] as? String{
            let city = posts["company_city"] as! String
            address = street + ", " + city

            address.capitalizedString
            name = posts["company_name"] as! String
            name.capitalizedString
            businessId = posts["id"] as! String
            
            deals = (posts["deals"] as? NSDictionary)!
            
            if type == "barView"{
                
                findSpecials()
                
            } else {
                
                parseSpecialForWeek()
                
            }
            }
            
        }
        
        
    }
    
    func findAboutUs(){
        var index : Int!
        if segue == "barViewController" || segue == "barDetailVC"{
            index = detailViewIndex

        }
        else {

            index = lsIndex
        }
        //THE ERROR IS HAPPENING RIGHT AFTER THIS BELOW!!!
        let json = jsonFile[index] as! NSDictionary
        if let currentdayHours = json[dayOfTheWeek.getDayAsString().lowercaseString+"_hours"] as? String{
            let phone  = json["company_phone"] as! String
            let info = AboutUS(currentdayHours: currentdayHours, phone: phone)
            aboutUsArray.append(info)
        }

    }
    
    private func findSpecials(){
        
        let days = deals[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
        
        for posts in days{
            
            let barspecial = posts["deal_name"] as! String
            var specialPrice = posts["price"] as! String
            let isFeatured = posts["featured"] as! Int
            
            if specialPrice == "0.00" {
                
                specialPrice = ""
                
            } else {
                
                specialPrice = "$" + specialPrice + " "
                
            }
            
            if isFeatured == 1 {
                    
                barSpecialArray.append(specialPrice + barspecial)
                
            }
            
        }
        
        structureBarFeaturedArray(barSpecialArray)
        
        arrayOfBars.append(bar)
        
        barSpecialArray.removeAll(keepCapacity: true)
        
    }
    
    private func structureBarFeaturedArray(array:NSArray){

        if barSpecialArray.count >= 3{
            bar = BarsTableInfo(id: businessId, name: name, address: address,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
        }
            
        else {
            
            rearrangeBarFeaturedArray()
            
        }
        
    }
    
    private func rearrangeBarFeaturedArray(){
        
        if barSpecialArray.count == 0 {
            
            getNonFeaturedBarDeals()
            
            if barSpecialArray.count == 0 {
                
                bar = BarsTableInfo(id: businessId, name: name.capitalizedString, address: address.capitalizedString,barImage:name,special1: "Sorry, no features today", special2:"-",special3: "-")
                
            } else {
                
                addMoreBarSpecials(barInfoArray)
                
                if barSpecialArray.count >= 3 {
                    
                    bar = BarsTableInfo(id: businessId, name: name.capitalizedString, address: address.capitalizedString,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                    
                } else {
                    
                    bar = BarsTableInfo(id: businessId, name: name.capitalizedString, address: address.capitalizedString,barImage:name,special1: "Sorry, no features today", special2:"-",special3: "-")
                    
                }
                
            }
            
        } else {
            
            getNonFeaturedBarDeals()
            
            if barSpecialArray.count >= 3 {
                
                bar = BarsTableInfo(id: businessId, name: name, address: address.capitalizedString,barImage:name.capitalizedString,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                
            } else {
                
                addMoreBarSpecials(barSpecialArray)
                
                bar = BarsTableInfo(id: businessId, name: name.capitalizedString, address: address.capitalizedString,barImage:name,special1: barSpecialArray[0], special2:barSpecialArray[1],special3: barSpecialArray[2])
                
                
            }
        }
        
    }
    
    private func getNonFeaturedBarDeals(){
        
        let days = deals[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
        
        for posts in days{
            
            let barspecial = posts["deal_name"] as! String
            var specialPrice = posts["price"] as! String
            let isFeatured = posts["featured"] as! Int
            
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
    
   private func addMoreBarSpecials(array:NSArray){
        
        for _ in 0...5{
            
            barSpecialArray.append("-")
            
        }
        
    }
    private func restructureBarInfoTable(){
        if barInfoArray.count == 0 {
            
            special = BarInfo(special1: "Sorry, no specials", special2: "-", special3: "-", special4: "-", special5: "-")
            
        } else {
            
            let number = 10 - barInfoArray.count
            
            for _ in 0...number{
                
                barInfoArray.append("-")
                
            }
            
            special = BarInfo(special1: barInfoArray[0], special2:barInfoArray[1], special3: barInfoArray[2], special4: barInfoArray[3], special5: barInfoArray[4])
        }
        
    }
    
    private func parseSpecialForWeek(){
        
        if let file = jsonFile[detailViewIndex!]["deals"] as? NSDictionary{
            
            for(var i = 0; i<daysOfWeek.count; i++){
                
                let days = file[daysOfWeek[i].lowercaseString] as! NSArray
                
                for deal in days{
                    
                    let specialForDay = deal["deal_name"] as! String
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
    
  
    
    func findTodaysSpecial(){
        if let file = jsonFile[detailViewIndex!]["deals"] as? NSDictionary{
            let days = file[dayOfTheWeek.getDayAsString().lowercaseString] as! NSArray
            var special : String?
            for posts in days{
                
                let barspecial = posts["deal_name"] as! String
                var specialPrice = posts["price"] as! String
                if barspecial != ""{
                    
                    if specialPrice == "0.00" {
                    
                    specialPrice = ""
                    special = specialPrice + barspecial
                        
                    } else {
                        
                    specialPrice = "$" + specialPrice + " "
                    special = specialPrice + barspecial
                        
                    }
                    todayArray.append(special!)
                }

                
    
                }

            if todayArray.count == 0 {
                todaysSpecial = TodaysDeal(special: "Sorry, there are no specials for today.")
                todaysSpecialArray.append(todaysSpecial)
                let message = TodaysDeal(special: "Check out the specials for the rest of the week!")
                todaysSpecialArray.append(message)
            }
            else {
            for (var i = 0 ; i < todayArray.count; i++) {
                todaysSpecial = TodaysDeal(special: todayArray[i])
                todaysSpecialArray.append(todaysSpecial)
                }

            }
            todayArray.removeAll(keepCapacity: true)
        }
    }
    
  
    
    
    //MARK: LIQUOR STORES FUNCTIONS
    
    func parseLSInfo(type:String){
        
        for posts in jsonFile {
        
            if let street = posts["company_street"] as? String{
            let city = posts["company_city"] as! String
            lsAddress = street + ", " + city
            lsAddress.capitalizedString
            lsName = posts["company_name"] as! String
            lsName.capitalizedString
            businessId = posts["id"] as! String
            lsDeals = (posts["deals"] as? NSDictionary)!
            
            if type == "lsTableView"{
            self.parseForLSSpecial()
            }
        }
        
        }
        if type == "lsDetail"{
            parseSpecialForSpecificicLiquoreStore()
        }
        
    }
    
    private func parseForLSSpecial(){
        
        let days = lsDeals["everyday"] as! NSArray
        
        for posts in days{
            
            let lsSpecial = posts["deal_name"] as! String
            var lsSpecialPrice = posts["price"] as! String
            let featuredSpecial = posts["featured"] as! Int
            
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
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName.capitalizedString, address: lsAddress.capitalizedString, lsImage: lsName, special1: "No specials", special2: "-", special3: "-")
                
                arrayOfLiquorStores.append(liquorStore)
                
            } else {
                
                addMoreLiquorSpecials(arrayOfLiquorStores)
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName.capitalizedString, address: lsAddress.capitalizedString, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            }
            
        } else {
            
            checkRegularDeals()
            
            if lsSpecialArray.count < 3 {
                
                addMoreLiquorSpecials(lsSpecialArray)
                
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName.capitalizedString, address: lsAddress.capitalizedString, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            } else {
                liquorStore = LiquorStoresInformation(id: businessId, lsName: lsName.capitalizedString, address: lsAddress.capitalizedString, lsImage: lsName, special1: lsSpecialArray[0], special2: lsSpecialArray[1], special3: lsSpecialArray[2])
                
                arrayOfLiquorStores.append(liquorStore)
                
            }
            
        }
        
    }
    
    func addMoreLiquorSpecials(array:NSArray){
        
        if array.count <= 3 {
            
            for _ in 0...5{
                
                lsSpecialArray.append("-")
                
            }
            
        }
        
    }
    
    
    private func parseSpecialForSpecificicLiquoreStore(){
        
        if let file = jsonFile[lsIndex!]["deals"] as? NSDictionary{
           
      
                let days = file["everyday"] as! NSArray
                
                for deal in days{
                    
                    let specialForDay = deal["deal_name"] as! String
                    var specialPrice = deal["price"] as! String
                    
                    if specialPrice == "0.00" {
                        
                        specialPrice = ""
                        
                    } else {
                        
                        specialPrice = "$" + specialPrice
                        
                    }
                    
                    if specialForDay != ""{
                        
                        lsSpecialArray.append(specialPrice + " " + specialForDay)
                        
                    }
                    
                }
            
                if lsSpecialArray.count == 0{
                    
                    lsSpecial = LiquorStoreDetail(special: "No Specials")
                    
                    lsDetailArray.append(lsSpecial)
                    
                    for _ in 1...5 {
                    
                        lsSpecial = LiquorStoreDetail(special: "-")
                        
                        lsDetailArray.append(lsSpecial)
                        
                    }
                    
                    
                } else {
                    
                    for (var i = 0; i < lsSpecialArray.count ; i++){
                
                        lsSpecial = LiquorStoreDetail(special: lsSpecialArray[i])
                        
                        lsDetailArray.append(lsSpecial)
                
                    }
                    
                }

                lsSpecialArray.removeAll(keepCapacity: true)
                
        }
        
    }
    
    
    func restructureLSInfoTable(){
        if lsSpecialArray.count == 0 {
            
            lsSpecial = LiquorStoreDetail(special: "-")
            
        } else {
            
            let number = 10 - lsSpecialArray.count
            
            for _ in 0...number{
                
                lsSpecialArray.append("-")
                
            }
            
            lsSpecial = LiquorStoreDetail(special: lsSpecialArray[0])
        }
        
    }
    func checkRegularDeals(){
        
        let days = lsDeals["everyday"] as! NSArray
        
        for posts in days{
            
            let lsSpecial = posts["deal_name"] as! String
            var lsSpecialPrice = posts["price"] as! String
            let featuredSpecial = posts["featured"] as! Int
            
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
            
            let street = posts["company_street"] as! String
            let city = posts["company_city"] as! String
            name = posts["company_name"] as! String
            let address = street + ", " + city
            addressArray.append(address)
            nameOfBusinessArray.append(name)
       
            
        }
        
    }
    
}