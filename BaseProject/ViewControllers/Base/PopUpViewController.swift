//
//  PopUpViewController.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class PopUpViewController: BaseViewController {
    
    //=======================================================================
    // MARK:- View Delegate
    //=======================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //=======================================================================
    // Dismiss ViewController with Animation using the default `view` and `baseView`.
    // `view` and `baseView`.
    //
    // - parameter view:     The view animated view.
    // - parameter baseView:     The baseView.
    //
    //=======================================================================
    
    func dismiss(withView view: UIView, baseView: UIView) {
        
        UIView.animate(withDuration: customViewAnimationDuration,delay: 0.0,usingSpringWithDamping: 2,initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            baseView.alpha = 0
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: customViewInitialScaleAmmount, y: customViewInitialScaleAmmount)
            
        },completion: { isCompleted in
            
            self.dismiss(false)
        })
    }
    
    
    //=======================================================================
    // PopUp View with Animation using the default `view` and `baseView`.
    // `view` and `baseView`.
    //
    // - parameter view:     The view animated view.
    // - parameter baseView:     The baseView.
    //
    //=======================================================================
    
    func present(withView view: UIView, baseView: UIView) {
        
        UIView.animate(withDuration: customViewAnimationDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            baseView.alpha = 1
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        },completion: { isCompleted in
        })
    }
}
