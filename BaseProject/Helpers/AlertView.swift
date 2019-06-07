//
//  AlertView.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

final class AlertView {
    
    class func showActionSheet(WithTitle title: String, AndMessage msg: String, actions: [String], textColor: UIColor = AppColor.Black, completion: @escaping (UIAlertAction)->Void) {
        
        let alert = UIAlertController(title: title=="" ? nil:title, message: msg=="" ?nil:msg, preferredStyle: .actionSheet)
        
        if title != "" {
            
            let titleFont = [NSAttributedString.Key.font: Helper.setFont(WithFontFamily: Font.Montserrat_Bold, AndFontSize: 18.0)]
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            alert.setValue(titleAttrString, forKey: "attributedTitle")
        }
        
        if msg != "" {
            
            let messageFont = [NSAttributedString.Key.font:Helper.setFont(WithFontFamily: Font.Montserrat_Medium, AndFontSize: 16.0)]
            let messageAttrString = NSMutableAttributedString(string: msg, attributes: messageFont)
            alert.setValue(messageAttrString, forKey: "attributedMessage")
        }
        
        for act in actions {
            
            let alertAction = UIAlertAction(title: act, style: .default) { (action) in
                completion(action)
            }
            alertAction.setValue(textColor, forKey: "titleTextColor")
            alert.addAction(alertAction)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        cancel.setValue(textColor, forKey: "titleTextColor")
        alert.addAction(cancel)
        
        AppDeli.window?.rootViewController?.present(alert, animated: true) {}
    }
    
    class func showAlert(WithTitle title: String, AndMessage msg: String, actions: [String], isShowCancel: Bool = false,viewController: UIViewController? = nil, completion: @escaping (UIAlertAction)->Void) {
        
        let alert = UIAlertController(title: title=="" ? nil:title, message: msg=="" ?nil:msg, preferredStyle: .alert)
        
        if title != "" {
            
            
            let titleFont = [NSAttributedString.Key.font: Helper.setFont(WithFontFamily: Font.Montserrat_Bold, AndFontSize: 18.0)]
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            alert.setValue(titleAttrString, forKey: "attributedTitle")
        }
        
        if msg != "" {
            
            let messageFont = [NSAttributedString.Key.font: Helper.setFont(WithFontFamily: Font.Montserrat_Medium, AndFontSize: 16.0)]
            let messageAttrString = NSMutableAttributedString(string: msg, attributes: messageFont)
            alert.setValue(messageAttrString, forKey: "attributedMessage")
        }
        
        for act in actions {
            
            let alertAction = UIAlertAction(title: act, style: .default) { (action) in
                completion(action)
            }
            
            alert.addAction(alertAction)
        }
        
        if isShowCancel {
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            cancel.setValue(AppColor.Red, forKey: "titleTextColor")
            alert.addAction(cancel)
        }
        
        if viewController != nil {
            viewController?.present(alert, animated: true, completion: nil)
        }
        else {
            AppDeli.window?.rootViewController?.present(alert, animated: true) {}
        }
    }
    
    class func showAlert(WithTitle title: String, AndMessage msg: String, action: String) {
        
        showAlert(WithTitle: title, AndMessage: msg, actions: [action]) { (action) in }
    }
    
    class func showAlert(Withmessage msg: String, action: String) {
        
        self.showAlert(WithTitle: AppName, AndMessage: msg, action: action)
    }
}
