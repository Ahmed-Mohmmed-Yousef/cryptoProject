//
//  Encryption.swift
//  CryptoProlect
//
//  Created by Ahmed on 4/8/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation
//import CommonCrypto

public enum EncryptionType: String {
    case Reverse = "ReverseCipher"
    case Caeser = "CaeserCipher"
    case ROT13 = "Rot13Cipher"
    case Columnar = "ColumnarTranspositionCipher"
    case DES = "DESCipher"
    
    
    static var items: [String] {
        return ["Reverse", "Caeser", "ROT13", "Columnar", "DES"]
    }
}

class Encryption {
    
    static private let intKey = 6
    static private let strKey = "HACK"
    
    static func reverseEnc(text: String) -> String{
        let msg: [Character] = Array(text)
        var translated = ""
        var i = msg.count - 1

        while (i >= 0) {
            translated.append(msg[i])
            i = i - 1
        }
        return translated
    }

    private static func mod(_ num1: Int, _ num2: Int) -> Int {
        var mod  = num1 % num2
        while mod < 0 {
            mod += num2
        }
        return mod
    }
    
    static func caeserEnc(text: String, key: Int = intKey) -> String{
        let lowerAlphabet = Array("abcdefghijklmnopqrstuvwxyz")
        let upperAlphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let chars: [Character] = Array(text)
        var result = ""
        for char in chars {
            if char.isLetter {
                
                if char.isUppercase {
                    let charIndex = upperAlphabet.firstIndex(of:char)!
                    let newIndex  = (charIndex + key) % upperAlphabet.count
                    let newChar   = upperAlphabet[newIndex]
                    result.append(newChar)
                } else {
                    let charIndex = lowerAlphabet.firstIndex(of:char)!
                    let newIndex  = (charIndex + key) % lowerAlphabet.count
                    let newChar   = lowerAlphabet[newIndex]
                    result.append(newChar)
                }
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    static func rot13(text: String) -> String{
        let normal: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        let rotat: [Character] = Array("NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm")
        var result = ""
        for char in text {
            if char.isLetter {
                let indx = normal.firstIndex(of: char)
                let newChar = rotat[indx!]
                result.append(newChar)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    static func columnarTransposition(text: String, key: String = strKey) -> String{
        var result = ""
        var kIndex = 0
        let msgLen = Float(text.count)
        var msgList: [Character] = Array(text)
        let keyList = key.sorted()
        let col = key.count
        var row = msgLen / Float(col)
        row = row.rounded(.up)
        let fillNil = Int((row * Float(col)) - msgLen)
        for _ in 0 ..< fillNil {
            msgList.append("_")
        }
        var matrix: [[Character]] = []
        for i in stride(from: 0, to: msgList.count, by: col) {
            let subList: [Character] = Array(msgList[i...(i + col)-1])
            matrix.append(subList)
        }
        
        for _ in 0..<col{
            let currIdx = key.firstIndex(of: keyList[kIndex])!
            for m in matrix {
                let str = String(m)
                result.append(str[currIdx])
            }
            kIndex += 1
        }
        return result
    }
    
    
}

//extension String {
//
//    func desEncrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
//        if let keyData = key.data(using: String.Encoding.utf8),
//            let data = self.data(using: String.Encoding.utf8),
//            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeDES) {
//
//
//            let keyLength              = size_t(kCCKeySizeDES)
//            let operation: CCOperation = UInt32(kCCEncrypt)
//            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmDES)
//            let options:   CCOptions   = UInt32(options)
//
//
//
//            var numBytesEncrypted :size_t = 0
//
//            let cryptStatus = CCCrypt(operation,
//                                      algoritm,
//                                      options,
//                                      (keyData as NSData).bytes, keyLength,
//                                      iv,
//                                      (data as NSData).bytes, data.count,
//                                      cryptData.mutableBytes, cryptData.length,
//                                      &numBytesEncrypted)
//
//            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
//                cryptData.length = Int(numBytesEncrypted)
//                let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
//                return base64cryptString
//
//            }
//            else {
//                return nil
//            }
//        }
//        return nil
//    }
//}
