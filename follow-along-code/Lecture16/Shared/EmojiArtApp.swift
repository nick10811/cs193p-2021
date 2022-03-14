//
//  EmojiArtApp.swift
//  Shared
//
//  Created by Nick Yang on 2022/3/14.
//

import SwiftUI

@main
// App protocol
struct EmojiArtApp: App {
    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Default")
    
    // Scene: contains the top-level View of application
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)
                .environmentObject(paletteStore)
        }
    }
}
