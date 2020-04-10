//
//  RootMV.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation
import Firebase

protocol RootDelegate {
    func startFetching()
    func endFetching(success: Bool, msg: String)
    func startSend()
    func endSend(success: Bool, msg: String)
    func sureLogout(handler: @escaping(Bool) -> Void)
    func goTo(_ vc: UIViewController)
    func showAlert(msg: String, _ completion: (() -> ())?)
}

class RootVM {
    private var ref: DatabaseReference = Database.database().reference()
    private var email: String? {
        
        return Auth.auth().currentUser?.email
    }
    var delegate: RootDelegate?
    
    init(){}
    
    func checkSignIn() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginView()
            loginVC.modalPresentationStyle = .fullScreen
            delegate?.goTo(loginVC)
        }
    }
    
    func fetchMessage(handler: @escaping([Message]?)->Void) {
        delegate?.startFetching()
        DispatchQueueHelper.delay(bySeconds: 0.4, dispatchLevel: .background) {
            // fetching message
            MessageService.fetchMessage { (messages) in
                DispatchQueueHelper.delay(bySeconds: 0.0) {
                    if messages == nil {
                        self.delegate?.endFetching(success: false, msg: "Cannt fetch Messages")
                        handler(nil)
                    } else {
                        self.delegate?.endFetching(success: true, msg: "")
                        handler(messages!)
                    }
                }
            }
            
        }
    }
    
    func sendMessage(text: String?, password: String?, indexType: Int){
        delegate?.startSend()
        if let text = text, !text.isEmpty, let password = password, !password.isEmpty{
            DispatchQueueHelper.delay(bySeconds: 0.4, dispatchLevel: .background) {
                // fetching message
                let message = self.createCipherMessage(text: text, password: password, indexType: indexType)
                MessageService.uploadMessage(message: message) {
                    
                    DispatchQueueHelper.delay(bySeconds: 0.0) {
                        self.delegate?.endSend(success: true, msg: "Done")
                    }
                }
            }
        } else {
            delegate?.endSend(success: false, msg: "Fill All Text Fields")
        }
    }
    
    func createCipherMessage(text: String, password: String, indexType: Int) -> Message{
        var cipher = ""
        var EncTyp: EncryptionType = .Columnar
        var key = ""
        switch indexType {
        case 0:
            cipher = Encryption.reverseEnc(text: text)
            EncTyp = .Reverse
            break
        case 1:
            cipher = Encryption.caeserEnc(text: text)
            EncTyp = .Caeser
            break
        case 2:
            cipher = Encryption.rot13(text: text)
            EncTyp = .ROT13
            break
        case 3:
            cipher = Encryption.columnarTransposition(text: text)
            EncTyp = .Columnar
            break
        case 4:
             cipher = Encryption.columnarTransposition(text: text)
             EncTyp = .Columnar
            break
        default:
            break
        }
        
        switch EncTyp {
            case .Reverse:
                key = ""
            case .Caeser:
                key = "6"
            case .ROT13:
                key = ""
            case .Columnar:
                key = "HACK"
            case .DES:
                key = "DESKey"
        }
        let message = Message(name: email! , algorithm: EncTyp, id: self.ref.childByAutoId().key!, message: cipher, key: key, password: password)
        return message
    }
    
    func signOut(){
        delegate?.sureLogout(handler: { (isSure) in
            if isSure {
                AuthService.signOut { (error) in
                    if let error = error {
                        self.delegate?.showAlert(msg: "Error: \(error.localizedDescription)", nil)
                    } else {
                        self.checkSignIn()
                    }
                }
            }
        })
    }
}
