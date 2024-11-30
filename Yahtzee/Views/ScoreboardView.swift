//
//  ScoreboardView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 11/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreboardView: View {
    var playerScorecard: Scorecard
    var opponentScorecard: Scorecard

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                GridRowContentView(
                    label: "Upper Bonus",
                    playerScore: playerScorecard.upperBonus,
                    opponentScore: opponentScorecard.upperBonus
                )
            }
            .frame(maxWidth: .infinity)
            .border(.secondary)

            VStack(alignment: .leading) {
                GridRowContentView(
                    label: "Yahtzee Bonus",
                    playerScore: playerScorecard.yahtzeeBonus,
                    opponentScore: opponentScorecard.yahtzeeBonus
                )
            }
            .frame(maxWidth: .infinity)
            .border(.secondary)
        }
    }
}

struct GridRowContentView: View {
    var label: String
    var playerScore: Int
    var opponentScore: Int

    var body: some View {
        VStack {
            Text(label)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            HStack {
                Text(playerScore.formatted())
                    .frame(maxWidth: .infinity)

                Text(opponentScore.formatted())
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.secondary)
            .monospaced()
        }
    }
}

#Preview {
    ScoreboardView(playerScorecard: Scorecard(), opponentScorecard: Scorecard())
}
