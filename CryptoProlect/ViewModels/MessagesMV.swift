//
//  MessgesVM.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

protocol MessgesDelegate {
    
}

class MessagesMV {
    
    var delegate: MessgesDelegate?
    var messages: [Message]
    
    init(message: [Message]) {
        self.messages = message
    }
    
    var messagsCount: Int {
        return messages.count
    }
    
    func getMessage(at index: Int) -> Message{
        return messages[index]
    }
}
