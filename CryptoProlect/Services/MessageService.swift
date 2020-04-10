//
//  MessageService.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation
import Firebase

class MessageService {
    
    private static var ref: DatabaseReference = Database.database().reference()
    private static var userEmail: String? {
        return Auth.auth().currentUser?.email
    }
    
    static func uploadMessage(message: Message, handler: @escaping() -> Void){
        let msgDic: [String : Any] = self.messageDicFrom(message: message)
        self.ref.child("Messages").child(message.id).setValue(msgDic)
        handler()
    }
    
    static func fetchMessage(handler: @escaping([Message]?) -> Void){
        
//        ref.child("Messages").child(uid).observe(.value) { (snapshot) in
//            var messageArr: [Message] = []
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//                let dic = snap.value as! NSDictionary
//                let messageObj = self.messageFrom(dic)
//                messageArr.append(messageObj)
//            }
//            handler(messageArr)
//        }
        
        if let email = userEmail {
            let messagesRef = self.ref.child("Messages")
                .queryOrdered(byChild: "name")
                .queryEqual(toValue: email)
            messagesRef.observeSingleEvent(of: .value) { (snapshot) in
                var messageArr: [Message] = []
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let dic = snap.value as! NSDictionary
                    let messageObj = self.messageFrom(dic)
                    messageArr.append(messageObj)
                }
                handler(messageArr)
            }
            
        } else {
            handler(nil)
        }
    }
    
    private static func messageDicFrom(message: Message) -> [String : Any] {
        let dic: [String : Any] = [
            kID         : "\(message.id)",
            kAlgorithm  : "\(message.algorithm.rawValue)",
            kKey        : "\(message.key)",
            kMessage    : "\(message.message)",
            kMsgPassword: "\(message.password)",
            kDate       : "\(message.date)",
            kName       : "\(message.name)"
        ]
//        return NSDictionary(objects: [message.id,
//                                      message.algorithm,
//                                      message.key,
//                                      message.message,
//                                      message.password,
//                                      message.date,
//                            ],
//                            forKeys: [kID as NSCopying,
//                                      kAlgorithm as NSCopying,
//                                      kKey as NSCopying,
//                                      kMessage as NSCopying,
//                                      kMsgPassword as NSCopying,
//                                      kDate as NSCopying,
//                            ]) as! [String : String]
        return dic
    }
    
    private static func messageFrom(_ dic: NSDictionary) -> Message {
        let txtAlgorithm = dic["algorithm"] as! String
        let name = dic["name"] as! String
        let message = dic["message"] as! String
        let password = dic["password"] as! String
        let id = dic["id"] as! String
        let key = dic["key"] as! String
        let date = dic["date"]  as! String
        let algorithm = EncryptionType(rawValue: txtAlgorithm)
        
        let messageObj = Message(name: name, algorithm: algorithm!, id: id, message: message, key: key, password: password, date: date)
        return messageObj
        
    }
}
