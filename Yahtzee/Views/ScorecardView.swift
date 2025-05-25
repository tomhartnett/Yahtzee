//
//  ScorecardView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI
import YahtzeeKit

struct ScorecardView: View {
    @Binding var playerScorecard: Scorecard

    @Binding var opponentScorecard: Scorecard

    @Binding var selectedScoreType: ScoreType?

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                ScoreRowView(playerScore: playerScorecard.ones,
                             opponentScore: opponentScorecard.ones,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.twos,
                             opponentScore: opponentScorecard.twos,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.threes,
                             opponentScore: opponentScorecard.threes,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.fours,
                             opponentScore: opponentScorecard.fours,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.fives,
                             opponentScore: opponentScorecard.fives,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.sixes,
                             opponentScore: opponentScorecard.sixes,
                             selectedScoreType: $selectedScoreType)

                TotalRowView(
                    playerTotal: playerScorecard.upperTotal,
                    opponentTotal: opponentScorecard.upperTotal
                )
            }

            Spacer()

            VStack {
                ScoreRowView(playerScore: playerScorecard.threeOfAKind,
                             opponentScore: opponentScorecard.threeOfAKind,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.fourOfAKind,
                             opponentScore: opponentScorecard.fourOfAKind,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.fullHouse,
                             opponentScore: opponentScorecard.fullHouse,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.smallStraight,
                             opponentScore: opponentScorecard.smallStraight,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.largeStraight,
                             opponentScore: opponentScorecard.largeStraight,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.yahtzee,
                             opponentScore: opponentScorecard.yahtzee,
                             selectedScoreType: $selectedScoreType)

                ScoreRowView(playerScore: playerScorecard.chance,
                             opponentScore: opponentScorecard.chance,
                             selectedScoreType: $selectedScoreType)

                TotalRowView(
                    playerTotal: playerScorecard.lowerTotal,
                    opponentTotal: opponentScorecard.lowerTotal
                )
            }
        }
    }
}

#Preview {
    ScorecardView(
        playerScorecard: .constant(Scorecard()),
        opponentScorecard: .constant(Scorecard()),
        selectedScoreType: .constant(nil)
    )
}

extension ScorecardView {
    struct TotalRowView: View {
        var playerTotal: Int
        var opponentTotal: Int

        var body: some View {
            HStack {
                Text("")
                    .frame(width: 40, height: 40)

                Text(playerTotal.formatted())
                    .frame(width: 40, height: 40)
                    .font(.title2)
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)

                Text(opponentTotal.formatted())
                    .frame(width: 40, height: 40)
                    .font(.title2)
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
