//
//  Extension+UITextField.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    //=======================================================================
    // Creates a `PlaceHolderText` using the default `text` and `color`.
    // `text` and `color`.
    //
    // - parameter text:     The text.
    // - parameter color:    The color.
    //
    //=======================================================================

    func setPlaceholderWith(text : String, andColor color: UIColor) {
        
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    //=======================================================================
    // Create a line using `CALayer`
    //=======================================================================
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    //=======================================================================
    // Set Corner Radius
    //=======================================================================
    
    func cornerRadius() {
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    //=======================================================================
    // Set Border Color
    //=======================================================================
    
    func borderColor(){
        
        self.layer.borderWidth = 1.0
    }
    
    
    //=======================================================================
    // Set Border Width
    //=======================================================================
    
    func borderWidth(size:CGFloat){
        
        self.layer.borderWidth = size
    }
    
    
    //=======================================================================
    // - returns: The created `Bool` String blank.
    //=======================================================================
    
    func blank() -> Bool {
        
        return self.text!.isBlank
    }
    
    
    //=======================================================================
    // Creates a `Left Padding` using the default paddingValue.
    // `paddingValue`.
    //
    // - parameter paddingValue:             The paddingValue.
    //
    //=======================================================================

    func setLeftPadding(paddingValue:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    
    //=======================================================================
    // Creates a `Right Padding` using the default paddingValue.
    // `paddingValue`.
    //
    // - parameter paddingValue:             The paddingValue.
    //
    //=======================================================================

    func setRightPadding(paddingValue:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: (self.frame.size.width - paddingValue), y: 0, width: paddingValue, height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = paddingView
    }
    
    
    //=======================================================================
    // Update a `UITextField` using the default base64 `keyboardType`, `returnKey` and `secureTextEntry`.
    // `keyboardType`, `returnKey` and `secureTextEntry`.
    //
    // - parameter keyboardType:          The keyboardType. `default` by default.
    // - parameter returnKey:             The strEncodeData. `done` by default.
    // - parameter secureTextEntry:       The secureTextEntry. `false` by default.
    //
    //=======================================================================

    func updateProperty(keyboardType: UIKeyboardType = .default, returnKey: UIReturnKeyType = .done, secureTextEntry: Bool = false)  {
        
        self.keyboardType             = keyboardType
        self.returnKeyType            = returnKey
        self.isSecureTextEntry        = secureTextEntry
        self.autocorrectionType       = .no
        self.spellCheckingType        = .no
    }
    
    func removeValue() {
        
        self.text = ""
    }
    
    func validateCreditCardFormat()-> (type: CardType, valid: Bool) {
        
        // Get only numbers from the input string
        let input = self.text!
        
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "")
        
        //        let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(number: numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly {
            
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        
        formatted += formatted4 // the rest
        
        // return the tuple
        return (type, valid)
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        }
        catch {
            return false
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        
        let digitStrings = number.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            
            guard let digit = Int(tuple.element) else { return false }
            
            let odd = tuple.offset % 2 == 1
            
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
}



extension UITextView {

    //=======================================================================
    // Update a `UITextView` using the default base64 `keyboardType` and `returnKey`.
    // `keyboardType`, `returnKey` and `secureTextEntry`.
    //
    // - parameter keyboardType:          The keyboardType. `default` by default.
    // - parameter returnKey:             The strEncodeData. `done` by default.
    //
    //=======================================================================

    func updateProperty(keyboardType: UIKeyboardType = .default, returnKey: UIReturnKeyType = .done)  {
        
        self.keyboardType             = keyboardType
        self.returnKeyType            = returnKey
        self.autocorrectionType       = .no
        self.spellCheckingType        = .no
    }
}

