//
//  SetViewController.swift
//  SetGame
//
//

import UIKit

class SetViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var dealCardsButton: UIButton!
    
    //MARK: - Properties
    
    private var game = SetCard()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    //MARK: - IBActions
    
    @IBAction private func didTapCard(_ sender: UIButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            print("chosen card was not in card buttons")
            return
        }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    @IBAction private func didTapNewGame(_ sender: UIButton) {
        game = SetCard()
        dealCardsButton.isEnabled = true
        updateViewFromModel()
        
    }
    
    @IBAction private func didTapDealCards(_ sender: UIButton) {
        guard (game.cardsOnTable.count + 4) <= cardButtons.count else { return }
        game.dealCards()
        updateViewFromModel()
    }
    
    //MARK: - Private
    
    private func updateViewFromModel() {
        updateButtonsFromModel()
        scoreLabel.text = "Score: \(game.score)"
        guard (game.cardsOnTable.count) >= cardButtons.count || game.deckCount == 0 else { return }
        dealCardsButton.isEnabled = false
    }
    
    private func updateButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTable.count {
                let card = game.cardsOnTable[index]
                let attributedString  = setAttributedString(card: card)
                button.setAttributedTitle(attributedString, for: UIControl.State.normal)
                button.isHidden = false
                if game.selectedCards.contains(where: { $0 == card }) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                    button.layer.cornerRadius = 5.0
                } else {
                    button.layer.borderWidth = 0.0
                }
                if let areCardsMatch = game.isSet, game.matchedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.cornerRadius = 5.0
                    button.layer.borderColor = areCardsMatch ? UIColor.green.cgColor : UIColor.red.cgColor
                }
            } else {
                button.setAttributedTitle(nil, for: .normal)
                button.setTitle(nil, for: .normal)
                button.isHidden = true
            }
        }
    }
    
    private func setAttributedString(card: Card) -> NSAttributedString {
        let symbols = String(repeating: card.symbol.value, count: card.number.value)
        var attribute: [NSAttributedString.Key: Any]?
        switch card.shade {
        case .solid:
            attribute = [NSAttributedString.Key.foregroundColor: card.color.value]
        case .striped:
            attribute = [NSAttributedString.Key.foregroundColor: UIColor.withAlphaComponent(card.color.value)(0.40)]
        case .open:
            attribute = [NSAttributedString.Key.strokeColor: card.color.value,NSAttributedString.Key.strokeWidth: 10]
        }
        return NSAttributedString(string: symbols, attributes: attribute)
    }

}
