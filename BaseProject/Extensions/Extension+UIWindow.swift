//
//  Extension+UIWindow.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

extension UIWindow {
    
    //=======================================================================
    // - retunes:  The `ViewController` which is Visible
    //=======================================================================

    public var visibleViewController: UIViewController? {
        
        return UIWindow.getVisibleViewControllerFrom(viewController: self.rootViewController)
    }
    
    //=======================================================================
    // Get  Visible `ViewController`
    // `viewController`.
    //
    // - parameter viewController:     The viewController.
    //
    // - retunes:  The `UIViewController` which is Visible
    //=======================================================================

    public static func getVisibleViewControllerFrom(viewController: UIViewController?) -> UIViewController? {
        
        if let nc = viewController as? UINavigationController {
            
            return UIWindow.getVisibleViewControllerFrom(viewController: nc.visibleViewController)
        }
        else if let tc = viewController as? UITabBarController {
            
            return UIWindow.getVisibleViewControllerFrom(viewController: tc.selectedViewController)
        }
        else {
            if let pvc = viewController?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(viewController: pvc)
            }
            else {
                return viewController
            }
        }
    }
}
