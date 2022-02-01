//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/23.
//

import Foundation

// Model: data + logic
struct MemoryGame<CardContent> where CardContent: Equatable { // generic over CardContent
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // computed property
        // avoid to out of sync due to card & indexOfTheOneAndOnlyFaceUpCard are store in differenct area
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
//            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
//            return faceUpCardIndices.oneAndOnly
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
            // move to extension, funtional programming -> function-pass-to-a-function
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
//            for index in cards.indices {
//                cards[index].isFaceUp = (index == newValue)
////                if index != newValue {
////                    cards[index].isFaceUp = false
////                } else {
////                    cards[index].isFaceUp = true
////                }
//            }
//        }
    }
    
    // HINT: struct default is immutable
    internal mutating func choose(_ card: Card) { // internal means used anywhere within app by default, so there's no reason put on here
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable { // make struct can be identifiable
        var isFaceUp = true
        var isMatched = false
        let content: CardContent // we don't want to the card can be changed in any way after the card is created
        let id: Int // the id never changes once the card is created
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
