//
//  FinalOneCoordinator.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit

class FinalOneCoordinator: Coordinator {
    
    fileprivate var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startToLoadView() {
        
        /// For example `isLogged`
        /// True:  --> Show homepage
        /// False: --> Show loginpage
        let isLogged = true
        if isLogged {
            showMainHomeView()
        } else {
            print("Not login yet, please show login dialog here.")
        }
    }
}

extension FinalOneCoordinator {
    
    fileprivate func showMainHomeView() {
        
        let mainHomeCoordinator = MainHomeCoordinator(window: window)
        mainHomeCoordinator.delegate = self
        mainHomeCoordinator.startToLoadView()
    }
    
    fileprivate func showLoginView() { }
}

extension FinalOneCoordinator: MainHomeCoordinatorDelegate {
    func authorizedDidChange(isAuthorized: Bool) {
        // Show login again if `isAuthorized` == false
    }
}
