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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // HINT: struct default is immutable
    mutating func choose(_ card: Card) {
//        if let chosenIndex = index(of: card) { // indexOf is readable
//        if let chosenIndex = cards.firstIndex(where: { aCardInTheCardsArray in aCardInTheCardsArray.id == card.id }) { // more Englishy
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            //        var chosenCard = cards[chosenIndex]
            //        card.isFaceUp = !card.isFaceUp
            //        chosenCard.isFaceUp.toggle()
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
//                for index in 0..<cards.count {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            
            // `print` is a good way for debugging
            // automatically display console: Xcode -> Preferences -> Behaviors -> Generates Outputs
            //        print("chosenCard = \(chosenCard)")
        }
        
        print("\(cards)")
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
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable { // make struct can be identifiable
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
