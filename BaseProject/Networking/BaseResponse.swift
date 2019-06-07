//
//  BaseResponse.swift
//  BaseProject
//
//  Created by Rohit Makwana on 05/06/18.
//  Copyright © 2018 Rohit Makwana. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum Params: String {
    
    case status
    case success
    case message
    case data
    case errors
    case noInternetConnection
}


class BaseResponse {
    
    var message = ""
    var data: JSON?
    var success = false
    
    
    //=======================================================================
    // Creates an instance with the specified `response` and `statusCode`.
    //
    // - parameter response:     The response.
    // - parameter statusCode:       The statusCode.
    //
    //=======================================================================

    init(response:DataResponse<Any>, statusCode:Int) {

        let jsonResult: JSON = JSON(response.result.value!)
        
        self.success = statusCode == 200
        self.message = jsonResult["message"].stringValue
        
        if !jsonResult["data"].isEmpty {
            self.data = jsonResult["data"]
        }
    }
}
