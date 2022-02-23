//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/2/19.
//

import SwiftUI

// ViewModel -> always class
class EmojiArtDocument: ObservableObject
{
    @Published private(set) var emojiArt: EmojiArtModel {
        didSet {
            if emojiArt.background != oldValue.background {
                fetchBackgroundImageDataIfNeccesary()
            }
        }
    }
    
    init() {
        emojiArt = EmojiArtModel()
        addEmoji("😇", at: (-200, -100), size: 80)
        addEmoji("💪", at: (50, 100), size: 40)
    }
    
    // convience functions
    var emojis: [EmojiArtModel.Emoji] { emojiArt.emojis }
    var background: EmojiArtModel.Background { emojiArt.background }
    
    @Published var backgroundImage: UIImage?
    
    private func fetchBackgroundImageDataIfNeccesary() {
        
    }
 
    // MARK: - Intent(s)
    func setBackground(_ background: EmojiArtModel.Background) {
        emojiArt.background = background
        print("backgroud set to \(background)")
    }
    
    func addEmoji(_ emoji: String, at location: (x: Int, y: Int), size: CGFloat) {
        emojiArt.addEmoji(emoji, at: location, size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            emojiArt.emojis[index].size += Int(CGFloat(emojiArt.emojis[index].size)) * Int(scale)
        }
    }
}
