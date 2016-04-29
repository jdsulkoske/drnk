//
//  BarsInformation.swift
//  drnk
//
//  Created by drnk LLC on 5/25/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import Foundation

class BarsTableInfo{
    
    var barArray: [BarsTableInfo] = [BarsTableInfo]()
    var name = "Brother's Bar and Grill"
    var address = "Adress of Brother's Bar and Grill, Muncie, IN"
    var barImage = ""
    var special1 = "Special 1"
    var special2 = "Special 2"
    var special3 = "Special 3"
    var businessId = ""
    
    init(id: String, name: String, address: String, barImage: String, special1:String,special2:String, special3:String){
        
        self.name = name
        self.address = address
        self.barImage = generateImage(id)
        self.special1 = special1
        self.special2 = special2
        self.special3 = special3
        
    }
    
    func appendBar(bar:BarsTableInfo){
        
        barArray.append(bar)
        
    }
    
    func getBarArray()->NSArray{
        
        return barArray
        
    }
    
    func generateImage(businessId: String)->String{
        
        var imageString = businessId
        
        switch imageString{
            
        case "35":
            
            imageString = "brothersImage"
            
            
        case "45":
            
            imageString = "BeHereNow"
            
        case "44":
            
            imageString = "TheChug"
            
        case "48":
            
            imageString = "Scottys"
        
        case "40":
            
            imageString = "heorot"
            
        case "43":
            
            imageString = "savages"
            
        case "46":
            
            imageString = "fickle"
            
        case "47":
            
            imageString = "amazing"
            
        case "49":
            
            imageString = "puerta"
            
        default:
            
            imageString = "drnkLogo"
            
        }
        
        return imageString
        
    }
    
}