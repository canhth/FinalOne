//
//  HomeServiece.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit
import CT_RESTAPI

typealias HomePageServiceCompletionHandler = (_ results: [Item], _ error: RESTError?) -> Void

protocol HomePageServiceProtocol {
    func getListDrivers(completion: @escaping HomePageServiceCompletionHandler)
}

final class HomePageServiece: HomePageServiceProtocol {
    
    /// Get list of items
    ///
    /// - Parameters:
    ///   - completion: Results and error of API
    /// - Returns: <[Item]>
    func getListDrivers(completion: @escaping HomePageServiceCompletionHandler) {
        
        let apiManager = RESTApiClient(subPath: "wunderbucket", functionName: "locations.json", method: .GET, endcoding: .URL)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        apiManager.baseRequest { (results, error) in
            if let jsonData = results as? Data {
                do {
                    let results: Products = try JSONDecoder().decode(Products.self, from: jsonData)
                    completion(results.products, nil)
                } catch {
                    print("Error when parsing JSON: \(error)")
                }
            } else {
                completion([], error)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
