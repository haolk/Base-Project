//
//  APIManager.swift
//  BaseProject
//
//  Created by Rohit Makwana on 04/06/18.
//  Copyright © 2018 Rohit Makwana. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class APIManager {

    static let shared:APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager: SessionManager
    
    private init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func callRequest(_ router: APIRouter, newPath: String = "", isShowHUD :Bool = true, onSuccess success: @escaping (_ response: BaseResponse) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
        
        if CurrentServer == .none {
            return
        }
        
        guard AppDeli.isReachableNetwork == true else {
            
            let apiError = APICallError(status: .offline)
            failure(apiError)
            return
        }
        
        var url : String!
        
        if newPath == "" {
            
            url = router.path.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
            url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        else {
            url = newPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        
        var parameter = router.parameters
        if router.parameters == nil {
            parameter = [:]
        }
        
        //Update encoding here
        var encoding: ParameterEncoding = JSONEncoding.init()
        if router.method == .get {
            encoding = URLEncoding.default
        }

        if isShowHUD {
            Utility.shared.isShowProgressHUD(true)
        }        
        
        print("==================================================")
        print("Request URL : \(url!)")
        print("Request parameter : \(parameter!)")
        print("Method : \(router.method)")
        print("headers : \(router.headers)")
        print("==================================================")
        
        self.sessionManager.request(url!, method: router.method, parameters: parameter!, encoding: encoding, headers: router.headers).responseJSON { response  in
            
            print("✅ Response : \(response)\n\n\n")

            if isShowHUD  {
                Utility.shared.isShowProgressHUD(false)
            }
            
            switch response.result {
            case .success:
                let apiResponse = BaseResponse.init(response: response, statusCode: response.response?.statusCode ?? 0)
                if apiResponse.success {
                    success(apiResponse)
                } else {
                    let apiError = APICallError(status: .failed)
                    apiError.reason = apiResponse.message
                    failure(apiError)
                }
                break
            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
                let apiError = APICallError(status: .failed)
                apiError.reason = error.localizedDescription
                failure(apiError)
                break
            }
        }
    }
  
    func callRequestWithMultipartData(_ router: APIRouter, arrImages: [UIImage]? , imageKeys: [String], isShowHUD :Bool = true, onSuccess success: @escaping (_ response: BaseResponse) -> Void, onFailure failure: @escaping (_ error: APICallError) -> Void) {
        
        guard AppDeli.isReachableNetwork == true else {
            
            let apiError = APICallError(status: .offline)
            failure(apiError)
            return
        }

        
        let path = router.path.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
        
        var parameter = router.parameters
        if router.parameters == nil {
            parameter = [:]
        }
        
        if isShowHUD {
            Utility.shared.isShowProgressHUD(true)
        }
        
        self.sessionManager.upload(multipartFormData: { multipartFormData in
            
            for i in 0..<arrImages!.count {
                
                let image = arrImages![i]
                
                if let compressData = image.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(compressData, withName: imageKeys[i], fileName: "\(imageKeys[i])\(i).png", mimeType: "image/png")
                }
            }
            
            for (key, value) in parameter! {

                if value is NSArray || value is NSMutableArray {
                    multipartFormData.append(String(describing: "\(value)").data(using: .utf8)!, withName: key)
                }
                else {
                    multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                }
            }
         },
        usingThreshold: UInt64.init(),
        to: path!,
        method: router.method,
        headers: router.headers,
        encodingCompletion: { encodingResult  in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                print(encodingResult)
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    if isShowHUD {
                        Utility.shared.isShowProgressHUD(false)
                    }
                    
                    switch response.result {
                    case .success:
                        let apiResponse = BaseResponse(response: response, statusCode: response.response?.statusCode ?? 0)
                        if apiResponse.success {
                            success(apiResponse)
                        } else {
                            let apiError = APICallError(status: .failed)
                            apiError.reason = apiResponse.message
                            failure(apiError)
                        }
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                        let apiError = APICallError(status: .failed)
                        failure(apiError)
                        break
                    }
                })
                return
            case .failure(let encodingError):
                debugPrint(encodingError)
                let apiError = APICallError(status: .failed)
                failure(apiError)
            }
        })
        
    }
    
    // MARK:- Cancel Requests
    
    func cancelAllTasks() {
        self.sessionManager.session.getAllTasks { tasks in
            tasks.forEach {
                $0.cancel()
            }
        }
    }
    
    func cancelRequests(url: String) {
        self.sessionManager.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                
                self.cancelTasksByUrl(tasks: dataTasks     as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: uploadTasks   as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: downloadTasks as [URLSessionTask], url: url)
        }
    }
    
    private func cancelTasksByUrl(tasks: [URLSessionTask], url: String) {
        
        for task in tasks {
            if task.currentRequest?.url?.absoluteString == url {
                task.cancel()
            }
        }
    }
}


