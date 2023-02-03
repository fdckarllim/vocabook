//
//  CustomNetworkHelper.swift
//  IOSTraining
//
//  Created by FDC-Eyan on 2/2/23.
//

import Foundation

class CustomNetworkHelper {
    typealias CustomNetworkHelperCompletionBlock = (URLSessionDataTask?, Any?, Error?) -> Void
    typealias CustomNetworkHelperURLSessionCompletionBlock = (URLResponse?, Any?, Error?) -> Void
    typealias CustomNetworkHelperProgressBlock = ((Progress) -> Void)
    
    
    @discardableResult class func makeCommonRequestOperationManager() -> AFHTTPSessionManager {
        //from NetworkHelper.makeCommonRequestOperationManager
        let operationManager = AFHTTPSessionManager()
        operationManager.requestSerializer = AFJSONRequestSerializer()
        //set timeout interval for request
        operationManager.requestSerializer.timeoutInterval = TimeInterval(30)
        operationManager.requestSerializer.cachePolicy = .reloadIgnoringCacheData
        operationManager.responseSerializer = AFJSONResponseSerializer()
        
        return operationManager
    }
    
    //MARK: common request methods
    @discardableResult class func makeCommonPostOperation(
        operationManager: AFHTTPSessionManager,
        urlString: String,
        parameters: Dictionary<String, Any>,
        uploadProgress: CustomNetworkHelperProgressBlock? = nil,
        completionBlock:@escaping CustomNetworkHelperCompletionBlock
    ) -> Operation {
        
        var param: [String: Any] = parameters
        param["users_api_token"] = "lester_api_token"
        param["api_version"] = 29
        param["page"] = 1
        param["app_version"] = "4.3.7"
        param["device_type"] = 1
        
        //from NetworkHelper.makeCommonPostOperation
        let sessionOperation = AFHTTPSessionOperation.init(manager: operationManager,
                                                           httpMethod: "POST",
                                                           urlString: urlString,
                                                           parameters: param,
                                                           uploadProgress: uploadProgress,
                                                           downloadProgress: { (progress) in },
                                                           success: { (operation, responseObject) in
            
            //AFHTTPSessionManager retains reference to delegate, thus must deallocate after operation is done
            operationManager.invalidateSessionCancelingTasks(true, resetSession: false)
            
            //check if response is a valid json object and not nil
            if JSONSerialization.isValidJSONObject(responseObject) {
                if responseObject is NSArray || responseObject is NSDictionary {
                    //perform completion asynchronously in main thread, to fix warning of "This application is modifying autolayout engine in a background thread"
                    let rspO = responseObject as? [String : Any]
                    let errM = rspO?["error"] as? [String : String]
                    let errId = errM?["id"] ?? ""
                    if errId == "invalid_api_token" {
                        DispatchQueue.main.async {
//                            Coordinating.sharedInstance.signOut()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        //if response object is dictionary or array and its not empty pass to closure
                        completionBlock(operation, responseObject, nil)
                    }
                } else {
                    //try parsing response
                    do {
                        let resData = try JSONSerialization.data(withJSONObject: responseObject, options: [])
                        
                        let str = String.init(data: resData, encoding: String.Encoding.utf8)
                        completionBlock(operation, ["string": str], nil)
                    } catch let error {
                        //when parsing failed
                        completionBlock(operation, responseObject, error)
                    }
                }
            } else {
                //if response is not valid json object, pass empty dictionary but no error
                completionBlock(operation, [String: String](), nil)
            }
            
        },
        failure: { (operation, error) in
            operationManager.invalidateSessionCancelingTasks(true, resetSession: false)
            completionBlock(operation, nil, error)
        })
        
        return sessionOperation
    }
    
    @discardableResult class func post(urlString: String, parameters: Dictionary<String, Any>, completionBlock:@escaping CustomNetworkHelperCompletionBlock) -> AFHTTPSessionManager{
        //from NetworkHelper.post
        let operationManager = self.makeCommonRequestOperationManager()
        operationManager.operationQueue.maxConcurrentOperationCount = 10
        
        let operation = self.makeCommonPostOperation(operationManager: operationManager,
                                                     urlString: urlString,
                                                     parameters: parameters,
                                                     completionBlock: completionBlock)
        
        operationManager.operationQueue.addOperation(operation)
        return operationManager
    }
    
    
    //request list of chatlog
//    @discardableResult class func requestChatlogList(apiToken: String?, pageNum: Int, searchKeyword: String?, selectedPeriod: String?, teacherID: Int?, completionBlock:@escaping CustomNetworkHelperCompletionBlock) -> AFHTTPSessionManager {
//        var param = Dictionary<String, Any>()
//        param["page"] = pageNum
//
//        if NCUser.isLoggedIn {
//            if let keyword = searchKeyword, keyword.count > 0 {
//                param["search_keyword"] = keyword
//            }
//
//            if let period = selectedPeriod, period.count > 0 {
//                param["date"] = period
//            }
//
//            if let id = teacherID {
//                param["teachers_id"] = id
//            }
//        }
//
//        return self.post(urlString:"https://english.fdc-inc.com/api/lesson/chatlog_list",
//                         parameters: param,
//                         completionBlock: completionBlock)
//    }
    
    
    //request list of chatlog
    @discardableResult class func requestChatlogList(completionBlock:@escaping CustomNetworkHelperCompletionBlock) -> AFHTTPSessionManager {
        var param = Dictionary<String, Any>()
        param["page"] = 1
        return self.post(urlString:"https://english.fdc-inc.com/api/lesson/chatlog_list",
                         parameters: param,
                         completionBlock: completionBlock)
    }
    
}
