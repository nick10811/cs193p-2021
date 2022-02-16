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
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if card.isMatched && !card.isFaceUp {
//                Rectangle().opacity(0)
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 2)))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 3)) {
                            game.choose(card)
                        }
                    }

            }
        })
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation{
                game.shuffle()
            }
        }
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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)) // animation only animates changes
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize)) // use fixed size instead
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        // Cardify is going to do all that for us
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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
