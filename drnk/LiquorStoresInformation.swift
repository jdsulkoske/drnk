//
//  LiquorStoresInformation.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/6/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class LiquorStoresInformation {
    
    var lsArray: [LiquorStoresInformation] = [LiquorStoresInformation]()
    var liquorStoreName = ""
    var address = ""
    var liquorStoreImage = ""
    var special1 = "Special 1"
    var special2 = "Special 2"
    var special3 = "Special 3"
    var businessId = ""
    
    init(id: String, lsName: String, address: String, lsImage: String, special1:String,special2:String, special3:String) {
        
        self.liquorStoreName = lsName
        self.address = address
        self.liquorStoreImage = generateImage(id)
        self.special1 = special1
        self.special2 = special2
        self.special3 = special3
        
    }
    
    func appendLS(ls:LiquorStoresInformation){
        
        lsArray.append(ls)
        
    }
    
    func getLSArray()->NSArray{
        
        return lsArray
        
    }
    
    func generateImage(businessId: String)->String{
        
        var imageString = businessId
        
        switch imageString{
            
        case "3":
                
            imageString = "friendly.png"
            
        case "6":
            
            imageString = "municeLiquors"
        
        default:
            
            imageString = "cupIcon"
            
        }
        
        return imageString
        
    }
    
    
    
}