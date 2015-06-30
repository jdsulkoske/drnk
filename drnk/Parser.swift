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
    
    init(jsonFile:NSArray){
        self.jsonFile = jsonFile
    }
    
    
    
    func parseBarInfo(){
        if jsonFile != nil{
        for posts in jsonFile {
            var address = posts["company_street"] as! String
            var name = posts["company_name"] as! String
            bar = BarsInformation(name: name, address: address,barImage:"VCImage.png")
            arrayOfBars.append(bar)
        }
        } else {
            var error = "Could not connect to server!"
            bar = BarsInformation(name: error, address: "NA", barImage: "redsolocupicon.png")
            arrayOfBars.append(bar)
        }
        
    }
}