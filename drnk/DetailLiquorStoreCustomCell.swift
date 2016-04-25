//
//  File.swift
//  drnk
//
//  Created by drnk LLC on 7/10/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
//

import Foundation

class DetailLiquoreStoreCustomCell: UITableViewCell{
    
    @IBOutlet weak var special: UILabel!
    
    func setLiquorStoreCell(special: String){
        
        self.special.text = special
        
    }
    
}