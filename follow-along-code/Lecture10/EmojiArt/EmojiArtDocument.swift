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
    @Published var backgoundFetchImageStatus = BackgroundFetchImageStatus.idle
    
    enum BackgroundFetchImageStatus {
        case idle
        case fetching
    }
    
    private func fetchBackgroundImageDataIfNeccesary() {
        backgroundImage = nil
        switch emojiArt.background {
        case .url(let url):
            // fetch the url
            backgoundFetchImageStatus = .fetching
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = try? Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    if self?.emojiArt.background == EmojiArtModel.Background.url(url) {
                        self?.backgoundFetchImageStatus = .idle
                        // check that is still the image that the user wants
                        if imageData != nil {
                            self?.backgroundImage = UIImage(data: imageData!)
                        }
                    }
                    // the closure is going to be put in the heap
//                    if imageData != nil {
//                        // `self` makes this closure which lives in memory point to VM
////                        self.backgroundImage = UIImage(data: imageData!)
//                        self?.backgroundImage = UIImage(data: imageData!)
//                    }
                }
            }
//            let imageData = try? Data(contentsOf: url)
//            if imageData != nil {
//                backgroundImage = UIImage(data: imageData!)
//            }
        case .imageData(let data):
            backgroundImage = UIImage(data: data)
        case .blank:
            break
        }
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
