//
//  UIViewController+Alertview.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Function to displays alertview controller
    /// - parameter String: title for alert
    /// - parameter String: message for alert
    /// - parameter String: actionbtnTitle for alert
    
    func showAlert(title : String , message : String , actionTitle : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
