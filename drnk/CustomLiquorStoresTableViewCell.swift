//
//  CustomLiquorStoresTableViewCell.swift
//  drnk
//
//  Created by Jake Sulkoske on 6/6/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit

class CustomLiquorStoresTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfLiquorStore: UILabel!
    @IBOutlet weak var imageOfLiquorStore: UIImageView!
   
    @IBOutlet weak var addressOfLiquorStore: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLiquorStoreCell(nameLabel: String, addressLabel: String, image: String) {
        self.nameOfLiquorStore.text = nameLabel
        self.addressOfLiquorStore.setTitle(addressLabel, forState: UIControlState.Normal)

        self.imageOfLiquorStore.image = UIImage(named: image)
        
    }

}
