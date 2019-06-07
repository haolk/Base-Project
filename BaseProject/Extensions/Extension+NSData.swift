//
//  Extension+NSData.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation

extension NSData {
    
    var imageFormat: ImageFormat {
        
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        
        if buffer == ImageHeaderData.PNG
        {
            return .PNG
        }
        else if buffer == ImageHeaderData.JPEG
        {
            return .JPEG
        }
        else{
            return .Unknown
        }
    }
}
