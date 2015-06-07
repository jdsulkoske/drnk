//
//  LiquorStoresInformation.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/6/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class LiquorStoresInformation {
    var liquorStoreName = ""
    var address = ""
    var liquorStoreImage = ""
    
    init(lsName: String, address: String, lsImage: String) {
        self.liquorStoreName = lsName
        self.address = address
        self.liquorStoreImage = lsImage
    }
}