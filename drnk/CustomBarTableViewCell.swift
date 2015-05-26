//
//  CustomBarTableViewCell.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/25/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class CustomBarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOfBar: UILabel!
    @IBOutlet weak var addressOfBar: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(nameOfBarText: String, addressOfBarText: String){
        self.nameOfBar.text = nameOfBarText
        self.addressOfBar.text = addressOfBarText
        
    }

}
