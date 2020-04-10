//
//   UIViewController+Ext.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(msg: String, _ completion: (() -> ())?){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (alertAction) in
            completion?()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
