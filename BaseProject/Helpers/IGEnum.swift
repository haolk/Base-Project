//
//  IGEnum.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation

//=======================================================================
// Gender Type
//=======================================================================

public enum GenderType: String {
    
    case unspecified = "unspecified"
    case male        = "Male"
    case female      = "Female"
}

//=======================================================================
// IGMembeSignInType
//=======================================================================

public enum MembeSignInType: String {
    
    case none    = "none"
    case email   = "Email"
    case social  = "Social"
}


//=======================================================================
// IGUserVerifyType
//=======================================================================

enum UserVerifyType: String {
    
    case pending = "Pending"
    case notVerified = "NotVerified"
    case verified = "Verified"
    case active = "Active"

}

//=======================================================================
// IGServerType
//=======================================================================

enum ServerType {
    
    case local
    case live
    case none
}

//=======================================================================
// MontserratFontType
//=======================================================================

enum MontserratFontType: String {
    
    case Black            = "Montserrat-Black"
    case BlackItalic      = "Montserrat-BlackItalic"
    case Bold             = "Montserrat-Bold"
    case BoldItalic       = "Montserrat-BoldItalic"
    case ExtraBold        = "Montserrat-ExtraBold"
    case ExtraBoldItalic  = "Montserrat-ExtraBoldItalic"
    case ExtraLight       = "Montserrat-ExtraLight"
    case ExtraLightItalic = "Montserrat-ExtraLightItalic"
    case Italic           = "Montserrat-Italic"
    case Light            = "Montserrat-Light"
    case LightItalic      = "Montserrat-LightItalic"
    case Medium           = "Montserrat-Medium"
    case MediumItalic     = "Montserrat-MediumItalic"
    case Regular          = "Montserrat-Regular"
    case SemiBold         = "Montserrat-SemiBold"
    case SemiBoldItalic   = "Montserrat-SemiBoldItalic"
    case Thin             = "Montserrat-Thin"
    case ThinItalic       = "Montserrat-ThinItalic"
}

//=======================================================================
// Gradient Color Enum
//=======================================================================

enum GradientDirectionType : String {
    
    case leftToRight = "leftToRight"
    case leftCornerToRightCorner = "leftCornerToRightCorner"
    case topToBottom = "topToBottom"
}

//=======================================================================
// IGPasswordType
//=======================================================================

enum PasswordType {
    
    case normal
    case old
    case new
    case confirm
}

//=======================================================================
// IGCardType
//=======================================================================

enum IGCardType {
    
    case visa
    case master
    case none
}

//=======================================================================
// CardType
//=======================================================================

enum CardType: String {
    
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        default:
            return ""
        }
    }
}

//=======================================================================
// IGStarType
//=======================================================================

enum IGStarType {
    
    case yellow
    case white
    case gray
    case none
}

