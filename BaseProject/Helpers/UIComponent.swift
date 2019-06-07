//
//  IGUIComponent.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class UIComponent: NSObject {
    
    //=======================================================================
    // Creates a `IGUIComponent` Instance
    //
    // - returns: The created `IGUIComponent` Instance.
    //=======================================================================
    
    static let sharedInstance: UIComponent = UIComponent()
    
    // MARK:- Adding UIComponent
    
    //=======================================================================
    // Creates a `UILabel` using the default `frame`, `textAlignment`, `text`, `font`, `textColor` and `backgroundColor`
    // `frame`, `textAlignment`, `text`, `font`, `textColor` and `backgroundColor`.
    //
    // - parameter frame:             The frame.
    // - parameter textAlignment:     The textAlignment.
    // - parameter text:              The text.
    // - parameter font:              The font for text.
    // - parameter textColor:         The textColor.  `Black` by  Default.
    // - parameter backgroundColor:   The backgroundColor `Clear` by  Default.
    //
    // - returns: The created `UILabel`.
    //=======================================================================

    func addLabel(frame: CGRect, textAlignment: NSTextAlignment, text: String, font: UIFont, textColor: UIColor = AppColor.Black, backgroundColor: UIColor = AppColor.Clear) -> UILabel {
        
        let label                = UILabel(frame: frame)
        label.textAlignment      = textAlignment
        label.text               = text
        label.textColor          = textColor
        label.font               = font
        label.backgroundColor    = backgroundColor
        
        return label
    }
    
    
    //=======================================================================
    // Creates a `UIButton` using the default `frame`, `text`, `font`, `textColor` `backgroundColor` and `tintColor`
    // `frame`, `text`, `font`, `textColor` and `backgroundColor`.
    //
    // - parameter frame:             The frame.
    // - parameter text:              The text.
    // - parameter font:              The font for text.
    // - parameter textColor:         The textColor.  `Black` by  Default.
    // - parameter backgroundColor:   The backgroundColor `Clear` by  Default.
    // - parameter tintColor:         The tintColor

    //
    // - returns: The created `UIButton`.
    //=======================================================================

    func addButton(frame: CGRect, text: String, font: UIFont, textColor: UIColor = AppColor.Black, backgroundColor: UIColor = AppColor.Clear, tintColor : UIColor) -> UIButton {
        
        let button: UIButton     = UIButton(frame: frame)
        button.backgroundColor   = backgroundColor
        button.titleLabel?.font  = font
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        return button
    }
    
    func addImageView(frame: CGRect, url: String, placeHolderImage image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        
        let urlstring = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        
        imageView.sd_setImage(with: URL(string: urlstring!), placeholderImage: image) { (image, error, carchType, url)  in
            
            if error == nil {
                imageView.contentMode = .scaleAspectFill
            }
        }
        
        return imageView
    }
}
