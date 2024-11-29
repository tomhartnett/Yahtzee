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
            Grid(alignment: .leading) {
                GridRow {
                    GridRowContentView(
                        label: "Upper Section",
                        playerScore: playerScorecard.upperTotal,
                        opponentScore: opponentScorecard.upperTotal
                    )
                }

                GridRow {
                    GridRowContentView(
                        label: "Upper Bonus",
                        playerScore: playerScorecard.upperBonus,
                        opponentScore: opponentScorecard.upperBonus
                    )
                }
            }
            .frame(maxWidth: .infinity)

            Divider()

            Grid(alignment: .leading) {
                GridRow {
                    GridRowContentView(
                        label: "Lower Section",
                        playerScore: playerScorecard.lowerTotal,
                        opponentScore: opponentScorecard.lowerTotal
                    )
                }

                GridRow {
                    GridRowContentView(
                        label: "Yahtzee Bonus",
                        playerScore: playerScorecard.yahtzeeBonus,
                        opponentScore: opponentScorecard.yahtzeeBonus
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct GridRowContentView: View {
    var label: String
    var playerScore: Int
    var opponentScore: Int

    var body: some View {
        Text(label)
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
            .font(.caption)

        Spacer()

        Text(playerScore.formatted())
            .frame(alignment: .trailing)
            .monospaced()

        Spacer()

        Text(opponentScore.formatted())
            .frame(alignment: .trailing)
            .monospaced()
    }
}

#Preview {
    ScoreboardView(playerScorecard: Scorecard(), opponentScorecard: Scorecard())
}
