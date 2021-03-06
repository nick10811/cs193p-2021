//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/2/19.
//

import SwiftUI
import Combine
import UniformTypeIdentifiers

extension UTType {
    static let emojiart = UTType(exportedAs: "com.nick10811.cs193p.emojiart")
}

// ViewModel -> always class
class EmojiArtDocument: ReferenceFileDocument
//class EmojiArtDocument: ObservableObject
{
    // MARK: - ReferenceFileDocument
    
    static var readableContentTypes = [UTType.emojiart]
    static var writableContentTypes = [UTType.emojiart]
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            emojiArt = try EmojiArtModel(json: data)
            fetchBackgroundImageDataIfNeccesary()
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func snapshot(contentType: UTType) throws -> Data {
        try emojiArt.json()
    }
    
    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: snapshot)
    }
    
//    typealias Snapshot = Data
    
    @Published private(set) var emojiArt: EmojiArtModel {
        didSet {
//            scheduleAutosave()
            if emojiArt.background != oldValue.background {
                fetchBackgroundImageDataIfNeccesary()
            }
        }
    }
    
    // remove all of those
    // we use Document Types instead.
//    private var autosaveTimer: Timer?
//
//    private func scheduleAutosave() {
//        autosaveTimer?.invalidate() // cancel previous timer
//        autosaveTimer = Timer.scheduledTimer(withTimeInterval: Autosave.coalescingInterval, repeats: false) { _ in
//            // I want to this clousre to hold this self in the memory.
//            // I have a chance to autosave it.
//            // Hence, I don't put [weak self] in here
//            // ( It's a feature not a bug)
//            self.autosave()
//        }
//    }
//
//    // constant struct
//    private struct Autosave {
//        static let filename = "Autosaved.emojiart" // image like jpeg, tiff
//        static var url: URL? {
//            // in the main queue
//            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//            return documentDirectory?.appendingPathComponent(filename)
//        }
//        static let coalescingInterval = 5.0
//    }
//
//    private func autosave() {
//        if let url = Autosave.url {
//            save(to: url)
//        }
//    }
//
//    private func save(to url: URL) {
//        // error handling
//        let thisfunction = "\(String(describing: self)).\(#function))"
//        do {
//            let data: Data = try emojiArt.json()
//            print("\(thisfunction) json = \(String(data: data, encoding: .utf8))")
//            try data.write(to: url)
//            print("\(thisfunction) success!")
//        } catch let encodingError where encodingError is EncodingError {
//            print("\(thisfunction) couldn't encode EmojiArt as JSON because \(encodingError.localizedDescription)")
//        } catch {
//            print("\(thisfunction) error = \(error)")
//        }
//    }
    
    init() {
        emojiArt = EmojiArtModel()
//        if let url = Autosave.url,
//           let autosavedEmojiArt = try? EmojiArtModel(url: url) {
//            // loading from the local storage
//            emojiArt = autosavedEmojiArt
//
//            // background is from url
//            fetchBackgroundImageDataIfNeccesary()
//        } else {
//            emojiArt = EmojiArtModel()
//        }
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
    
    // AnyCancellable is part of Combine framwork
    private var backgroundImageFetchCancellable: AnyCancellable?
    
    private func fetchBackgroundImageDataIfNeccesary() {
        backgroundImage = nil
        switch emojiArt.background {
        case .url(let url):
            // fetch the url
            backgoundFetchImageStatus = .fetching
            backgroundImageFetchCancellable?.cancel()
            
            // URLSession solution
            let session = URLSession.shared
            // publisher is conform Publisher
            let publisher = session.dataTaskPublisher(for: url)
                .map { (data, urlResponse) in UIImage(data: data) }
                .replaceError(with: nil)
                // URLSession is placed on the background
                // we need to put it back to the main queue to manipulate UI
                // there is purple warning on the top-right to speicify the UI is placed on the background queue
                .receive(on: DispatchQueue.main)

            backgroundImageFetchCancellable = publisher
                .sink { [weak self] image in
                    self?.backgroundImage = image
                    self?.backgoundFetchImageStatus = (image != nil) ? .idle : .failed(url)
                }
        case .imageData(let data):
            backgroundImage = UIImage(data: data)
        case .blank:
            break
        }
    }
 
    // MARK: - Intent(s)
    func setBackground(_ background: EmojiArtModel.Background, undoManager: UndoManager?) {
        undoablyPerform(operation: "Set Background", with: undoManager) {
            emojiArt.background = background
        }
//        emojiArt.background = background
//        print("backgroud set to \(background)")
    }
    
    func addEmoji(_ emoji: String, at location: (x: Int, y: Int), size: CGFloat, undoManager: UndoManager?) {
        undoablyPerform(operation: "Add \(emoji)", with: undoManager) {
            emojiArt.addEmoji(emoji, at: location, size: Int(size))
        }
//        emojiArt.addEmoji(emoji, at: location, size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize, undoManager: UndoManager?) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            undoablyPerform(operation: "Move", with: undoManager) {
                emojiArt.emojis[index].x += Int(offset.width)
                emojiArt.emojis[index].y += Int(offset.height)
            }
//            emojiArt.emojis[index].x += Int(offset.width)
//            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale: CGFloat, undoManager: UndoManager?) {
        if let index = emojiArt.emojis.index(matching: emoji) {
            undoablyPerform(operation: "Scale", with: undoManager) {
                emojiArt.emojis[index].size += Int(CGFloat(emojiArt.emojis[index].size)) * Int(scale)
            }
//            emojiArt.emojis[index].size += Int(CGFloat(emojiArt.emojis[index].size)) * Int(scale)
        }
    }
    
    // MARK: - Undo
    
    private func undoablyPerform(operation: String, with undoManager: UndoManager? = nil, doit: () -> Void) {
        let oldEmojiArt = emojiArt
        doit()
        undoManager?.registerUndo(withTarget: self) { myself in
            // redo
            myself.undoablyPerform(operation: operation, with: undoManager) {
                myself.emojiArt = oldEmojiArt
            }
        }
        undoManager?.setActionName(operation)
    }
}
