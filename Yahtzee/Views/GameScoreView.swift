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

    var body: some View {
        HStack {
            Text("\(playerScore)")
            Text("–")
            Text("\(opponentScore)")
        }
        .font(.title)
    }
}

#Preview {
    GameScoreView(playerScore: 89, opponentScore: 123)
}
