//
//  Extension+UIColor.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(fromHex:Int, alpha: CGFloat = 1.0) {
        self.init(red:(fromHex >> 16) & 0xff, green:(fromHex >> 8) & 0xff, blue:fromHex & 0xff,alpha: alpha)
    }
}
