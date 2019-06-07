//
//  Extension+UIImage.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import SDWebImage

extension UIImage {
    
    //=======================================================================
    // Creates a `base64` using the default `ImageFormat`.
    // `format`.
    //
    // - parameter format:             The format.
    //
    // - returns: The created base64 `String`.
    //=======================================================================

    func base64(format: ImageFormat) -> String {
        
        var imageData: NSData
        switch format {
        case .PNG: imageData = self.pngData()! as NSData
        case .JPEG: imageData = self.jpegData(compressionQuality: 1.0)! as NSData
        case .Unknown:
            return ""
        }
        return imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    
    //=======================================================================
    // Creates a `UIImage` using the default base64 `String`.
    // `strEncodeData`.
    //
    // - parameter strEncodeData:             The strEncodeData.
    //
    // - returns: The created `UIImage`.
    //=======================================================================

    class func base64ToImage(toImage strEncodeData: String) -> UIImage {
        
        let dataDecoded  = NSData(base64Encoded: strEncodeData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let image = UIImage(data: dataDecoded as Data)
        return image!
    }
    
    
    func resize(maxWidthHeight : Double)-> UIImage? {
        
        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0
        
        if actualWidth > actualHeight {
            
            maxWidth  = maxWidthHeight
            let per   = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }
        else{
            maxHeight = maxWidthHeight
            let per   = (100.0 * maxWidthHeight / actualHeight)
            maxWidth  = (actualWidth * per) / 100.0
        }
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }

}

struct ImageHeaderData {
    
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
}

enum ImageFormat{
    
    case PNG, JPEG, Unknown
}

extension UIImageView {
    
    //=======================================================================
    // Set a `UIImage` using the default base64 `url` and `placeHolderImage`.
    // `url` and `placeHolderImage`.
    //
    // - parameter url:              The url.
    // - parameter placeHolderImage: The placeHolderImage.
    //
    //=======================================================================
    
    func setImageWithURL(_ url: String, withPlaceHolderImage placeHolderImage: UIImage? = nil) {
        
        print("Image URL ::: ===>>>\(url)")
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.gray)
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        self.sd_setImage(with: URL(string: urlString!), placeholderImage: placeHolderImage) { (image, error, carchType, url)  in
            
            if error != nil && placeHolderImage != nil {
                self.image = placeHolderImage!
            }
        }
    }
}

