//
//  Deck.swift
//  SetGame
//
//

import Foundation

struct Deck {
    
    //MARK: - Properties
    
    var cards: [Card] = []
    
    //MARK: - Deck
    
    init() {
        createCards()
    }
    
    //MARK: - Public
    
    mutating func draw() -> Card? {
        return !cards.isEmpty ? cards.remove(at: cards.count.randomNumber) : nil
    }
    
    //MARK: - Private
    
    private mutating func createCards() {
        for symbol in SymbolType.allCases {
            for color in ColorType.allCases {
                for number in NumberType.allCases{
                    for shade in ShadeType.allCases {
                        cards.append(Card(symbol: symbol, color: color, number: number, shade: shade))
                    }
                }
            }
        }
    }
    
}
