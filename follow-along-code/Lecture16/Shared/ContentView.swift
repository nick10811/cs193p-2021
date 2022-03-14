//
//  ContentView.swift
//  Shared
//
//  Created by Nick Yang on 2022/3/14.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: EmojiArtDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(EmojiArtDocument()))
    }
}
