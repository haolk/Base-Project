//
//  IGDeviceInfo.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

//=======================================================
// MARK:- Screen Size
//
// SCREEN_WIDTH       : Return screen width
// SCREEN_HEIGHT      : Return screen height
// SCREEN_MAX_LENGTH  : Return Screen max length
// SCREEN_MIN_LENGTH  : Return Screen min length
// TOP_PADDING        : return screen top padding
// BOTTOM_PADDING     : return screen top padding
//=======================================================

struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let TOP_PADDING          = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    static let BOTTOM_PADDING       = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
}

//=======================================================
// MARK:- Device Type
//
// return device type
//=======================================================

struct DeviceType {
    
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPHONE_8          = IS_IPHONE_7
    static let IS_IPHONE_8P         = IS_IPHONE_7P
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPHONE_XS         = IS_IPHONE_X
    static let IS_IPHONE_XS_MAX     = IS_IPHONE_XR
    
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    static let IS_TV                = UIDevice.current.userInterfaceIdiom == .tv
    static let IS_CAR_PLAY          = UIDevice.current.userInterfaceIdiom == .carPlay
}


//=======================================================
// MARK:- Version
//
// return iOS version
//=======================================================

struct Version {
    
    static let SYS_VERSION_FLOAT    = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7                 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8                 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9                 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10                = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
    static let iOS11                = (Version.SYS_VERSION_FLOAT >= 11.0 && Version.SYS_VERSION_FLOAT < 12.0)
    static let iOS12                = (Version.SYS_VERSION_FLOAT >= 12.0 && Version.SYS_VERSION_FLOAT < 13.0)
}

struct DeviceInfo {
    
    var statusbarHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}
