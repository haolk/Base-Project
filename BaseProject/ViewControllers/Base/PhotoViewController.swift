//
//  PhotoViewController.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: BaseViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photo: UIImage?
    
    //=======================================================================
    // MARK:- View Delegate
    //=======================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func showPhotoActionSheet() {
        
        AlertView.showActionSheet(WithTitle: "", AndMessage: "", actions: [ConstantString.takePhoto, ConstantString.chooseFromGallary], textColor: AppColor.Black) { (action) in
            
            if action.title == ConstantString.takePhoto {
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.checkPhotoLibraryPermission()
                }
                else {
                    
                    AlertView.showAlert(WithTitle: AppName, AndMessage: AlertMessage.cameraError, action: ConstantString.ok)
                }
            }
            else {
                self.selectPhotoFrom(.photoLibrary)
            }
        }
    }
    
    //=======================================================================
    // MARK:- Photo & Camera Methods
    //=======================================================================
    
    func selectPhotoFrom(_ sourceType : UIImagePickerController.SourceType) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType    = sourceType
        imgPicker.delegate      = self
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    //=======================================================================
    // MARK:- Take permission for camera
    //=======================================================================
    
    func checkPhotoLibraryPermission() {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            self.selectPhotoFrom(.camera)
        case .denied:
            AlertView.showAlert(WithTitle: AppName, AndMessage: AlertMessage.cameraRequestError, action: ConstantString.ok)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    self.selectPhotoFrom(.camera)
                }
            })
            break
        default: break
        }
    }
}
