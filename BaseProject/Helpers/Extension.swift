//
//  IGExtension.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    func get<T:UIViewController>(controller:T.Type) -> T? {
        
        let strIdentifier =  String.init(describing: controller)
        return self.instantiateViewController(withIdentifier: strIdentifier) as? T ?? nil
    }
}

extension UITableView {
    
    func getCell<T:UITableViewCell>(cell :T.Type) -> T? {
        
        let strIdentifier =  String.init(describing: cell)
        return self.dequeueReusableCell(withIdentifier: strIdentifier) as? T ?? nil
    }
}

extension UICollectionView {
    
    func getCell<T:UICollectionViewCell>(cell :T.Type, indexpath: IndexPath) -> T? {
        
        let strIdentifier =  String.init(describing: cell)
        return self.dequeueReusableCell(withReuseIdentifier: strIdentifier, for: indexpath) as? T ?? nil
    }
}

extension UITableView {
    
    private func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        
        self.register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCellFromNIB<T: UITableViewCell>(_: T.Type) -> T {
        
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T{
            return cell
        }
        else {
            self.register(T.self)
            return self.dequeueCellFromNIB(T.self)
        }
    }
}

extension UICollectionView {
    
    private func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        
        self.register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCellFromNIB<T: UICollectionViewCell>(_: T.Type, forIndexPath indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T{
            return cell
        }
        else {
            self.register(T.self)
            return self.dequeueCellFromNIB(T.self, forIndexPath: indexPath)
        }
    }
}


extension NSArray {
    
    //sorting- ascending
    func ascendingArrayWithKeyValue(key:String) -> NSArray {
        
        let ns = NSSortDescriptor.init(key: key, ascending: true)
        let aa = NSArray(object: ns)
        let arrResult = self.sortedArray(using: aa as! [NSSortDescriptor])
        
        return arrResult as NSArray
    }
    
    //sorting - descending
    func discendingArrayWithKeyValue(key:String) -> NSArray {
        
        let ns = NSSortDescriptor.init(key: key, ascending: false)
        let aa = NSArray(object: ns)
        let arrResult = self.sortedArray(using: aa as! [NSSortDescriptor])
        
        return arrResult as NSArray
    }
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        let lblFont = Helper.setSystenFontOfSize(17.0, fontweight: .medium)
        messageLabel.font = lblFont
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
