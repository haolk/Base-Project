//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit
import Reachability
import SwiftyJSON
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FacebookShare


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetReachability   = Reachability()
    var isReachableNetwork     = Bool()
    var user: User?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GIDSignIn.sharedInstance().clientID = Google.CLIENT_KEY
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL?,
                                                                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                                annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        let facebookDidHandle = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        return googleDidHandle || facebookDidHandle
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        internetReachability?.stopNotifier()
    }
}

// MARK:-
extension AppDelegate {
    
    // MARK:- Reachability Setup
    
    //=======================================================================
    // Setup Reachability
    //=======================================================================
    
    func setupReachability() {
        
        internetReachability = Reachability.init()
        do{
            try internetReachability?.startNotifier()
            self.isConnectNetwork(internetReachability!)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleNetworkChange), name: .reachabilityChanged, object: internetReachability)
            
        }
        catch {
            
            print("could not start reachability notifier")
        }
    }
    
    //=======================================================================
    // Handle Network Change using the default `notify` `
    // `notify`.
    //
    // - parameter notify:       The notify.
    //
    //=======================================================================
    
    @objc func handleNetworkChange(notify: Notification) {
        
        let reachability = notify.object as! Reachability
        self.isConnectNetwork(reachability)
    }
    
    
    //=======================================================================
    // Set `isReachableNetwork` bool using the default `reachability`.
    // `reachability`.
    //
    // - parameter reachability:       The reachability.
    //
    //=======================================================================
    
    func isConnectNetwork(_ reachability: Reachability) {
        
        if reachability.connection != .none {
            self.isReachableNetwork = true
        }
        else {
            self.isReachableNetwork = false
        }
        
        print("Internet Connected: \(self.isReachableNetwork)")
    }
}

