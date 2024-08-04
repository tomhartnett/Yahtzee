//
//  GameScoreView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI

struct GameScoreView: View {
    var playerScore: Int

    var opponentScore: Int

    var remainingTurns: Int

    var body: some View {
        HStack {
            Text("Score:")
            Text("\(playerScore)")
            Text("–")
            Text("\(opponentScore)")
            Text("Remaining Turns: \(remainingTurns)")
        }
        .font(.headline)
    }
}

#Preview {
    GameScoreView(playerScore: 89, opponentScore: 123, remainingTurns: 9)
}
