//
//  UIViewControllerExtension.swift
//  HeyLiveCam
//
//  Created by Shree on 10/05/20.
//  Copyright © 2020 Shree. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async { [unowned self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

