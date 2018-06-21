//
//  RESTApiClient.swift
//  CT_RESTAPI
//
//  Created by thcanh on 3/2/17.
//  Copyright © 2017 CanhTran. All rights reserved.
//

import UIKit
import Alamofire

typealias RestAPICompletion = (_ result: Any?, _ error: RESTError?) -> Void

/// The main class of CT_RESTAPI
open class RESTApiClient: NSObject {
    
    // MARK: - Variables
    public typealias RestAPICompletion = (_ result: Any?, _ error: RESTError?) -> Void
    fileprivate var baseUrl: String = ""
    var parameters: [String: Any] = [:]
    fileprivate var headers: [String: String] = RESTContants.headers
    fileprivate var requestBodyType: RESTRequestBodyType
    fileprivate var requestMethod: HTTPMethod
    fileprivate var endcoding: ParameterEncoding
    fileprivate let acceptableStatusCodes: [Int]
    
    // MARK: - Main functions
    
    /// Init RESTApiClient object
    ///
    /// - Parameters:
    ///   - subPath: Sub path of API URL
    ///   - functionName: last func of API URL
    ///   - method: API method
    ///   - endcoding: API endcoding
    public init(subPath: String, functionName: String, method: RequestMethod, endcoding: Endcoding) {
        
        // Set base url
        baseUrl = RESTContants.kDefineWebserviceUrl + subPath + (functionName.isEmpty ? "" : ("/" + functionName))
        requestBodyType = RESTRequestBodyType.json
        
        switch endcoding {
        case .JSON:
            self.endcoding = JSONEncoding.default
        case .URL:
            self.endcoding = URLEncoding.default
        case .CUSTOM:
            self.endcoding = URLEncoding.default
        }
        
        switch method {
        case .GET:
            requestMethod = Alamofire.HTTPMethod.get
        case .POST:
            requestMethod = Alamofire.HTTPMethod.post
        case .PUT:
            requestMethod = Alamofire.HTTPMethod.put
        case .DELETE:
            requestMethod = Alamofire.HTTPMethod.delete
        default:
            requestMethod = Alamofire.HTTPMethod.get
        }
        
        acceptableStatusCodes = Array(200..<300)
    }
    
    // MARK: - Properties
    open func setQueryParam(_ param: [String: Any]?) {
        parameters = param ?? ["": ""]
    }
    
    open func addHeader(_ name: String, value: Any) {
        headers[name] = String(describing: value)
    }
    
    // MARK: - Base request
    /// Base request functions
    ///
    open func baseRequest(_ completion: @escaping RestAPICompletion) {
        Alamofire.request(baseUrl, method: requestMethod, parameters: parameters, encoding: endcoding)
            .validate()
            .validate(statusCode: self.acceptableStatusCodes)
            .responseJSON { response in
            switch response.result {
            case .success:
                completion(response.data, nil)
            case .failure(let error):
                let restError = RESTError.parseError(response.data, error: error)
                completion(nil, restError)
            }
        }
    }  
}
