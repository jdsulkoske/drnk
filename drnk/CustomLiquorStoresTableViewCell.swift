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
    @IBOutlet weak var lsSpecialOne: UILabel!
    @IBOutlet weak var lsSpecialTwo: UILabel!
    @IBOutlet weak var lsSpecialThree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLiquorStoreCell(nameLabel: String, addressLabel: String, image: String,special1:String,special2:String,special3:String) {
        self.nameOfLiquorStore.text = nameLabel
        self.addressOfLiquorStore.setTitle(addressLabel, forState: UIControlState.Normal)

        self.lsSpecialOne.text = special1
        self.lsSpecialTwo.text = special2
        self.lsSpecialThree.text = special3
        self.imageOfLiquorStore.image = UIImage(named: image)
        
    }

}
