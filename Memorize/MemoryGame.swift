//
//  MemoryGame.swift
//  Memorize
//
//  Created by キラ on 2020/11/16.
//  Copyright © 2020 Kira. All rights reserved.


// This is model!!!!!

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
           let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp}
            return faceUpCardIndices.only
            
        }
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // since this is a struct, when we change self parameter, we get the copy we need to write mutating
    mutating func choose(card:Card){
        print("card chosen:\(card)")
        if let chosenIndex:Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{ // if chosenIndex is nil , the code below will not excute
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{ // case : 1 or more face up cards
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else { // case : all cards face down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            self.cards[chosenIndex].isFaceUp = true
        }
        
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
