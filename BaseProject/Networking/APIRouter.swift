//
//  APIRouter.swift
//  BaseProject
//
//  Created by Rohit Makwana on 04/06/18.
//  Copyright © 2018 Rohit Makwana. All rights reserved.
//

import Foundation
import Alamofire

//=======================================================================
// MARK:- Routable
//=======================================================================

protocol Routable {
    
    var path       : String { get }
    var method     : HTTPMethod { get }
    var parameters : Parameters? { get }
    var headers    :  HTTPHeaders { get }
}


enum APIRouter: Routable {
    
    case getData(Parameters)
}

extension APIRouter {
    
    var path: String {
        switch self {
        case .getData:
            return baseUrl + ""
        }
    }
}

extension APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .getData:
            return .get //ot .post
        }
    }
}

extension APIRouter {
    
    var parameters: Parameters? {
        
        switch self {
        case .getData(let param):
            return param
        }
    }
}

extension APIRouter {
    
    var headers: HTTPHeaders {
        
        if let token = AppDeli.user?.token {
            return ["Content-Type":"application/json", "accesstoken": token]
        }
        else {
            return ["Content-Type":"application/json"]
        }
    }
}
