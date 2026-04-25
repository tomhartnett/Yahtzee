//
//  ScorecardView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI
import YahtzeeKit

struct ScorecardView: View {
    @Environment(\EnvironmentValues.layoutMetrics) private var layoutMetrics

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

                UpperBonusRowView(
                    playerTotal: playerScorecard.upperBonus,
                    opponentTotal: opponentScorecard.upperBonus
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

extension ScorecardView {
    struct TotalRowView: View {
        @Environment(\EnvironmentValues.layoutMetrics) private var layoutMetrics

        var playerTotal: Int
        var opponentTotal: Int

        var body: some View {
            HStack {
                Text("")
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)

                Text(playerTotal.formatted())
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)
                    .font(.system(size: layoutMetrics.bodyFontSize))
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)

                Text(opponentTotal.formatted())
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)
                    .font(.system(size: layoutMetrics.bodyFontSize))
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)
            }
        }
    }

    struct UpperBonusRowView: View {
        @Environment(\EnvironmentValues.layoutMetrics) private var layoutMetrics

        var playerTotal: Int
        var opponentTotal: Int

        var body: some View {
            HStack {
                Text("")
                    .font(.system(size: layoutMetrics.titleFontSize))
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)

                Text(playerTotal > 0 ? playerTotal.formatted() : "")
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)
                    .font(.system(size: layoutMetrics.bodyFontSize))
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)

                Text(opponentTotal > 0 ? opponentTotal.formatted() : "")
                    .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)
                    .font(.system(size: layoutMetrics.bodyFontSize))
                    .monospaced()
                    .minimumScaleFactor(0.1)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private extension Scorecard {
    static var previewWithUpperBonus: Scorecard {
        var scorecard = Scorecard()
        scorecard.score(ScoreBox(scoreType: .ones, value: 3, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .twos, value: 6, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .threes, value: 9, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fours, value: 12, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fives, value: 15, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .sixes, value: 18, possibleValue: nil))
        return scorecard
    }

    static var previewWithoutUpperBonus: Scorecard {
        var scorecard = Scorecard()
        scorecard.score(ScoreBox(scoreType: .ones, value: 1, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .twos, value: 6, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .threes, value: 9, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fours, value: 12, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fives, value: 15, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .sixes, value: 12, possibleValue: nil))
        return scorecard
    }
}

#Preview {
    ScorecardView(
        playerScorecard: .constant(Scorecard.previewWithUpperBonus),
        opponentScorecard: .constant(Scorecard.previewWithoutUpperBonus),
        selectedScoreType: .constant(nil)
    )
    .padding()
}
