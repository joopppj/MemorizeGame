//
//  MemoryGame.swift
//  Memorize
//
//  Created by キラ on 2020/11/16.
//  Copyright © 2020 Kira. All rights reserved.


// This is model!!!!!

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { // get the index of the only card faceup now
           let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp}
            return faceUpCardIndices.only
            
        }
        set { // make the choose card face up
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
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
    // since this is a struct, when we change self parameter, we get the copy we need to write mutating
    mutating func choose(card:Card){
        print("card chosen:\(card)")
        if let chosenIndex:Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{ // if chosenIndex is nil , the code below will not excute
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{ // case : 1 or more face up cards
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                //indexOfTheOneAndOnlyFaceUpCard = nil ?? possible bug 
            }else { // case : all cards face down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            self.cards[chosenIndex].isFaceUp = true
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false{
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double{
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
         
        var hasEarnedBonus: Bool{
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool{
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
