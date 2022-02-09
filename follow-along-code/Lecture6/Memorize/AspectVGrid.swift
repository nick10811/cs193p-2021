//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Nick Yang on 2022/2/9.
//

import SwiftUI

// generic View combiner
struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable { // ItemView behaves like a View
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView // View & some View can't be used here
    
    var body: some View {
        let width: CGFloat = 100
        LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
            ForEach(items) { item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
