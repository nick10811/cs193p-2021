//
//  Cardify.swift
//  Memorize
//
//  Created by Nick Yang on 2022/2/13.
//

import SwiftUI

// custom modifier: card animation -> isFaceUp
//struct Cardify: ViewModifier {
struct Cardify: AnimatableModifier {
//    var isFaceUp: Bool
    
    // trick way: a little like rename
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    // we copy the content of CardView and paste here
    // we're not doing anything with EmojiMemoryGame.Cards
    // we're just modifying any old kind of view here
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10 // we use CGFloat in drawing
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
