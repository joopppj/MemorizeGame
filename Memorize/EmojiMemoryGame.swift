//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by キラ on 2020/11/16.
//  Copyright © 2020 Kira. All rights reserved.
// this is viewmodel

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame()-> MemoryGame<String>{
        let emoji = ["🐰","🐷","🐹","🐥","🦐"]
        // assignment 1 q4
        let randomCardsNumber=Int.random(in: 2...5)
        
        return MemoryGame<String>(numberOfpairsOfCards: randomCardsNumber)
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
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
