//
//  IGLocationManager.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager:NSObject {

    private override init() { }
    
    static let shared = LocationManager()
    
    var currentLcoation : CLLocation?
    let locationManager = CLLocationManager()

    func startLocation() {
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //=======================================================================
    // CheckLocation Services using the default `controller`.
    // `controller`.
    //
    // - parameter controller:             The controller.
    //
    //=======================================================================
    
    func checkLocationService(controller: BaseViewController) {
        
        switch CLLocationManager.authorizationStatus() {
        case  .restricted, .denied:
            
            AlertView.showAlert(WithTitle: AppName, AndMessage: "please open this app's settings and enable location permission", actions: ["Setting"], isShowCancel: true, viewController: controller) { (action) in
                
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
            
        default:
            break
        }
    }
    
    
    //=======================================================================
    // Get Address using curent Location.
    // `completion`.
    //
    // - parameter completion:   The completion.
    //
    // - returns: The address `String`.
    //=======================================================================

    func getAddress(completion:@escaping (String)-> Void) {
        
        guard let location = self.currentLcoation else {
            
            completion("")
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                
                completion("")
                return
            }
            else if let placemark = placemarks?.first {
                
                if placemark.locality != ""{
                    completion(placemark.locality!)
                }
                else if placemark.administrativeArea != ""{
                    completion(placemark.administrativeArea!)
                }
                else if placemark.country != "" {
                    completion(placemark.country!)
                }
                else {
                    completion("")
                }
            }
            else{
                completion("")
            }
        })
    }
}

// MARK:-
extension LocationManager: CLLocationManagerDelegate {
    
    //=======================================================================
    // MARK:- CLLocation Manager Delegate
    //=======================================================================

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue = manager.location else { return }
        currentLcoation = locValue
        
        print("locations = \(locValue.coordinate.latitude) \(locValue.coordinate.longitude)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        currentLcoation = nil
        print("Failed")
    }
}



