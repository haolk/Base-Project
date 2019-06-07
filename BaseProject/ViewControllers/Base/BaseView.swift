//
//  BaseView.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class BaseShadowView: BaseBorderView {
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            if shadowRadius != 0 {
                
                layer.shadowColor   = AppColor.Gray.cgColor
                layer.shadowOffset  = CGSize(width: 0, height: 0)
                layer.shadowOpacity = 0.35
                layer.shadowRadius  = shadowRadius
            }
        }
    }
}

class BaseBorderView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = AppColor.Clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class RoundCornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = false
        }
    }
}
