//
//  Cardify.swift
//  Memorize
//
//  Created by Nick Yang on 2022/2/13.
//

import SwiftUI

// custom modifier: card animation -> isFaceUp
struct Cardify: ViewModifier {
    var isFaceUp: Bool

    // we copy the content of CardView and paste here
    // we're not doing anything with EmojiMemoryGame.Cards
    // we're just modifying any old kind of view here
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            } else {
                shape.fill()
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10 // we use CGFloat in drawing
        static let lineWidth: CGFloat = 3
    }
    
}
