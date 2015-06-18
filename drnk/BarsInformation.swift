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
    
    init(name: String, address: String, barImage: String){
        self.name = name
        self.address = address
        self.barImage = barImage
    }
    
    func appendBar(bar:BarsInformation){
        barArray.append(bar)
    }
    
    func getBarArray()->NSArray{
        return barArray
    }
    
}