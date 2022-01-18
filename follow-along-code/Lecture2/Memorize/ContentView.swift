//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI // working on UI

struct ContentView: View {
//    let emojis: Array<String> = ["🚙","🚌","🚛","🚑"]
//    let emojis: [String] = ["🚙","🚌","🚛","🚑"]
    let emojis = ["🚙","🚌","🚛","🚑","🛴","🛵","🚃","🚂","✈️","🚀","🛸","🚁","⛵️","⛴","🚲","🛻","🚜","🚚","🛩","🚒","🚤","🛶","🚠","🛺"]
    @State var emojiCount = 20 // @State: a property wrapper type (https://developer.apple.com/documentation/swiftui/state)
    
    var body: some View {
        VStack { // ViewsBuilder
            ScrollView {
                // LazyVGrid: likes web `grid-template-columns`
//            LazyVGrid(columns: [GridItem(.fixed(200)),GridItem(.flexible()),GridItem()]) {
//                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        //            CardView(isFaceUp: false) // override default `isFaceUp`
                    // ForEach: needs to be identifiable (https://developer.apple.com/documentation/swiftui/foreach)
                    // `\.self`: KeyPath(type alias) https://sarunw.com/posts/what-is-keypath-in-swift/
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 { // boundary limitation
                emojiCount -= 1
            }
        }, label: {
            // download SF symbols to find system name -> https://developer.apple.com/sf-symbols/
            Image(systemName: "minus.circle")
        })
    }
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
//            VStack {
//                Text("Add")
//                Text("Card")
//            }
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack { // Zstack: z-axis stack
//            let shape = Circle()
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            // self means entire View. it's immutable
            isFaceUp = !isFaceUp
        }
    }
}

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider { // glues preview to ContentView
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
