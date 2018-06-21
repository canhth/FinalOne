//
//  MainHomeCoordinator.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit

protocol MainHomeCoordinatorDelegate: class {
    func authorizedDidChange(isAuthorized: Bool)
}

class MainHomeCoordinator: Coordinator {
    
    weak var delegate: MainHomeCoordinatorDelegate!
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startToLoadView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "MainHomeViewController") as? MainHomeViewController {
            //vc.delegate = self   --> Needed when we have a logout function inside MainHome
            window.rootViewController = viewController
        }
    }
}
