//
//  Grid.swift
//  Memorize
//
//  Created by キラ on 2021/02/02.
//  Copyright © 2021 Kira. All rights reserved.
//  this is stock we created

import SwiftUI

struct Grid<Item,ItemView>: View where Item: Identifiable, ItemView: View{
    var items: [Item]
    var viewForItem:(Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    
    private func body(for layout: GridLayout) -> some View{
        ForEach(items){ item in
            self.body(for: item, in: layout)
           
        }
    }
    
   private  func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height) //create the frame of card
            .position(layout.location(ofItemAt: index)) // put card in correct position
    }
}



