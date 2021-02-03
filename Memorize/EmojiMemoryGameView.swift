//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by キラ on 2020/10/27.
//  Copyright © 2020 Kira. All rights reserved.
//this is view

import SwiftUI

struct EmojiMemoryGameView: View { // represent all cards stack
    @ObservedObject  var viewModel:EmojiMemoryGame
    var body: some View {
        Grid(viewModel.cards){ card in
                CardView(card: card ).onTapGesture {
                    self.viewModel.choose(card: card)
            }.padding(5)//.aspectRatio(0.66,contentMode: .fit) a1 question
            }//.aspectRatio(0.66,contentMode: .fit)
            .padding()
            .foregroundColor(Color.red)
    // .font(viewModel.cards.count < 5 ? Font.largeTitle : Font.body)
        //.aspectRatio(0.66,contentMode: .fit)
    }
}

struct CardView: View{ // represent single card
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in // geometry here means the card
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize)-> some View{
        ZStack {
            if self.card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                Text(self.card.content)
            } else {
            RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.font(Font.system(size: min(size.width,size.height)*fontScaleFactor))
    }
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.76
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

