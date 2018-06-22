//
//  Helper.swift
//  FinalOne
//
//  Created by Canh Tran on 6/22/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit
import CT_RESTAPI

class Helper {
    
    static func showAlertViewWith(error: CTNetworkErrorType?) {
        if let viewController = UIApplication.topViewController(),
            let error = error {
            let title = "Error \(error.errorCode)"
            var message = ""
            switch error {
            case let .errorMessage(_, _, errorMessage):
                message = errorMessage
            default: break
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showAlertViewWith(message: String) {
        if let viewController = UIApplication.topViewController() {
            let title = "Error"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
