//
//  HomeListItemViewModel.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import Foundation
import CT_RESTAPI
import CoreLocation

final class HomeListItemViewModel: HomeItemsViewModel {
    
    // MARK: - Variables & confirm protocol
    fileprivate(set) var homeSearchService: HomePageServiceProtocol!
    fileprivate(set) var page: Int = 1
    fileprivate      var appleItems = [Item]()
    fileprivate      var androidItems = [Item]()
    
    weak var listViewDelegate: HomeItemsViewModelDelegate?
    
    var numberOfItems: Int {
        if let items = currentItems {
            return items.count
        }
        return 0
    }
    
    func itemAtIndex(_ index: Int) -> Item? {
        if let items = currentItems, items.count > index {
            return items[index]
        }
        return nil
    }
    
    fileprivate(set) var currentItems: [Item]? {
        didSet {
            listViewDelegate?.listItemsDidChanged()
        }
    }
    
    // MARK: - Main functions
    
    /// Init ViewModel
    /// - Parameter homeSearchService: API service
    init(homeSearchService: HomePageServiceProtocol) {
        self.homeSearchService = homeSearchService
        setupListItemsForViewModel()
    }
    
    /// Setup View model to get list items both Apple & Android
    ///
    func setupListItemsForViewModel() {
        
        // --- Get list items of Apple ---
        homeSearchService.getListAppleItems { [weak self] (items, error) in
            if let error = error {
                Helper.showAlertViewWith(error: error.toError() as? CTNetworkErrorType)
            } else {
                self?.currentItems = items      // Set default to Apple items at the first time
                self?.appleItems = items
            }
        }
        
        homeSearchService.getListAndroidItems { [weak self] (items, error) in
            if let error = error {
                Helper.showAlertViewWith(error: error.toError() as? CTNetworkErrorType)
            } else {
                self?.appleItems = items
            }
        }
    }
}
