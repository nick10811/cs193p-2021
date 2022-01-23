//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/23.
//

import SwiftUI

//func makeCardContent(index: Int) -> String {
//    return "😜"
//}

// ViewModel: part of UI, gatekeeper, intermediary between Model & View
class EmojiMemoryGame {
    static let emojis = ["🚙","🚌","🚛","🚑","🛴","🛵","🚃","🚂","✈️","🚀","🛸","🚁","⛵️","⛴","🚲","🛻","🚜","🚚","🛩","🚒","🚤","🛶","🚠","🛺"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex] // full name -> EmojiMemoryGame.emojis
        }
    }
    
    // give a data type as string; set private to prevent View to change it
//    private var model: MemoryGame<String> =
//        MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: makeCardContent)
//    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4) { _ in "😜" }
//    private var model: MemoryGame<String> =
//    MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
//        // error: Cannot use instance member 'emojis' within property initializer; property initializers run before 'self' is available
//        // sol1. init in `struct`.
//        // sol2. make `emojis` as global variable. but it's not good idea. because it pollutes entire codes.
//        // sol3. set static before `let` to keep it global.
//        EmojiMemoryGame.emojis[pairIndex] // full name -> EmojiMemoryGame.emojis
//    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    // read-only
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
//    func foo() {
//        // you should use full name EmojiMemoryGame.emojis to use static member
//        let x = emojis
//    }
}
