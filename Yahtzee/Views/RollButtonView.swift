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
    @State private var scale = 1.0

    var body: some View {
        Button(action: {
            withAnimation(.bouncy) {
                scale *= 1.05
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.bouncy) {
                    scale = 1.0
                }
            }

            game.diceCup.roll()
            game.opponentLastTurn = nil
            if let values = game.diceCup.values {
                game.diceAction = .rollDice(values, nil)
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
        .scaleEffect(scale)
        .animation(.spring(duration: 0.25, bounce: 0.75), value: scale)
        .disabled(game.diceCup.remainingRolls <= 0 || game.playerScorecard.isFull)
    }
}

#Preview {
    @Previewable @State var game = Game(.ok)
    RollButtonView(
        game: .constant(game)
    )
}
