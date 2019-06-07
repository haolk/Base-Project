//
//  BaseViewController.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //=======================================================================
    // MARK:- Override
    //=======================================================================
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //=======================================================================
    // MARK:- View Delegate
    //=======================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.setDesignLayout()
        self.setBasicData()
    }
    
    // MARK:- Public Methods
    
    //=======================================================================
    // Creates a `navigationItem` using the default `image` or `title`
    // `image` and `title`.
    //
    // - parameter image:     The image .
    // - parameter title:     The title. `""` by Default
    //
    //=======================================================================
    
    func addRightBarButtonItem(withImage image: UIImage, title: String = "") {
        
        var button = UIBarButtonItem()
        
        if title == "" {
            
            button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.rightButtonBarButtonAction(_:)))
        }
        else{
            button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.rightButtonBarButtonAction(_:)))
        }
        
        button.tintColor = AppColor.Black
        self.navigationItem.rightBarButtonItem  = button
    }
    
    
    func hideBackButton() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    //=======================================================================
    // Creates a `navigationItem` using the default `color` or `isTitle`, is same as back button
    // `color` and `isTitle`.
    //
    // - parameter color:       The color.  `Black` by Default`
    // - parameter isTitle:     The isTitle.
    //
    //=======================================================================
    
    func addBackButton(WithTitleColor color: UIColor = AppColor.Black, isTitle: Bool) {
        
        var frame : CGRect?
        var title = String()
        let font = Helper.setSystenFontOfSize(16, fontweight: .medium)
        
        if isTitle {
            
            title = "  Back"
            frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        }
        else {
            
            title = ""
            frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        }
        
        let btn = UIComponent.sharedInstance.addButton(frame: frame!, text:title , font: font, textColor: color, backgroundColor: AppColor.Clear, tintColor: color)
        
        btn.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        btn.addTarget(self, action: #selector(self.leftBarButtonItemAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    //=======================================================================
    // Update `NavigationBar` using the default `tintColor`, `textColor` and `font`
    // `tintColor`, `textColor` and `font`
    //
    // - parameter tintColor:     The tintColor.
    // - parameter textColor:     The textColor.
    // - parameter font:          The font.
    //
    //=======================================================================
    
    func setNavigationBarWith(tintColor: UIColor, textColor: UIColor , font: UIFont) {
        
        self.navigationController?.navigationBar.barTintColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:textColor, NSAttributedString.Key.font: font]
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    
    //=======================================================================
    // Update `NavigationBar` color as Clear Color
    //=======================================================================
    
    func setNavigationBarClear() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    
    //=======================================================================
    // Set Main TabBar as window screen
    //=======================================================================
    
    public func setMainTabBar(_ index: Int = 0) {
        
        UIView.animate(withDuration: 0.0, animations: {
            
//            let tabbar = UIStoryboard.main.instantiateViewController(withIdentifier: "IGIndigoTabBarViewController") as! IGIndigoTabBarViewController
//            tabbar.selectedIndex = index
//            IGAppDelegate.window?.rootViewController = tabbar
//            IGAppDelegate.window!.makeKeyAndVisible()
        }, completion: nil)
    }
    
    //=======================================================================
    // Set Signin Screen as window screen
    //=======================================================================
    
    public func setSignInScreen() {
        
        UIView.animate(withDuration: 0.0, animations: {
            
//            let tabbar = UIStoryboard.login.instantiateViewController(withIdentifier: "TCLoginNavigationViewContoller") as! UINavigationController
//            IGAppDelegate.window?.rootViewController = tabbar
//            IGAppDelegate.window!.makeKeyAndVisible()
            
        }, completion: nil)
    }
    
    func setDesignLayout() {}
    func setBasicData() {}
    
    //=======================================================================
    // MARK:- IBActions
    //=======================================================================
    
    @objc func leftBarButtonItemAction(_  sender: UIButton) {
        
    }
    
    @objc func rightButtonBarButtonAction(_ sender: UIButton) {
        
    }
    
    
    //=======================================================================
    // MARK:- Navigation & Present ViewController
    //=======================================================================
    
    public func pushViewController(_ viewContorller: UIViewController, animated: Bool) {
        
        self.navigationController?.pushViewController(viewContorller, animated: animated)
    }
    
    public func popViewController(_ animated: Bool) {
        
        self.navigationController?.popViewController(animated: animated)
    }
    
    public func popToRootViewController(_ animated: Bool) {
        
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    public func presentViewController(_ viewContorller: UIViewController, animated: Bool) {
        
        self.present(viewContorller, animated: animated, completion: nil)
    }
    
    public func dismiss(_ animated: Bool) {
        
        self.dismiss(animated: animated, completion: nil)
    }
    
    func presentContoller(_ viewController: UIViewController, WithModalPresentationStyle style: UIModalPresentationStyle) {
        
        viewController.providesPresentationContextTransitionStyle = true
        viewController.definesPresentationContext = true
        viewController.modalPresentationStyle = style
        
        AppDeli.window?.rootViewController?.present(viewController, animated: false, completion: nil)
    }
    
    //=======================================================================
    // Get read more string using the default `string`.
    // `format`.
    //
    // - parameter string:             The string.
    //
    // - returns: The created Readmore `String`.
    //=======================================================================
    
    func getReadMoreString(From string: String ) -> String {
        
        if DeviceType.IS_IPHONE_5 {
            
            if string.count <= 130 {
                return string
            }
            else {
                return string.subString(toIndex: 130)
            }
        }
        else if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_X {
            if string.count <= 160 {
                return string
            }
            else {
                return string.subString(toIndex: 160)
            }
        }
        else if DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_XR {
            if string.count <= 185 {
                return string
            }
            else {
                return string.subString(toIndex: 185)
            }
        }
        else {
            return string
        }
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        
        return input.rawValue
    }
        
    
    
}
