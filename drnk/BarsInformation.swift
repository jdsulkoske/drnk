//
//  BarsInformation.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class BarsInformation{
    var barArray: [BarsInformation] = [BarsInformation]()
    var name = "Brother's Bar and Grill"
    var address = "Adress of Brother's Bar and Grill, Muncie, IN"
    var barImage = ""
    var special1 = "Special 1"
    var special2 = "Special 2"
    var special3 = "Special 3"
    
    init(name: String, address: String, barImage: String, special1:String,special2:String, special3:String){
        self.name = name
        self.address = address
        self.barImage = barImage
        self.special1 = special1
        self.special2 = special2
        self.special3 = special3
    }
    
    func appendBar(bar:BarsInformation){
        barArray.append(bar)
    }
    
    func getBarArray()->NSArray{
        return barArray
    }
    
}