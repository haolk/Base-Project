//
//  Constant.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

let AppDeli                       = UIApplication.shared.delegate as! AppDelegate
let UserDefault                   = UserDefaults.standard
let DefaultFileManager            = FileManager.default
let SharedAPIManager              = APIManager.shared
let CurrentServer                 = ServerType.live
let IsRemoveDummyData      : Bool = false
let locationManager               = LocationManager.shared

var baseUrl: String {
    
    switch CurrentServer {
    case .live: return ""
    case .local: return ""
    case .none: return ""
    }
}

struct Google {
    
    static let API_KEY = ""
    static let CLIENT_KEY = ""
}

let MinimumPasswordLength      : Int     = 8
let MaximumPasswordLength      : Int     = 16
var customViewInitialScaleAmmount: CGFloat    = 0.7
var customViewAnimationDuration: TimeInterval = 0.5
var popUpViewAnimationDuration: TimeInterval  = 0.5


var AppName      : String { return "Base Project" }
var AppVersion   : String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""}
var buildVersion : String { return Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""}
var iOSString    = "ios"

var AppDisplayName: String {
    
    if let infoDict = Bundle.main.infoDictionary, let displayName = infoDict[kCFBundleNameKey as String] as? String {
        return displayName
    }
    else {
        return ""
    }
}
