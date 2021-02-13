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
        VStack{
            Grid(viewModel.cards){ card in
                    CardView(card: card ).onTapGesture {
                        withAnimation(Animation.linear){
                            self.viewModel.choose(card: card)
                        }
                }.padding(5)//.aspectRatio(0.66,contentMode: .fit) a1 question
            }//.aspectRatio(0.66,contentMode: .fit)
                .padding()
                .foregroundColor(Color.red)
            Button(action: {
                withAnimation(.easeInOut){ // !!! animation two
                    self.viewModel.resetGame()
                    
                }
            }, label: { Text("reset")})
        }
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
    
    @ViewBuilder
    private func body(for size: CGSize)-> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.init(degrees: 270), endAngle: Angle.init(degrees: 20), clockwise: true).padding(5).opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: min(size.width,size.height)*fontScaleFactor))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)// !!! animation three
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale) // !!!animation one
        }
    }
    // MARK: - Drawing Constants

    private let fontScaleFactor: CGFloat = 0.7
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

