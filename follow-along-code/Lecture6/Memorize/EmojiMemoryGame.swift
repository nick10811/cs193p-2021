//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/23.
//

import SwiftUI

// ViewModel: part of UI, gatekeeper, intermediary between Model & View
class EmojiMemoryGame: ObservableObject { // MVVM notification
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚙","🚌","🚛","🚑","🛴","🛵","🚃","🚂","✈️","🚀","🛸","🚁","⛵️","⛴","🚲","🛻","🚜","🚚","🛩","🚒","🚤","🛶","🚠","🛺"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex] // full name -> EmojiMemoryGame.emojis
        }
    }

    // anytime if mode chages so we dont need objectWillChange
    @Published private var model = createMemoryGame() // type inference in Swift, so we dont need to set type here
    
    // read-only
    var cards: Array<Card> {
        return model.cards
    }

    // MARK: - Intent(s)
    
    func choose (_ card: Card) {
//        objectWillChange.send() // send to this world that this objectWillChange, you can call it anytime
        model.choose(card)
    }
}
