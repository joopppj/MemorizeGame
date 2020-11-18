//
//  ContentView.swift
//  Memorize
//
//  Created by キラ on 2020/10/27.
//  Copyright © 2020 Kira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            ForEach(0..<4,content:{ index in
                CardView()
            })
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
        
    }
}

struct CardView: View{
    var isFaceUp: Bool = false
    var body: some View{
        ZStack(content: {
            if isFaceUp{
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth:3)
            Text("🤠")
            } else {
            RoundedRectangle(cornerRadius: 10.0).fill()
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
