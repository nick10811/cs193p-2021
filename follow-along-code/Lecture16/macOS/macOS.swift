//
//  macOS.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/3/14.
//

import SwiftUI

// platform-specific code

// typealias UIImage to NSImage on macOS only
typealias UIImage = NSImage

// make compile succeed
typealias PaletteManager = EmptyView

// on macOS, there is no init(uiImage:) instead, it is init(nsImage:)
extension Image {
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}

extension View {
    // no need to make a macOS sheet/popover dismissable
    // because you can just tap elsewhere to dismiss
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View {
        self
    }
}
