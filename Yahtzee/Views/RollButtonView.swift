//
//  RollButtonView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI
import YahtzeeKit

struct RollButtonView: View {
    @Binding var game: Game

    var body: some View {
        Button(action: {
            game.diceCup.roll()
            game.opponentLastTurn = nil
            if let values = game.diceCup.values {
                game.diceAction = .rollDice(values)
                game.isRollInProgress = true
            }
        }) {
            HStack {
                Text("Roll")
                    .font(.title)

                Circle()
                    .frame(width: 20)
                    .foregroundStyle(game.diceCup.remainingRolls > 0 ? .yellow : .gray)



                Circle()
                    .frame(width: 20)
                    .foregroundStyle(game.diceCup.remainingRolls > 1 ? .yellow : .gray)



                Circle()
                    .frame(width: 20)
                    .foregroundStyle(game.diceCup.remainingRolls > 2 ? .yellow : .gray)

            }
            .frame(maxWidth: .infinity, minHeight: 40)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(game.diceCup.remainingRolls <= 0 || game.playerScorecard.isFull)
    }
}

#Preview {
    @Previewable @State var game = Game(.ok)
    RollButtonView(
        game: .constant(game)
    )
}
