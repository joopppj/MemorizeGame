//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by キラ on 2020/10/27.
//  Copyright © 2020 Kira. All rights reserved.
//this is view

import SwiftUI

struct EmojiMemoryGameView: View { // represent all cards stack
    var viewModel:EmojiMemoryGame
    var body: some View {
        HStack{
            ForEach(viewModel.cards){ card in
                CardView(card: card ).onTapGesture {
                    self.viewModel.choose(card: card)
                }//.aspectRatio(0.66,contentMode: .fit)
            }.aspectRatio(0.66,contentMode: .fit)
        }
        .padding()
        .foregroundColor(Color.red)
        .font(viewModel.cards.count < 5 ? Font.largeTitle : Font.body)
        //.aspectRatio(0.66,contentMode: .fit)
        
    }
}

struct CardView: View{ // represent single card
    var card: MemoryGame<String>.Card
    var body: some View{
        ZStack(content: {
            if card.isFaceUp{
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth:3)
                Text(card.content)
            } else {
            RoundedRectangle(cornerRadius: 10.0).fill()
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
