//
//  MockHomeService.swift
//  FinalOneTests
//
//  Created by Canh Tran on 6/23/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import Foundation
import CT_RESTAPI
@testable import FinalOne


/// Use Mock service to Fake the data response from APIs
class MockHomeService: HomePageServiceProtocol {
    
    /// To fake the response of Apple Items API
    func getListAppleItems(completion: @escaping HomePageServiceCompletionHandler) {
        var appleItems = [Item()]
        for _ in 0...20 {
            appleItems.append(Item())
        }
        completion(appleItems, nil)
    }
    
    /// To fake the response of Android Items API
    func getListAndroidItems(completion: @escaping HomePageServiceCompletionHandler) {
        var androidItems = [Item()]
        for _ in 0...20 {
            androidItems.append(Item())
        }
        completion(androidItems, nil)
    }
}
