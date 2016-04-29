//
//  CustomBarTableViewCell.swift
//  drnk
//
//  Created by drnk LLC on 5/25/15.
//  Copyright (c) 2015 drnk LLC. All rights reserved.
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
        special1.numberOfLines = 1;
        special1.minimumScaleFactor = 0.5;
        special1.adjustsFontSizeToFitWidth = true;
        
        special2.numberOfLines = 1;
        special2.minimumScaleFactor = 0.5;
        special2.adjustsFontSizeToFitWidth = true;
        
        special3.numberOfLines = 1;
        special3.minimumScaleFactor = 0.5;
        special3.adjustsFontSizeToFitWidth = true;
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCell(nameOfBarText: String, addressOfBarText: String, image: String,special1:String,special2:String,special3:String){
        
        self.nameOfBar.text = nameOfBarText
        self.addressOfBar.setTitle(addressOfBarText, forState: UIControlState.Normal)
        self.special1.text = special1
        self.special2.text = special2
        self.special3.text = special3
        self.barImage.image = UIImage(named: image)
        self.barImage.layer.cornerRadius = CGRectGetWidth(self.barImage.frame)/4
        self.barImage.layer.masksToBounds = true
        self.barImage.layer.borderWidth = 1.0
    
    }

}
