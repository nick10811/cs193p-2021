//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI

@main // entry point, just like main.c
struct MemorizeApp: App {
    private let game = EmojiMemoryGame() // "make" things private by default, remove the private if need
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game) // main area
        }
    }
}
