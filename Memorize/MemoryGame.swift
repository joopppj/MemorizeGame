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
    
    // since this is a struct, when we change self parameter, we get the copy we need to write mutating
    mutating func choose(card:Card){
        print("card chosen:\(card)")
        let chosenIndex:Int = self.index(of:card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return 0 // TODO: bogus
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
