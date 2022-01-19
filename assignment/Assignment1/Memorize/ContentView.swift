//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/19.
//

import SwiftUI

struct ContentView: View {
    let vehiclesEmoji = ["🚗","🚕","🚙","🚌","🏎","🚑","🚓","🚒","🚐","🛻","🚛","✈️","🛰","🚀","🛸","🚁"]
    let animalsEmoji = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"]
    let foodsEmoji = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥"]
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(vehiclesEmoji[0...12], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding()
            }
            .foregroundColor(.red)
            HStack {
                Spacer()
                vehicleTheme
                Spacer()
                animalsTheme
                Spacer()
                foodTheme
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    var vehicleTheme: some View {
        VStack {
            Button {
                // TODO: button action
            } label: {
                VStack {
                    Image(systemName: "car")
                    Text("vehicle").font(.caption)
                }
            }
        }
    }
    
    var animalsTheme: some View {
        Button {
            // TODO: button action
        } label: {
            VStack {
                Image(systemName: "hare")
                Text("animal").font(.caption)
            }
        }
    }
    
    var foodTheme: some View {
        Button {
            // TODO: button action
        } label: {
            VStack {
                Image(systemName: "f.circle.fill")
                Text("food").font(.caption)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shap = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shap.fill().foregroundColor(.white)
                shap.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shap.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13 mini")
            ContentView().previewDevice("iPhone 13 mini").preferredColorScheme(.dark)
        }
    }
}
