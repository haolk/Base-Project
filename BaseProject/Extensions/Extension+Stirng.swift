//
//  Extension+Stirng.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isBlank: Bool {
        
        get {
            return trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
        }
    }

    
    var trimed: String {
        
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var isContainsNumbers: Bool {
        
        get {
            return NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self)
        }
    }
    
    var isPhoneNumber: Bool {
        
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func replace(target: String, withString: String) -> String {
        
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    func seperateUsing(_ seperator: String) -> NSArray {
        
        return self.components(separatedBy: seperator) as NSArray
    }
    
    func subString(toIndex index: Int) -> String {
        
        let index1 = self.index(self.startIndex, offsetBy: index)
        let substring1 = self[..<index1]
        return String(substring1)
    }
    
    func toDictionary() -> NSDictionary {
        
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return blankDict
    }
    
    func createAttributedString(WithForegroundColor foregroundColor: UIColor, AndFont font: UIFont) -> NSMutableAttributedString {
        
        let attributes = [NSAttributedString.Key.foregroundColor: foregroundColor, NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]
        
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        return attributedString
    }
    
    private func capitalizingFirstLetter() -> String {
        
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        
        self = self.capitalizingFirstLetter()
    }
    
    func appending(_ string: String) -> String {
        
        return self + string
    }
}

extension NSAttributedString {
    
    //=======================================================================
    // Creates a `Height` for Text using the default `width`.
    // `width`.
    //
    // - parameter width:     The width.
    //
    // - retunes:  The `CGFloat` Approx height for String in Label
    //=======================================================================
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    
    //=======================================================================
    // Creates a `Width` for Text using the default `height`.
    // `height`.
    //
    // - parameter height:     The height.
    //
    // - retunes:  The `CGFloat` Approx width for String in Label
    //=======================================================================
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
