//
//  CustomLiquorStoresTableViewCell.swift
//  drnk
//
//  Created by drnk LLC on 6/6/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
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
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
    func setLiquorStoreCell(nameLabel: String, addressLabel: String, image: String,special1:String,special2:String,special3:String) {
        
        self.nameOfLiquorStore.text = nameLabel
        self.addressOfLiquorStore.setTitle(addressLabel, forState: UIControlState.Normal)
        self.lsSpecialOne.text = special1
        self.lsSpecialTwo.text = special2
        self.lsSpecialThree.text = special3
        self.imageOfLiquorStore.image = UIImage(named: image)
        self.imageOfLiquorStore.layer.cornerRadius = CGRectGetWidth(self.imageOfLiquorStore.frame)/2.5
        self.imageOfLiquorStore.layer.masksToBounds = true
        self.imageOfLiquorStore.layer.borderWidth = 1.0


        
    }

}
