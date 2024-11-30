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
                ScoreTupleView(playerScore: playerScorecard.ones,
                               opponentScore: opponentScorecard.ones,
                               isSelected: selectedScoreType == .ones)
                .onTapGesture {
                    guard playerScorecard.ones.isAvailableForScoring else { return }
                    selectedScoreType = .ones
                }

                ScoreTupleView(playerScore: playerScorecard.twos,
                               opponentScore: opponentScorecard.twos,
                               isSelected: selectedScoreType == .twos)
                .onTapGesture {
                    guard playerScorecard.twos.isAvailableForScoring else { return }
                    selectedScoreType = .twos
                }

                ScoreTupleView(playerScore: playerScorecard.threes,
                               opponentScore: opponentScorecard.threes,
                               isSelected: selectedScoreType == .threes)
                .onTapGesture {
                    guard playerScorecard.threes.isAvailableForScoring else { return }
                    selectedScoreType = .threes
                }

                ScoreTupleView(playerScore: playerScorecard.fours,
                               opponentScore: opponentScorecard.fours,
                               isSelected: selectedScoreType == .fours)
                .onTapGesture {
                    guard playerScorecard.fours.isAvailableForScoring else { return }
                    selectedScoreType = .fours
                }

                ScoreTupleView(playerScore: playerScorecard.fives,
                               opponentScore: opponentScorecard.fives,
                               isSelected: selectedScoreType == .fives)
                .onTapGesture {
                    guard playerScorecard.fives.isAvailableForScoring else { return }
                    selectedScoreType = .fives
                }

                ScoreTupleView(playerScore: playerScorecard.sixes,
                               opponentScore: opponentScorecard.sixes,
                               isSelected: selectedScoreType == .sixes)
                .onTapGesture {
                    guard playerScorecard.sixes.isAvailableForScoring else { return }
                    selectedScoreType = .sixes
                }

                TotalRowView(
                    playerTotal: playerScorecard.upperTotal,
                    opponentTotal: opponentScorecard.upperTotal
                )
            }

            Spacer()

            VStack {
                ScoreTupleView(playerScore: playerScorecard.threeOfAKind,
                               opponentScore: opponentScorecard.threeOfAKind,
                               isSelected: selectedScoreType == .threeOfAKind)
                .onTapGesture {
                    guard playerScorecard.threeOfAKind.isAvailableForScoring else { return }
                    selectedScoreType = .threeOfAKind
                }

                ScoreTupleView(playerScore: playerScorecard.fourOfAKind,
                               opponentScore: opponentScorecard.fourOfAKind,
                               isSelected: selectedScoreType == .fourOfAKind)
                .onTapGesture {
                    guard playerScorecard.fourOfAKind.isAvailableForScoring else { return }
                    selectedScoreType = .fourOfAKind
                }

                ScoreTupleView(playerScore: playerScorecard.fullHouse,
                               opponentScore: opponentScorecard.fullHouse,
                               isSelected: selectedScoreType == .fullHouse)
                .onTapGesture {
                    guard playerScorecard.fullHouse.isAvailableForScoring else { return }
                    selectedScoreType = .fullHouse
                }

                ScoreTupleView(playerScore: playerScorecard.smallStraight,
                               opponentScore: opponentScorecard.smallStraight,
                               isSelected: selectedScoreType == .smallStraight)
                .onTapGesture {
                    guard playerScorecard.smallStraight.isAvailableForScoring else { return }
                    selectedScoreType = .smallStraight
                }

                ScoreTupleView(playerScore: playerScorecard.largeStraight,
                               opponentScore: opponentScorecard.largeStraight,
                               isSelected: selectedScoreType == .largeStraight)
                .onTapGesture {
                    guard playerScorecard.largeStraight.isAvailableForScoring else { return }
                    selectedScoreType = .largeStraight
                }

                ScoreTupleView(playerScore: playerScorecard.yahtzee,
                               opponentScore: opponentScorecard.yahtzee,
                               isSelected: selectedScoreType == .yahtzee)
                .onTapGesture {
                    guard playerScorecard.yahtzee.isAvailableForScoring else { return }
                    selectedScoreType = .yahtzee
                }

                ScoreTupleView(playerScore: playerScorecard.chance,
                               opponentScore: opponentScorecard.chance,
                               isSelected: selectedScoreType == .chance)
                .onTapGesture {
                    guard playerScorecard.chance.isAvailableForScoring else { return }
                    selectedScoreType = .chance
                }

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
