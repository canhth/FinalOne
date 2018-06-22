//
//  MainHomeTests.swift
//  FinalOneTests
//
//  Created by Canh Tran on 6/23/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import XCTest
@testable import FinalOne

class MainHomeTests: FinalOneTests {
    
    // MARK: properties
    var viewModel : HomeListItemViewModel!
    
    let homepageService = HomePageServiece()
    
    override func setUp() {
        super.setUp() 
    }
    
    // MARK: Base functions
    func getAppleItems() -> [Item] {
        var results: [Item]!
        viewModel = HomeListItemViewModel(homeSearchService: homepageService)
        
        // The expectation to wait until got the response from API
        let expectation =  self.expectation(description: "SomeService does stuff and runs the callback closure")
        viewModel.homeSearchService.getListAppleItems { (items, _) in
            results = items
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: timeOut) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        return results
    }
    
    // MARK: Test cases
    func testGetAppleItemsSuccess() {
        let results: [Item]! = getAppleItems()
        XCTAssertTrue(!results.isEmpty)
    }
}
