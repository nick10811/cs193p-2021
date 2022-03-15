//
//  iOS.swift
//  EmojiArt (iOS)
//
//  Created by Nick Yang on 2022/3/14.
//

import SwiftUI

// platform-specific code

extension View {
    @ViewBuilder
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            NavigationView {
                self
                    .navigationBarTitleDisplayMode(.inline)
                    .dismissable(dismiss)
            }
        } else {
            self
        }
    }
    
    @ViewBuilder
    func dismissable(_ dismiss: (() -> Void)?) -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            self.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        } else {
            self
        }
    }
    
    func plainButtonOnMacOnly() -> some View {
        self
    }
    func paletteButtonStyle() -> some View {
        self
    }
    
}

// create an abstraction both in iOS & macOS
extension UIImage {
    var imageData: Data? { jpegData(compressionQuality: 1.0) }
}

// a struct which contains statics to access the Pasteboard
struct Pasteboard {
    static var imageData: Data? {
        UIPasteboard.general.image?.imageData
    }
    
    static var imageURL: URL? {
        UIPasteboard.general.url?.imageURL
    }
}
