//
//  SetCard.swift
//  SetGame
//
//

import Foundation

class SetCard {
    
    //MARK: - Properties
    
    var cardsOnTable: [Card] = []
    var selectedCards: [Card] = []
    var matchedCards: [Card] = []
    var score = 0
    private var startTime = Date()
    private var endTime = Date()
    private var deck = Deck()
    var deckCount: Int {
        return deck.cards.count
    }
    var isSet: Bool? {
        get {
            return matchedCards.count == 3 ? isSet(cards: matchedCards) : nil
        }
        set {
            guard newValue != nil else {
                matchedCards.removeAll()
                return
            }
            newValue == true ? scoreTime() : (score -= 10)
            matchedCards = selectedCards
            selectedCards.removeAll()
        }
    }
    
    //MARK: - SetCard
    
    init() {
        initialSetUp()
    }
    
    //MARK: - Public
    
    func chooseCard(at index: Int) {
        guard cardsOnTable.indices.contains(index) else {
            print("SetCard.chooseCard(at: \(index)) : Chosen index out of range")
            return
        }
        let cardChoosen = cardsOnTable[index]
        if isSet == true {
            replaceOrRemoveMatchedCards()
        }
        isSet = nil
        if selectedCards.count == 2, !selectedCards.contains(cardChoosen) {
            selectedCards += [cardChoosen]
            endTime = Date()
            isSet = isSet(cards: selectedCards)
        } else {
            selectDeselectCard(card: cardChoosen)
            startTime = Date()
        }
    }
    
    func dealCards() {
        guard let dealCards = drawNewCards() else { return }
        cardsOnTable += dealCards
        if availableSets().count > 0 {
            score -= 5
        }
    }
    
    func isSet(cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        return checkForSet(firstValue: cards[0].color.rawValue, secondValue: cards[1].color.rawValue, thirdValue: cards[2].color.rawValue) &&
            checkForSet(firstValue: cards[0].number.rawValue, secondValue: cards[1].number.rawValue, thirdValue: cards[2].number.rawValue) &&
            checkForSet(firstValue: cards[0].shade.rawValue, secondValue: cards[1].shade.rawValue, thirdValue: cards[2].shade.rawValue) &&
            checkForSet(firstValue: cards[0].symbol.rawValue, secondValue: cards[1].symbol.rawValue, thirdValue: cards[2].symbol.rawValue)
        
    }
    
    func checkForSet(firstValue: Int, secondValue: Int, thirdValue: Int) -> Bool {
        return (firstValue == secondValue && secondValue == thirdValue) || (firstValue != secondValue && secondValue != thirdValue && firstValue != thirdValue)
    }
    
    //MARK: - Private
    
    private func initialSetUp() {
        for _ in 1...12 {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }

    private func availableSets() -> [[Int]] {
        guard cardsOnTable.count > 2 else {
            return []
        }
        var availableSets: [[Int]] = []
        for i in 0..<cardsOnTable.count {
            for j in (i+1)..<cardsOnTable.count {
                for k in (j+1)..<cardsOnTable.count {
                    let cards = [cardsOnTable[i], cardsOnTable[j], cardsOnTable[k]]
                    if isSet(cards: cards) {
                        availableSets.append([i, j, k])
                    }
                }
            }
        }
        return availableSets
    }
    
    private func scoreTime() {
        let timeInterval: Double = endTime.timeIntervalSince(startTime)
        switch timeInterval {
        case 0..<5:
            score += 30
        case 5..<11:
            score += 20
        default:
            score += 10
        }
    }
    
    private func drawNewCards() -> [Card]? {
        var newCards: [Card] = []
        for _ in 0...3 {
            if let card = deck.draw() {
                newCards += [card]
            } else {
                return nil
            }
        }
        return newCards
    }
    
    private func replaceOrRemoveMatchedCards() {
        if let takeNewCards = drawMoreCards() {
            replaceCards(cards: matchedCards, with: takeNewCards)
        } else {
            cardsOnTable = cardsOnTable.filter { !matchedCards.contains($0) }
        }
        matchedCards.removeAll()
    }
    
    private func drawMoreCards() -> [Card]? {
        var threeCards: [Card] = []
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            } else {
                return nil
            }
        }
        return threeCards
    }
    
    private func selectDeselectCard(card: Card) {
        if let card = selectedCards.firstIndex(of: card) {
            selectedCards.remove(at: card)
        } else {
            selectedCards.append(card)
        }
    }
    
    private func replaceCards(cards: [Card], with new: [Card]) {
        guard cards.count == new.count else { return }
        for index in 0..<new.count {
            if let indexMatched = cardsOnTable.firstIndex(of: cards[index]) {
                cardsOnTable [indexMatched] = new[index]
            }
        }
    }
    
}
