//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by キラ on 2020/11/16.
//  Copyright © 2020 Kira. All rights reserved.
// this is viewmodel

import SwiftUI

class EmojiMemoryGame{
    private var model:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame()-> MemoryGame<String>{
        let emoji = ["🐰","🐷","🐹"]
        return MemoryGame<String>(numberOfpairsOfCards: emoji.count)
            {(pairIndex: Int)  -> String in
            return emoji[pairIndex]
        }
    }
    
    // mark: access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // mark: - intent(s)
    func choose(card:MemoryGame<String>.Card)  {
        model.choose(card: card)
    }
}
