//
//  BaseButton.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.3 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = AppColor.Clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    public var isActive: Bool = false
}

@IBDesignable
class ToggleButton: BaseButton {
    
    override var isSelected: Bool {
        
        didSet {
            
            if isSelected {
                
                self.setTitleColor(AppColor.White, for: .normal)
                self.backgroundColor = AppColor.Blue
            }
            else {
                
                self.setTitleColor(AppColor.Blue, for: .normal)
                self.backgroundColor = AppColor.White
            }
        }
    }
    
    override var isActive: Bool {
        
        didSet {
            
            if isActive {
                
                self.setTitleColor(AppColor.White, for: .normal)
                self.backgroundColor = AppColor.Blue
                self.isUserInteractionEnabled = true
            }
            else {
                
                self.setTitleColor(AppColor.White, for: .normal)
                self.backgroundColor = AppColor.Gray
                self.isUserInteractionEnabled = false
            }
        }
    }
}
