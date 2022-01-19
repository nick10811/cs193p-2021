//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/19.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(emojis, id: \.self) { emoji in
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
                emojis = CardController.shared.shuffle(by: .vehicle)
            } label: {
                VStack {
                    Image(systemName: "car")
                    Text(ThemeType.vehicle.description).font(.caption)
                }
            }
        }
    }
    
    var animalsTheme: some View {
        Button {
            emojis = CardController.shared.shuffle(by: .animal)
        } label: {
            VStack {
                Image(systemName: "hare")
                Text(ThemeType.animal.description).font(.caption)
            }
        }
    }
    
    var foodTheme: some View {
        Button {
            emojis = CardController.shared.shuffle(by: .food)
        } label: {
            VStack {
                Image(systemName: "f.circle.fill")
                Text(ThemeType.food.description).font(.caption)
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
