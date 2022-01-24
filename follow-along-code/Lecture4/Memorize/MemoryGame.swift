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
    
    // HINT: struct default is immutable
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card) // indexOf is readable
//        var chosenCard = cards[chosenIndex]
        //        card.isFaceUp = !card.isFaceUp
//        chosenCard.isFaceUp.toggle()
        cards[chosenIndex].isFaceUp.toggle()

        // `print` is a good way for debugging
        // automatically display console: Xcode -> Preferences -> Behaviors -> Generates Outputs
//        print("chosenCard = \(chosenCard)")
        print("\(cards)")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // bogus!
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable { // make struct can be identifiable
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
