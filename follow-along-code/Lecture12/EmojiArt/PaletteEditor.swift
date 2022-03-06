//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/3/2.
//

import SwiftUI

struct PaletteEditor: View {
//    @State private var palette: Palette = PaletteStore(named: "Test").palette(at: 2)
    // @Binding cannot be private
    @Binding var palette: Palette
    
    var body: some View {
        Form {
            //            TextField("Name", text: $palette.name)
            nameSection
        }
        .frame(minWidth: 300, minHeight: 350)
        // $ is binding palette.name & @State palette
//        TextField("Name", text: $palette.name)
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $palette.name)
        }
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
//        Text("Fixe Me!")
        PaletteEditor(palette: .constant(PaletteStore(named: "Preview").palette(at: 4)))
            .previewLayout(.fixed(width: 300, height: 350))
    }
}
