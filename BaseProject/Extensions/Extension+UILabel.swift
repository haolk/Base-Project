//
//  Extension+UILabel.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

class LineLabel: UILabel {
    
    //=======================================================================
    // MARK:- Awake From NIB
    //=======================================================================

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.text = ""
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            
            self.applyCornerRadius(With: cornerRadius)
        }
    }
}


