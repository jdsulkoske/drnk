//
//  TabBarViewController.swift
//  drnk
//
//  Created by Jake Sulkoske on 5/26/15.
//  Copyright (c) 2015 Sulk. All rights reserved.
//

import UIKit
import Alamofire

class TheTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //selected TabBar image color:
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        //TabBar background color:
        UITabBar.appearance().barTintColor = UIColor(red: 146/225, green: 18/225, blue: 18/225, alpha: 1)
        
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.grayColor()).imageWithRenderingMode(.AlwaysOriginal)
                
            }
        }
       
        
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension UIImage{
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}