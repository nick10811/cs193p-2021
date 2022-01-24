//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI

// View: agent for showing what in the Model throught the ViewModel
struct ContentView: View {
    // something changed, plz rebuild entire body
    @ObservedObject var viewModel: EmojiMemoryGame // we don't set value here instead of passing it in the VM
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    // HINT: (card: card) is redundant, but it's a trade-off. because we should add extra code (customized init) in the struct.
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            // hook up to the Model (user's intend)
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
}

// read-only struct
struct CardView: View {
    let card: MemoryGame<String>.Card // only pass into it the minimum it needs
    
    var body: some View {
        ZStack { // Zstack: z-axis stack
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider { // glues preview to ContentView
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
