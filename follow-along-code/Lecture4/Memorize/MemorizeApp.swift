//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI

@main // entry point, just like main.c
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game) // main area
        }
    }
}
