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
                        withAnimation(Animation.linear(duration: 0.5)){
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
    
    @State private var animatedBonusRemaning: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaning = card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining)){
            animatedBonusRemaning = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize)-> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.init(degrees: -90), endAngle: Angle.init(degrees: -animatedBonusRemaning*360-90), clockwise: true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.init(degrees: -90), endAngle: Angle.init(degrees: -card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.scale)
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

