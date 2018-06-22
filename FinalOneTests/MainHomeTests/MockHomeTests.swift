//
//  MockHomeTests.swift
//  FinalOneTests
//
//  Created by Canh Tran on 6/23/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import XCTest
@testable import FinalOne

extension MainHomeTests {
    
    /// Mock serviece to get Apple items
    func testMockResultsWithSuccess() {
        
        viewModel = HomeListItemViewModel(homeSearchService: MockHomeService())
        
        var results: [Item]!
        viewModel.homeSearchService.getListAppleItems { (items, _) in
            // This will be return 22 empty items in MockHomeServiece
            results = items
        }
        
        XCTAssertTrue(!results.isEmpty)
    }
    
}
