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
            scheduleAutosave()
            if emojiArt.background != oldValue.background {
                fetchBackgroundImageDataIfNeccesary()
            }
        }
    }
    
    private var autosaveTimer: Timer?
    
    private func scheduleAutosave() {
        autosaveTimer?.invalidate() // cancel previous timer
        autosaveTimer = Timer.scheduledTimer(withTimeInterval: Autosave.coalescingInterval, repeats: false) { _ in
            // I want to this clousre to hold this self in the memory.
            // I have a chance to autosave it.
            // Hence, I don't put [weak self] in here
            // ( It's a feature not a bug)
            self.autosave()
        }
    }
    
    // constant struct
    private struct Autosave {
        static let filename = "Autosaved.emojiart" // image like jpeg, tiff
        static var url: URL? {
            // in the main queue
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return documentDirectory?.appendingPathComponent(filename)
        }
        static let coalescingInterval = 5.0
    }
    
    private func autosave() {
        if let url = Autosave.url {
            save(to: url)
        }
    }
    
    private func save(to url: URL) {
        // error handling
        let thisfunction = "\(String(describing: self)).\(#function))"
        do {
            let data: Data = try emojiArt.json()
            print("\(thisfunction) json = \(String(data: data, encoding: .utf8))")
            try data.write(to: url)
            print("\(thisfunction) success!")
        } catch let encodingError where encodingError is EncodingError {
            print("\(thisfunction) couldn't encode EmojiArt as JSON because \(encodingError.localizedDescription)")
        } catch {
            print("\(thisfunction) error = \(error)")
        }
    }
    
    init() {
        if let url = Autosave.url,
           let autosavedEmojiArt = try? EmojiArtModel(url: url) {
            // loading from the local storage
            emojiArt = autosavedEmojiArt
            
            // background is from url
            fetchBackgroundImageDataIfNeccesary()
        } else {
            emojiArt = EmojiArtModel()
        }
    }
    
    // convience functions
    var emojis: [EmojiArtModel.Emoji] { emojiArt.emojis }
    var background: EmojiArtModel.Background { emojiArt.background }
    
    @Published var backgroundImage: UIImage?
    @Published var backgoundFetchImageStatus = BackgroundFetchImageStatus.idle
    
    enum BackgroundFetchImageStatus: Equatable {
        case idle
        case fetching
        case failed(URL)
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
                        if self?.backgroundImage == nil {
                            self?.backgoundFetchImageStatus = .failed(url)
                        }
                    }
                }
            }
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
