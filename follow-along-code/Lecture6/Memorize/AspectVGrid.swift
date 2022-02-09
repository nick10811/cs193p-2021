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
        LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
            ForEach(items) { item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
