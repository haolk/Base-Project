//
//  Validation.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class Validation: NSObject {
    
    
    //=======================================================================
    // Creates a `Validation` Instance
    //
    // - returns: The created `Validation` Instance.
    //=======================================================================
    
    static let shared: Validation =  Validation()
    
    //=======================================================================
    // Creates Bool for Email is Valid or not
    // `email`.
    //
    // - parameter email:       The email String
    //
    // - returns: The created `Bool` for Email valid or not.
    //=======================================================================

    class func isValidEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    //=======================================================================
    // Creates Bool for Email is Valid or not
    // `lhs` and `rhs`.
    //
    // - parameter lhs:       The lhs String
    // - parameter rhs:       The rhs String
    //
    // - returns: The created Result for both Password
    //=======================================================================

    class func isBothPasswordSame( _ lhs :String, _ rhs: String) -> Bool {
        
        if lhs == rhs {
            return true
        }
        
        return false
    }
    
    
    //=======================================================================
    // Creates Bool for Phone Number is Valid or not
    // `phoneNumber`.
    //
    // - parameter phoneNumber:       The phoneNumber String
    //
    // - returns: The created `Bool` for Phone Number valid or not.
    //=======================================================================
    
    class func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        
        let charcterSet  = NSCharacterSet(charactersIn: "0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        
        return phoneNumber == filtered
    }
    
    //=======================================================================
    // Check password Range
    // `password`.
    //
    // - parameter password:       The password String
    //
    // - returns: The created `Bool` for password range valid or not.
    //=======================================================================
    
    class func isPasswordNotInRange(_ password: String) -> Bool {
        
        if !(password.count > MinimumPasswordLength &&  password.count < MaximumPasswordLength) {
            return true
        }
        
        return false
    }
    
    //=======================================================================
    // Check String contains Space or Not Range using `str`
    // `password`.
    //
    // - parameter password:       The password String
    //
    // - returns: The created `Bool` for String Contains White Space.
    //=======================================================================
    
    class func isContainsWhiteSpace(_ str: String) -> Bool {
        
        if !str.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    
    //=======================================================================
    // Check phoneNumber Range
    // `phoneNumber`.
    //
    // - parameter phoneNumber:       The phoneNumber String
    //
    // - returns: The created `Bool` for phoneNumber range valid or not.
    //=======================================================================
    
    class func isPhoneNumberNotInRange(_ phoneNumber: String) -> Bool {
        
        if !(phoneNumber.count >= 7 &&  phoneNumber.count <= 12) {
            return true
        }
        
        return false
    }
    
}


extension Validation {
    
    class func isEmailReady(_ textField: UITextField) -> (Bool, String) {
        
        if textField.text!.isBlank {
            
            textField.text = ""
            return (false, AlertMessage.emailAlert)
        }
        else if !Validation.isValidEmail(textField.text!)  {
            
            return (false, AlertMessage.emailValidAlert)
        }
        else {
            
            return (true, "")
        }
    }
    
    class func isPasswordReady(_ textField: UITextField, passwordType: PasswordType) -> (Bool, String) {
        
        if textField.text!.isBlank {
            
            textField.text = ""
            
            switch passwordType {
                
            case .normal:
                return (false, AlertMessage.passwordAlert)
            case .old:
                return (false, AlertMessage.oldPasswordAlert)
            case .new:
                return (false, AlertMessage.newPasswordAlert)
            case .confirm:
                return (false, AlertMessage.confirmPasswordAlert)
            }
        }
        else if Validation.isContainsWhiteSpace(textField.text!) {
            
            return (false, AlertMessage.passwordValidAlert)
        }
        else if Validation.isPasswordNotInRange(textField.text!) {
            
            return (false, AlertMessage.passwordRangeAlert)
        }
        else {
            
            return (true, "")
        }
    }
    
    class func isReadyPhoneNumber(_ textField: UITextField) -> (Bool, String) {
        
        if textField.text!.isBlank {
            
            textField.text = ""
            return (false, AlertMessage.phoneNumberAlert)
        }
        else if !(Validation.isValidPhoneNumber(textField.text!)) {
            
            return (false, AlertMessage.phoneNumberValidAlert)
        }
        else if (Validation.isPhoneNumberNotInRange(textField.text!)) {
            
            return (false, AlertMessage.phoneNumberValidAlert)
        }
        else {
            
            return (true, "")
        }
    }
}
