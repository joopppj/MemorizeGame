//
//  MemoryGame.swift
//  Memorize
//
//  Created by キラ on 2020/11/16.
//  Copyright © 2020 Kira. All rights reserved.


// This is model!!!!!

import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card:Card){
        print("card chosen:\(card)")
        
    }
    
    init(numberOfpairsOfCards:Int, cardContentFactory: (Int)->CardContent) {
        self.cards = Array<Card>()
        for pairIndex in 0..<numberOfpairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card( content: content,id:pairIndex*2))
            cards.append(Card( content: content,id:pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
