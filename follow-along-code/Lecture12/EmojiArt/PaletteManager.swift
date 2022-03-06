//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/3/6.
//

import SwiftUI

struct PaletteManager: View {
    @EnvironmentObject var store: PaletteStore
    @Environment(\.colorScheme) var colorScheme // get environment
    
    @State private var editMode: EditMode = .inactive
    var body: some View {
        NavigationView {
            List {
                ForEach(store.palettes) { palette in
                    // NavigationLink only works inside the NavigationView
                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
                        VStack(alignment: .leading) {
//                            Text(palette.name).font(colorScheme == .dark ? .largeTitle : .caption)
                            Text(palette.name).font(editMode == .active ? .largeTitle : .caption)
                            Text(palette.emojis)
                        }
                    }
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .environment(\.editMode, $editMode) // set to environment
        }
    }
}

struct PaletteManager_Previews: PreviewProvider {
    static var previews: some View {
        PaletteManager()
            .previewDevice("iPhone 8")
            .environmentObject(PaletteStore(named: "Preview"))
            .preferredColorScheme(.light)
    }
}
