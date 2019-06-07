//
//  Helper.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class Helper: NSObject {

    
    //=======================================================================
    // Creates a `Helper` Instance
    //
    // - returns: The created `Helper` Instance.
    //=======================================================================
    
    static let shared: Helper = Helper()
    
    //=======================================================================
    // Creates a `UIFont` using the default `fontSize` and `fotnweight`
    // `size` and `weight`.
    //
    // - parameter size:       The size .
    // - parameter weight:     The weight
    //
    // - returns: The created `UIFont`.
    //=======================================================================
    
    class func setSystenFontOfSize(_ size: CGFloat , fontweight weight: UIFont.Weight) -> UIFont {
        
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    
    //=======================================================================
    // Creates a `UIFont` using the default `family` and `fontSize`
    // `family` and `fontSize`.
    //
    // - parameter family:       The family.
    // - parameter fontSize:     The fontSize.
    //
    // - returns: The created `UIFont`.
    //=======================================================================
    
    class func setFont(WithFontFamily family: String, AndFontSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: family, size: fontSize)!
    }
    
    //=======================================================================
    // Creates a `Label Height` using the default `text`, `font` and `width`
    // `text`, `font` and `width`.
    //
    // - parameter text:      The text string.
    // - parameter font:      The font
    // - parameter width:     The width, max width for label
    //
    // - returns: The created `Max Height for Label`.
    //=======================================================================
    
    func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    //=======================================================================
    // Creates a `Label Size` using the default `text` and `font`
    // `text` and `font`.
    //
    // - parameter text:      The text string.
    // - parameter font:      The font
    //
    // - returns: The created `Size for Label`.
    //=======================================================================

    func sizeForLabel(text: String, font: UIFont) -> CGSize {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.size
    }
    
    //=======================================================================
    // Creates a `Label Width` using the default `text`, `font` and `height`
    // `text`, `font` and `height`.
    //
    // - parameter text:      The text string.
    // - parameter font:      The font
    // - parameter height:     The height, max height for label
    //
    // - returns: The created `Max Width for Label`.
    //=======================================================================

    func widthForLabel(text:String, font: UIFont, height: CGFloat) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.width
    }
    
    //=======================================================================
    // Creates a `Random String` using number
    // `number`.
    //
    // - parameter number:      The number. count for String
    //
    // - returns: The created `String` Randomly.
    //=======================================================================

    func getRandomString(ofNumber number: Int) -> String {
        
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var returnedString = ""
        
        for _ in 0..<number  {
            
            let r = Int(arc4random_uniform(UInt32(str.count)))
            returnedString += String(str[str.index(str.startIndex, offsetBy: r)])
        }
        
        return returnedString
    }   
}
