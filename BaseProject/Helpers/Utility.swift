//
//  IGUtill.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import SwiftyJSON


class Utility {

    //=======================================================================
    // Creates a `Utility` Instance
    //
    // - returns: The created `Utility` Instance.
    //=======================================================================

    static let shared: Utility = Utility()    
    
    //=======================================================================
    // Prepare User
    //
    // Prepare user and set Screen according to user signin status
    //=======================================================================
    
    func prepareUser() {
        
        if UserDefaultModel.shared.isSignIn() {
            
        }
        
        if UserDefaultModel.shared.isIntroduceApp() {
            
//            UIView.animate(withDuration: 0.0, animations: {
//                
//                let tabbar = UIStoryboard.main.instantiateViewController(withIdentifier: "IGIndigoTabBarViewController") as! IGIndigoTabBarViewController
//                tabbar.selectedIndex = 2
//                IGAppDelegate.window?.rootViewController = tabbar
//                IGAppDelegate.window!.makeKeyAndVisible()
//            }, completion: nil)
        }
        else {
            
//            AppDeli.window?.rootViewController = UIStoryboard.login.instantiateInitialViewController()
        }
    }
    
    //=======================================================================
    // Prepare Third Party Library
    //
    // Prepare Third Party Library Setup
    //=======================================================================

    func prepareThirdParty() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    
    //=======================================================================
    // Show Progress HUD using isShow status
    // `isShow`.
    //
    // - parameter isShow:       The isShow, status for progress bar
    //
    //=======================================================================

    func isShowProgressHUD(_ isShow: Bool) {
        
        if isShow {
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
        else {
            SVProgressHUD.dismiss()
        }
    }
}

