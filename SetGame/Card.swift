//
//  Card.swift
//  SetGame
//
//

import Foundation

struct Card: Equatable {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.symbol == rhs.symbol
            && lhs.color == rhs.color
            && lhs.number == rhs.number
            && lhs.shade == rhs.shade
    }
    
    //MARK: - Properties
    
    var symbol: SymbolType
    var color: ColorType
    var number: NumberType
    var shade: ShadeType
    
}
