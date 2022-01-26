//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(0..<50) { _ in
                    CardView().aspectRatio(2/3, contentMode: .fill)
                }
            }
        }
        .padding()
        .foregroundColor(.red)
    }
}

struct CardView: View {
    let isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shap =  RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shap.fill().foregroundColor(.white)
                shap.strokeBorder(lineWidth: 3)
                Text("💪").font(.largeTitle)
            } else {
                shap.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().preferredColorScheme(.dark)
    }
}
