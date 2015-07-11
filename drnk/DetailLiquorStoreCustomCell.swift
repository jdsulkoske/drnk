//
//  File.swift
//  drnk
//
//  Created by faris shatat on 7/10/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class DetailLiquoreStoreCustomCell: UITableViewCell{
    
    @IBOutlet weak var special: UILabel!
    
    func setLiquorStoreCell(special: String){
        
        self.special.text = special
        
    }
    
}