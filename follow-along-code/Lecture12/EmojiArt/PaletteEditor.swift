//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/3/2.
//

import SwiftUI

struct PaletteEditor: View {
    @State private var palette: Palette = PaletteStore(named: "Test").palette(at: 2)
    
    var body: some View {
        Text(palette.name)
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor()
    }
}
