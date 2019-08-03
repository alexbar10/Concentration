//
//  Concentration.swift
//  Concentration
//
//  Created by Alejandro Barranco on 8/1/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var cardsAlreadySeen: [Int]
    var score: Int
    var flipCounts: Int

    var indexOfOneAndOnlyFaceUpCard: Int?
    var dateForOneAndOnlyFaceUpCard: Date?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var randomCards = cards
        
        for index in randomCards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            randomCards[index] = cards.remove(at: randomIndex)
        }
        
        cards = randomCards
        
        // reset
        score = 0
        flipCounts = 0
        cardsAlreadySeen = [Int]()
    }
    
    func chooseCard(at index: Int) {
        flipCounts += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    score += getExtraPointsFor(initDate: dateForOneAndOnlyFaceUpCard)
                } else {
                    for cardSeen in cardsAlreadySeen {
                        if cardSeen == cards[index].identifier { score -= 1 }
                        if cardSeen == cards[matchIndex].identifier { score -= 1 }
                    }
                    
                    if !cardsAlreadySeen.contains(cards[index].identifier) {
                        cardsAlreadySeen.append(cards[index].identifier)
                    }
                    if !cardsAlreadySeen.contains(cards[matchIndex].identifier) {
                        cardsAlreadySeen.append(cards[matchIndex].identifier)
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                dateForOneAndOnlyFaceUpCard = nil
                
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                dateForOneAndOnlyFaceUpCard = Date()
            }
        }
    }
    
    private func getExtraPointsFor(initDate date: Date?) -> Int {
        if let initialDate = date {
            let endDate = Date()
            let dateComponents = Calendar.current.dateComponents([Calendar.Component.second], from: initialDate, to: endDate)
            let seconds = dateComponents.second ?? 0
            
            switch seconds {
            case 0:
                return 10
            case 1...3:
                return 7
            case 4...6:
                return 3
            case 7...9:
                return 1
            default:
                return 0
            }
        }
        return 0
    }
}
