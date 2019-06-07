//
//  UserDefaults.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit

class UserDefaultModel: NSObject {
    
    //=======================================================================
    // Creates a `UserDefaultModel` Instance
    //
    // - returns: The created `UserDefaultModel` Instance.
    //=======================================================================

    static let shared: UserDefaultModel = UserDefaultModel()    
    
    //=======================================================================
    // Set Introduction status for user
    // `status`.
    //
    // - parameter status:       The status for app
    //
    //=======================================================================
    
    func setAppIntroductionStatus(_ status: Bool) {
        
        UserDefault.set(status, forKey: IGKey.AppIntroStatus)
        self.synchronize()
    }

    //=======================================================================
    // Get Introduction status for app
    //
    // - returns: The Introduction signin `status`.
    //=======================================================================
    
    func isIntroduceApp() -> Bool {
        
        if UserDefault.value(forKey: IGKey.AppIntroStatus) != nil {
            return UserDefault.value(forKey: IGKey.AppIntroStatus) as! Bool
        }
        
        return false
    }

    
    //=======================================================================
    // Set Signin status for user
    // `status`.
    //
    // - parameter status:       The status for user
    //
    //=======================================================================
    
    func setAppOpenStatus(_ status: Bool) {
        
        UserDefault.set(status, forKey: IGKey.AppOpenStatus)
        self.synchronize()
    }
    
    
    //=======================================================================
    // Get App opened status for user
    //
    // - returns: The user signin `status`.
    //=======================================================================
    
    func isAppOpened() -> Bool {
        
        if UserDefault.value(forKey: IGKey.AppOpenStatus) != nil {
            return UserDefault.value(forKey: IGKey.AppOpenStatus) as! Bool
        }
        
        return false
    }
    
    
    //=======================================================================
    // Set Signin status for user
    // `status`.
    //
    // - parameter status:       The status for user
    //
    //=======================================================================

    func setSignInStatus(_ status: Bool) {
        
        UserDefault.set(status, forKey: IGKey.SignInStatus)
        self.synchronize()
    }
    
    
    //=======================================================================
    // Get Signin status for user
    //
    // - returns: The user signin `status`.
    //=======================================================================
    
    func isSignIn() -> Bool {
        
        if UserDefault.value(forKey: IGKey.SignInStatus) != nil {
            return UserDefault.value(forKey: IGKey.SignInStatus) as! Bool
        }
        return false
    }
    
    
    //=======================================================================
    // Remove Signin status for user
    //=======================================================================
    
    func removeSignInStatus() {
        
        UserDefault.removeObject(forKey: IGKey.SignInStatus)
    }
    
    
    //=======================================================================
    // Save Signin User
    // `user`.
    //
    // - parameter user:       The user
    //
    //=======================================================================

    func saveUser(_ user: User) {
        
        do {
            let archived = try NSKeyedArchiver.archivedData(withRootObject: [user], requiringSecureCoding: false)
            UserDefault.set(archived, forKey: IGKey.User)
            AppDeli.user = user
        }
        catch {
            print(error)
        }
        
        self.synchronize()
    }
    
    
    //=======================================================================
    // Get Current signin User
    //
    // - returns: Current signin `User` object
    //=======================================================================
    
    func currentUser() -> User {
        
        if (UserDefault.value(forKey: IGKey.User) != nil) {
            
            let archiveData =  UserDefault.value(forKey: IGKey.User) as! Data
            
            do {
                let users = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [User.self], from: archiveData) as! [User]
                return users[0]
            }
            catch {
                print(error)
            }
        }
        
        return User()
    }
    
    
    //=======================================================================
    // Remove Signin user
    //=======================================================================

    func removeUser() {
        
        UserDefault.removeObject(forKey: IGKey.User)
        AppDeli.user = nil
    }
    
    //=======================================================================
    // Synchronize with UserDefaults
    //=======================================================================

    func synchronize() {
    
        UserDefaults.standard.synchronize()
    }
}
