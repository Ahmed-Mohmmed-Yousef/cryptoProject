//
//  LoginViewModel.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    func startSign()
    func endSign(success: Bool, message: String)
}

class LoginViewModel {
    var delegate: LoginViewModelDelegate?
    
    func userSignIn(email: String?, password: String?) {
        if let email = email, !email.isEmpty,
            let password = password, !password.isEmpty {
            delegate?.startSign()

            DispatchQueueHelper.delay(bySeconds: 3.0, dispatchLevel: .background) {
                // firebase auth process
                AuthService.userSignIn(email: email, password: password) { (error) in
                     DispatchQueueHelper.delay(bySeconds: 0.0) {
                        if let error = error {
                            self.delegate?.endSign(success: false, message: "\(error.localizedDescription)")
                        } else {
                            self.delegate?.endSign(success: true, message: "Wellcom")
                        }
                    }
                }
            }
        } else {
            delegate?.endSign(success: false, message: "Fill all fields")
        }
        
    }
    
    func userSignUp(username: String?, email: String?, password: String?) {
        if let email = email, !email.isEmpty,
            let username = username, !username.isEmpty,
            let password = password, !password.isEmpty {
            delegate?.startSign()

            DispatchQueueHelper.delay(bySeconds: 3.0, dispatchLevel: .background) {
                // firebase auth process
                AuthService.userSignUp(username: username, email: email, password: password) { (error) in
                     DispatchQueueHelper.delay(bySeconds: 0.0) {
                        if let error = error {
                            self.delegate?.endSign(success: false, message: "\(error.localizedDescription)")
                        } else {
                            self.delegate?.endSign(success: true, message: "Wellcom")
                        }
                    }
                }
            }
        } else {
            delegate?.endSign(success: false, message: "Fill all fields")
        }
        
    }
}
