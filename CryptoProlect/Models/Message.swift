//
//  Message.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

struct Message {
    let algorithm: EncryptionType
    let id: String
    let message: String
    let key: String
    let password: String
    let name: String
    var date: String
    
    init(name: String, algorithm: EncryptionType, id: String, message: String, key: String, password: String, date: String = "") {
        self.id = id
        self.name = name
        self.algorithm = algorithm
        self.message = message
        self.key = key
        self.password = password
        if date.isEmpty {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "MM/dd/yyyy"
            self.date = dateformatter.string(from: Date())
        } else {
            self.date = date
        }
        
    }
}
