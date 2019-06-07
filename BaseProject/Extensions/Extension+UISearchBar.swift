//
//  Extension+UISearchBar.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    //=======================================================================
    // - retunes:  The `UITextField` From UISearchBar
    //=======================================================================

    func getTextField()-> UITextField {
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            textfield.tag = 1
            return textfield
        }
        
        return UITextField()
    }
    
    //=======================================================================
    // Change SearchBar Color
    //=======================================================================

    func changeSearchBarColor(_ color : UIColor) {
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = color
            }
        }
    }
    
    //=======================================================================
    // Creates a `CornerRadius` of UISearchBar using the default `radius`.
    // `radius`.
    //
    // - parameter radius:     The radius.
    //
    //=======================================================================

    func setCornerRadius(_ radius : CGFloat) {
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            if let backgroundview = textfield.subviews.first {
                
                backgroundview.layer.cornerRadius = radius
                backgroundview.clipsToBounds = true;
            }
        }
    }
    
    
    //=======================================================================
    // Creates a `borderWidth` and `borderColor` UISearchBar using the default `borderWidth` and `borderColor`.
    // `borderWidth` and `borderColor`.
    //
    // - parameter borderWidth:     The borderWidth.
    // - parameter borderColor:     The borderColor.
    //
    //=======================================================================
    
    func setBorderWidth(_ borderWidth : CGFloat, AndBorderColor borderColor: UIColor) {
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            if let backgroundview = textfield.subviews.first {
                
                backgroundview.layer.borderWidth = borderWidth
                backgroundview.layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    //=======================================================================
    // Set Font of UISearchBar.
    //=======================================================================

    func setFont(_ font: UIFont) {
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.font = font
        }
    }
    
    //=======================================================================
    // Change SearchBar TintColor
    //=======================================================================

    func changeSearchiConTintColor( _ color: UIColor){
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            let imageV = textfield.leftView as! UIImageView
            imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            imageV.tintColor = color
        }
    }
}





