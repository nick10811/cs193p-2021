//
//  EmojiArtApp.swift
//  Shared
//
//  Created by Nick Yang on 2022/3/14.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: EmojiArtDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
