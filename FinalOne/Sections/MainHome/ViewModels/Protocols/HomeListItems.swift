//
//  HomeListItemViewModel.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import Foundation

protocol HomeItemsViewModelDelegate: class {
    func listItemsDidChanged()
}

protocol HomeItemsViewModel
{
    var listViewDelegate: HomeItemsViewModelDelegate? { get set }
    
    var numberOfItems: Int { get }
    
    func itemAtIndex(_ index: Int) -> Item?
    
}
