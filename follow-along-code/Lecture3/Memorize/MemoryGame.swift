//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/23.
//

import Foundation

// Model: data + logic
struct MemoryGame<CardContent> { // generic over CardContent
    private(set) var cards: Array<Card>
    
    // use blank label due to `card: Card` is redundancy
    func choose(_ card: Card) {
        
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        // another languages
//        for pairIndex = 0; pairIndex < numberOfPairsOfCards; pairIndex++ {
//
//        }
    }
    
    // put Card in there for certain purpose ex. MemoryGame.Card, Poker.Card
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
