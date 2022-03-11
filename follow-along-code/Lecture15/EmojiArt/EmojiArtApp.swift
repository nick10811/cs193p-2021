//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/2/19.
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
//        WindowGroup {
//            // this closure is creating one of those Scenes
//            // and use same VM in those Scense
//            EmojiArtDocumentView(document: document)
//                .environmentObject(paletteStore)
//        }
    }
}
