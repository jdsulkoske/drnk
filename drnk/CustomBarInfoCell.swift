//
//  BarInfoCustomTableView.swift
//  drnk
//
//  Created by faris shatat on 6/20/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import Foundation


class CustomBarInfoCell : UITableViewCell{
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var special1: UILabel!
    @IBOutlet weak var special2: UILabel!
    @IBOutlet weak var special3: UILabel!
    @IBOutlet weak var special4: UILabel!
    @IBOutlet weak var special5: UILabel!
    class var expandingHeight: CGFloat { get { return 240} }
    class var defaultHeight: CGFloat { get { return 44 } }

    

    
    func checkHeight(){
        special1.hidden = (frame.size.height < CustomBarInfoCell.expandingHeight)
        special2.hidden = (frame.size.height < CustomBarInfoCell.expandingHeight)
        special3.hidden = (frame.size.height < CustomBarInfoCell.expandingHeight)
        special4.hidden = (frame.size.height < CustomBarInfoCell.expandingHeight)
        special5.hidden = (frame.size.height < CustomBarInfoCell.expandingHeight)

        
    }
    
    func watchFrameChanges(){
        checkHeight()
       NSNotificationCenter.defaultCenter().addObserver(self, forKeyPath: "frame", options: .New, context: nil)

        
    }
    
    func ignoreFrameChanges(){
        NSNotificationCenter.defaultCenter().removeObserver(self, forKeyPath: "frame")

    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame"{
            checkHeight()
    }
}

    
        
}