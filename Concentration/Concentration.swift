//
//  Concentration.swift
//  Concentration
//
//  Created by Alejandro Barranco on 8/1/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var cardsAlreadySeen: [Card]
    private(set) var score: Int
    private(set) var flipCounts: Int

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var dateForOneAndOnlyFaceUpCard: Date?
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var randomCards = cards
        
        for index in randomCards.indices {
            //let randomIndex =
            randomCards[index] = cards.remove(at: cards.count.arc4random)
        }
        
        cards = randomCards
        
        // reset
        score = 0
        flipCounts = 0
        cardsAlreadySeen = [Card]()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentraition.chooseCard(at: \(index)): choosen index not in the cards")
        flipCounts += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    score += getExtraPointsFor(initDate: dateForOneAndOnlyFaceUpCard)
                } else {
                    for cardSeen in cardsAlreadySeen {
                        if cardSeen == cards[index] { score -= 1 }
                        if cardSeen == cards[matchIndex] { score -= 1 }
                    }
                    
                    if !cardsAlreadySeen.contains(cards[index]) {
                        cardsAlreadySeen.append(cards[index])
                    }
                    if !cardsAlreadySeen.contains(cards[matchIndex]) {
                        cardsAlreadySeen.append(cards[matchIndex])
                    }
                }
                cards[index].isFaceUp = true
                dateForOneAndOnlyFaceUpCard = nil
                
            } else {
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


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
