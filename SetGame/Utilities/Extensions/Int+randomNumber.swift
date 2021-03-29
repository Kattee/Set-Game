//
//  Int+randomNumber.swift
//  SetGame
//
//

import Foundation

extension Int {
    
    ///return random integer number
    var randomNumber: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}
