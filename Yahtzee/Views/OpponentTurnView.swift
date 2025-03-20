//
//  OpponentTurnView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/20/25.
//

import SwiftUI

struct OpponentTurnView: View {
    var turn: Turn

    var body: some View {
        VStack {
            HStack {
                Image(turn.dice.value1.imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .border(.black)
                Image(turn.dice.value2.imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .border(.black)
                Image(turn.dice.value3.imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .border(.black)
                Image(turn.dice.value4.imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .border(.black)
                Image(turn.dice.value5.imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .border(.black)
            }
            Text("Bot scores **\(turn.score.valueOrZero)** for **\(turn.score.scoreType.displayName)**")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .minimumScaleFactor(0.1)
        }
    }
}
