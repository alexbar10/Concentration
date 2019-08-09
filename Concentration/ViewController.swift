//
//  ViewController.swift
//  Concentration
//
//  Created by Alejandro Barranco on 8/1/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("card not found")
        }
    }
    
    @IBAction private func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        themeChoosen = themesAvailables[themesAvailables.count.arc4random]
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            // get button and card in that index
            let button = cardButtons[index]
            let card = game.cards[index]
     
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeChoosen.backgroundButton
            }
        }
        scoreLabel.text = "Score: " +  String(game.score)
        updateFlipCountLabel()
        view.backgroundColor = themeChoosen.backgroundView
    }
    
    private func updateFlipCountLabel() {
        // Add attributed string
        let attributes : [NSAttributedString.Key:Any] = [
            NSAttributedString.Key.strokeWidth : 5.0,
            NSAttributedString.Key.strokeColor : UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: " + String(game.flipCounts), attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    private var themeAnimals = Theme(backgroundView: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), backgroundButton: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), emojis: "🐶🐱🦁🐭🐔🐧🐣🦄")
    private var themeFaces = Theme(backgroundView: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundButton: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), emojis: "😀😆😎🤩😡😱😭😏")
    private var themeFood = Theme(backgroundView: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), backgroundButton: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), emojis: "🥩🍚🍏🥑🍪🍩🍺🍕")
    private var themeSport = Theme(backgroundView: #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1), backgroundButton: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), emojis: "⚽️🏀🏈⚾️🎾🎱⛳️⛸")
    private var themeVehicles = Theme(backgroundView: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), backgroundButton: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), emojis: "🚗🚤🚝🚔🏍✈️🛴🚀")
    private var themeChess = Theme(backgroundView: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), backgroundButton: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), emojis: "♚♛♜♝♟♞♕♘")

    private lazy var themesAvailables = [themeAnimals, themeFaces, themeFood, themeSport, themeVehicles, themeChess]
    private var themeChoosen = Theme()
    
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, themeChoosen.emojis.count > 0 {
            let randomStringIndex = themeChoosen.emojis.index(themeChoosen.emojis.startIndex, offsetBy: themeChoosen.emojis.count.arc4random)
            emoji[card] = String(themeChoosen.emojis.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

