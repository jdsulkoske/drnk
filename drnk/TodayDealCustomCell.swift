//
//  TodayDealCustomCell.swift
//  drnk
//
//  Created by faris shatat on 7/11/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation

class TodayDealCustomCell: UITableViewCell{
    
    @IBOutlet weak var special: UILabel!
    
    func setCell(special:String){
        self.special.text = special
    }
}