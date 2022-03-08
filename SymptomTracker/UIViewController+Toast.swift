//
//  UIViewController+Toast.swift
//  SymptomTracker
//
//  Created by Mike on 3/7/22.
//

import UIKit
import Loaf

extension UIViewController {
    
    func showErrorToast(withMessage message: String) {
        Loaf(message, state: .error, sender: self).show()

    }

    func showWarningToast(withMessage message: String) {
        Loaf(message, state: .warning, sender: self).show()

    }

    func showSuccessToast(withMessage message: String) {
        Loaf(message, state: .success, sender: self).show()
    }


    func showErrorToast(withMessage message: String, completion: @escaping ()->()) {
        Loaf(message, state: .error, sender: self).show(.average) { reason in
            completion()
        }
    }

    func showWarningToast(withMessage message: String, completion: @escaping ()->()) {
        Loaf(message, state: .warning, sender: self).show(.average) { reason in
            completion()
        }
    }

    func showSuccessToast(withMessage message: String, completion: @escaping ()->()) {
        Loaf(message, state: .success, sender: self).show(.average) { reason in
            completion()
        }
    }

    
    

    
}
