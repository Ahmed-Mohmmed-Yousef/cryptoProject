//
//  AuthService.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    private static var ref: DatabaseReference = Database.database().reference()
    
    static func userSignIn(email: String, password: String, handler: @escaping(Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                handler(error)
            }
            
            handler(nil)
        }
    }
    
    static func userSignUp(username: String, email: String, password: String, handler: @escaping(Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                handler(error)
            } else {
                self.ref.child("users").child(authResult!.user.uid).setValue([kUsername : username,
                                                                              kEmail : email,
                                                                              kUserPassword : password])
                handler(nil)
            }
        }
    }
    
    static func signOut(handler: @escaping(Error?) -> Void){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            handler(nil)
        } catch let signOutError as NSError {
            handler(signOutError)
        }
    }
}

