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
   
    @IBOutlet weak var addressOfBar: UIButton!
   
    @IBOutlet weak var barImage: UIImageView!

    @IBOutlet weak var special1: UILabel!
    
    @IBOutlet weak var special2: UILabel!
    
    @IBOutlet weak var special3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(nameOfBarText: String, addressOfBarText: String, image: String,special1:String,special2:String,special3:String){
        self.nameOfBar.text = nameOfBarText
        self.addressOfBar.setTitle(addressOfBarText, forState: UIControlState.Normal)
    
        self.special1.text = special1
        self.special2.text = special2
        self.special3.text = special3
        self.barImage.image = UIImage(named: image)
    
        
        
    }

}
