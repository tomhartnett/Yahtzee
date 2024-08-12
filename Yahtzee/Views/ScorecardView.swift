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
        HStack(spacing: 32) {
            VStack {
                ScoreTupleView(playerScore: playerScorecard.ones,
                               opponentScore: opponentScorecard.ones,
                               isSelected: selectedScoreType == .ones)
                .onTapGesture {
                    guard !playerScorecard.ones.hasValue else { return }
                    selectedScoreType = .ones
                }

                ScoreTupleView(playerScore: playerScorecard.twos,
                               opponentScore: opponentScorecard.twos,
                               isSelected: selectedScoreType == .twos)
                .onTapGesture {
                    guard !playerScorecard.twos.hasValue else { return }
                    selectedScoreType = .twos
                }

                ScoreTupleView(playerScore: playerScorecard.threes,
                               opponentScore: opponentScorecard.threes,
                               isSelected: selectedScoreType == .threes)
                .onTapGesture {
                    guard !playerScorecard.threes.hasValue else { return }
                    selectedScoreType = .threes
                }

                ScoreTupleView(playerScore: playerScorecard.fours,
                               opponentScore: opponentScorecard.fours,
                               isSelected: selectedScoreType == .fours)
                .onTapGesture {
                    guard !playerScorecard.fours.hasValue else { return }
                    selectedScoreType = .fours
                }

                ScoreTupleView(playerScore: playerScorecard.fives,
                               opponentScore: opponentScorecard.fives,
                               isSelected: selectedScoreType == .fives)
                .onTapGesture {
                    guard !playerScorecard.fives.hasValue else { return }
                    selectedScoreType = .fives
                }

                ScoreTupleView(playerScore: playerScorecard.sixes,
                               opponentScore: opponentScorecard.sixes,
                               isSelected: selectedScoreType == .sixes)
                .onTapGesture {
                    guard !playerScorecard.sixes.hasValue else { return }
                    selectedScoreType = .sixes
                }

                HStack {
                    Text("")
                        .frame(width: 40, height: 40)

                    Text("\(playerScorecard.upperTotal)")
                        .frame(width: 40, height: 40)

                    Text("\(opponentScorecard.upperTotal)")
                        .frame(width: 40, height: 40)
                }
                .font(.title)
                .foregroundStyle(.secondary)
                .minimumScaleFactor(0.1)

                HStack {
                    Text("+")
                        .frame(width: 40, height: 40)

                    Text("\(playerScorecard.upperBonus)")
                        .frame(width: 40, height: 40)

                    Text("\(opponentScorecard.upperBonus)")
                        .frame(width: 40, height: 40)
                }
                .font(.title)
                .minimumScaleFactor(0.1)
                .foregroundStyle(.secondary)
            }

            VStack {
                ScoreTupleView(playerScore: playerScorecard.threeOfAKind,
                               opponentScore: opponentScorecard.threeOfAKind,
                               isSelected: selectedScoreType == .threeOfAKind)
                .onTapGesture {
                    guard !playerScorecard.threeOfAKind.hasValue else { return }
                    selectedScoreType = .threeOfAKind
                }

                ScoreTupleView(playerScore: playerScorecard.fourOfAKind,
                               opponentScore: opponentScorecard.fourOfAKind,
                               isSelected: selectedScoreType == .fourOfAKind)
                .onTapGesture {
                    guard !playerScorecard.fourOfAKind.hasValue else { return }
                    selectedScoreType = .fourOfAKind
                }

                ScoreTupleView(playerScore: playerScorecard.fullHouse,
                               opponentScore: opponentScorecard.fullHouse,
                               isSelected: selectedScoreType == .fullHouse)
                .onTapGesture {
                    guard !playerScorecard.fullHouse.hasValue else { return }
                    selectedScoreType = .fullHouse
                }

                ScoreTupleView(playerScore: playerScorecard.smallStraight,
                               opponentScore: opponentScorecard.smallStraight,
                               isSelected: selectedScoreType == .smallStraight)
                .onTapGesture {
                    guard !playerScorecard.smallStraight.hasValue else { return }
                    selectedScoreType = .smallStraight
                }

                ScoreTupleView(playerScore: playerScorecard.largeStraight,
                               opponentScore: opponentScorecard.largeStraight,
                               isSelected: selectedScoreType == .largeStraight)
                .onTapGesture {
                    guard !playerScorecard.largeStraight.hasValue else { return }
                    selectedScoreType = .largeStraight
                }

                ScoreTupleView(playerScore: playerScorecard.yahtzee,
                               opponentScore: opponentScorecard.yahtzee,
                               isSelected: selectedScoreType == .yahtzee)
                .onTapGesture {
                    guard !playerScorecard.yahtzee.hasValue else { return }
                    selectedScoreType = .yahtzee
                }

                ScoreTupleView(playerScore: playerScorecard.chance,
                               opponentScore: opponentScorecard.chance,
                               isSelected: selectedScoreType == .chance)
                .onTapGesture {
                    guard !playerScorecard.chance.hasValue else { return }
                    selectedScoreType = .chance
                }

                HStack {
                    Text("")
                        .frame(width: 40, height: 40)

                    Text("\(playerScorecard.lowerTotal)")
                        .frame(width: 40, height: 40)

                    Text("\(opponentScorecard.lowerTotal)")
                        .frame(width: 40, height: 40)
                }
                .font(.title)
                .foregroundStyle(.secondary)
                .minimumScaleFactor(0.1)
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
