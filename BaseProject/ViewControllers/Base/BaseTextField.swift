//
//  BaseTextField.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    //=======================================================================
    // MARK:- Init Methods
    //=======================================================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = AppColor.White
        self.tintColor = AppColor.White
        self.font      = Helper.setFont(WithFontFamily: Font.Montserrat_Regular, AndFontSize: 17.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tintColor = AppColor.White
        self.textColor = AppColor.White
        self.font      = Helper.setFont(WithFontFamily: Font.Montserrat_Regular, AndFontSize: 17.0)
    }
    
    
    //=======================================================================
    // MARK:- Public Methods
    //=======================================================================
    
    
    //=======================================================================
    // Change Line frame while update slider selection value using `color`
    // `color`.
    //
    // - parameter color:     The color.
    //
    //=======================================================================
    
    func setPlaceHolderColor(_ color : UIColor) {
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    //=======================================================================
    // Update Font
    //=======================================================================
    
    func useDefaultFont() {
        
        self.font = Helper.setFont(WithFontFamily: Font.Montserrat_Regular, AndFontSize: 17.0)
    }
}
