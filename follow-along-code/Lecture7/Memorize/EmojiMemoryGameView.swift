//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI

// quick tool: command + click
// View: agent for showing what in the Model throught the ViewModel
struct EmojiMemoryGameView: View {
    // something changed, plz rebuild entire body
    @ObservedObject var game: EmojiMemoryGame // we don't set value here instead of passing it in the VM
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }

            }
        })
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
}

// read-only struct
struct CardView: View {
    let card: EmojiMemoryGame.Card // only pass into it the minimum it needs
    
    var body: some View {
        // CGSize()
        GeometryReader(content: { geometry in
            ZStack { // Zstack: z-axis stack
//                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
//                if card.isFaceUp {
//                    shape.fill().foregroundColor(.white)
//                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
//                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
//                        .padding(5).opacity(0.5)
//                    Text(card.content).font(font(in: geometry.size))
//                } else if card.isMatched {
//                    shape.opacity(0)
//                } else {
//                    shape.fill()
//                }
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
            }
//            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        // Cardify is going to do all that for us
//        static let cornerRadius: CGFloat = 10 // we use CGFloat in drawing
//        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider { // glues preview to ContentView
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!) // make convience for testing 
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
