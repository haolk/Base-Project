//
//  User.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import SwiftyJSON

class User : NSObject, NSCoding {
    
    var userId     : String = ""
    var firstname  : String = ""
    var lastname   : String = ""
    var email      : String = ""
    var gender     : GenderType.RawValue?
    var password   : String = ""
    var profilepic : String = ""
    var fullName   : String = ""
    var token      : String?
    var isNewUser  : Bool   = false
    var signupType : MembeSignInType.RawValue?
    var status     : UserVerifyType.RawValue?
    var userHomeLocation : String = ""
    var phoneNumber : String = ""
    var mobileNumber : String = ""
    var countryCode : String = ""
    //    var birthDate : String = ""
    
    override init() {
        super.init()
    }
    
    //=======================================================================
    // IGUserKey
    //
    // Contail All Key for IGUser Objecct
    //=======================================================================
    
    fileprivate class IGUserKey {
        
        static let id         = "_id"
        static let email      = "email"
        static let password   = "password"
        static let firstname  = "firstname"
        static let lastname   = "lastname"
        static let profilepic = "profilePic"
        static let gender     = "gender"
        static let token      = "token"
        static let isNewUser  = "isNewUser"
        static let fullName   = "fullName"
        static let signupType = "signupType"
        static let status     = "status"
        static let countryCode  = "countryCode"
        static let phoneNumber  = "phoneNumber"
        static let mobileNumber = "mobileNumber"
        static let birthDate    = "birthDate"
    }
    
    
    //=======================================================================
    // Init a `IGUser` Instance
    // 'parameter'.
    //
    // - parameter attributes:       The attributes. contain Data of user
    //=======================================================================
    
    required init(attributes: JSON) {
        
        super.init()
        
        self.userId            = attributes[IGUserKey.id].stringValue
        self.email             = attributes[IGUserKey.email].stringValue
        self.firstname         = attributes[IGUserKey.firstname].stringValue
        self.lastname          = attributes[IGUserKey.lastname].stringValue
        self.token             = attributes[IGUserKey.token].stringValue
        self.isNewUser         = attributes[IGUserKey.isNewUser].boolValue
        self.profilepic        = attributes[IGUserKey.profilepic].stringValue
        self.signupType        = attributes[IGUserKey.signupType].stringValue
        self.countryCode       = attributes[IGUserKey.countryCode].stringValue
        self.phoneNumber       = attributes[IGUserKey.phoneNumber].stringValue
        self.mobileNumber      = attributes[IGUserKey.mobileNumber].stringValue
        //        self.birthDate         = attributes[IGUserKey.birthDate].stringValue
        self.profilepic        = attributes[IGUserKey.profilepic].stringValue
        self.fullName          = attributes[IGUserKey.fullName].stringValue
        
        let status = attributes[IGUserKey.status].stringValue
        
        if status == UserVerifyType.active.rawValue {
            self.status        = UserVerifyType.active.rawValue
        }
        else if status == UserVerifyType.notVerified.rawValue {
            self.status        = UserVerifyType.notVerified.rawValue
        }
        else if status == UserVerifyType.verified.rawValue {
            self.status        = UserVerifyType.verified.rawValue
        }
        else if status == UserVerifyType.pending.rawValue {
            self.status        = UserVerifyType.pending.rawValue
        }
        
        let gen                = attributes[IGUserKey.gender].stringValue
        
        if gen == GenderType.male.rawValue {
            self.gender        = GenderType.male.rawValue
        }
        else if gen == GenderType.female.rawValue {
            self.gender        = GenderType.female.rawValue
        }
        else {
            self.gender        = GenderType.unspecified.rawValue
        }
    }
    
    convenience init(withData data: JSON) {
        self.init(attributes: data["profile"])
    }
    
    required init(coder decoder: NSCoder) {
        
        self.userId            = decoder.decodeObject(forKey: IGUserKey.id) as! String
        self.email             = decoder.decodeObject(forKey: IGUserKey.email) as! String
        self.password          = decoder.decodeObject(forKey: IGUserKey.password) as! String
        self.firstname         = decoder.decodeObject(forKey: IGUserKey.firstname) as! String
        self.lastname          = decoder.decodeObject(forKey: IGUserKey.lastname) as! String
        self.profilepic        = decoder.decodeObject(forKey: IGUserKey.profilepic) as! String
        self.fullName          = decoder.decodeObject(forKey: IGUserKey.fullName) as! String
        self.token             = decoder.decodeObject(forKey: IGUserKey.token) as? String
        self.isNewUser         = decoder.decodeObject(forKey: IGUserKey.isNewUser) as? Bool ?? false
        self.gender            = decoder.decodeObject(forKey: IGUserKey.gender) as? GenderType.RawValue
        self.signupType        = decoder.decodeObject(forKey: IGUserKey.signupType) as? MembeSignInType.RawValue
        self.status            = decoder.decodeObject(forKey: IGUserKey.status) as? UserVerifyType.RawValue
        self.countryCode       = decoder.decodeObject(forKey: IGUserKey.countryCode) as! String
        self.phoneNumber       = decoder.decodeObject(forKey: IGUserKey.phoneNumber) as! String
        self.mobileNumber      = decoder.decodeObject(forKey: IGUserKey.mobileNumber) as! String
    }
    
    func encode(with encoder: NSCoder) {
        
        encoder.encode(self.userId, forKey: IGUserKey.id)
        encoder.encode(self.email, forKey: IGUserKey.email)
        encoder.encode(self.password, forKey: IGUserKey.password)
        encoder.encode(self.firstname, forKey: IGUserKey.firstname)
        encoder.encode(self.lastname, forKey: IGUserKey.lastname)
        encoder.encode(self.gender, forKey: IGUserKey.gender)
        encoder.encode(self.profilepic, forKey: IGUserKey.profilepic)
        encoder.encode(self.fullName, forKey: IGUserKey.fullName)
        encoder.encode(self.token, forKey: IGUserKey.token)
        encoder.encode(self.isNewUser, forKey: IGUserKey.isNewUser)
        encoder.encode(self.signupType, forKey: IGUserKey.signupType)
        encoder.encode(self.status, forKey: IGUserKey.status)
        encoder.encode(self.countryCode, forKey: IGUserKey.countryCode)
        encoder.encode(self.phoneNumber, forKey: IGUserKey.phoneNumber)
        encoder.encode(self.mobileNumber, forKey: IGUserKey.mobileNumber)
        //        encoder.encode(self.birthDate, forKey: IGUserKey.birthDate)
    }
    
    
    //=======================================================================
    // Create fullName for user
    //
    // - returns: The created `fullname` for user
    //=======================================================================
    
    private func getFullName() -> String {
        
        if self.firstname == "" {
            return "\(self.lastname)"
        }
        else if self.lastname == "" {
            return "\(self.firstname)"
        }
        else {
            return "\(self.firstname) \(self.lastname)"
        }
    }
}
