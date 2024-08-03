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

    var body: some View {
        HStack(spacing: 32) {
            VStack {
                ScoreTupleView(playerScore: playerScorecard.ones, opponentScore: opponentScorecard.ones)
                ScoreTupleView(playerScore: playerScorecard.twos, opponentScore: opponentScorecard.twos)
                ScoreTupleView(playerScore: playerScorecard.threes, opponentScore: opponentScorecard.threes)
                ScoreTupleView(playerScore: playerScorecard.fours, opponentScore: opponentScorecard.fours)
                ScoreTupleView(playerScore: playerScorecard.fives, opponentScore: opponentScorecard.fives)
                ScoreTupleView(playerScore: playerScorecard.sixes, opponentScore: opponentScorecard.sixes)

                HStack {
                    Text("Bonus: \(playerScorecard.upperBonus) / 35")
                }
                .frame(height: 40)
            }

            VStack {
                ScoreTupleView(playerScore: playerScorecard.threeOfAKind, opponentScore: opponentScorecard.threeOfAKind)
                ScoreTupleView(playerScore: playerScorecard.fourOfAKind, opponentScore: opponentScorecard.fourOfAKind)
                ScoreTupleView(playerScore: playerScorecard.fullHouse, opponentScore: opponentScorecard.fullHouse)
                ScoreTupleView(playerScore: playerScorecard.smallStraight, opponentScore: opponentScorecard.smallStraight)
                ScoreTupleView(playerScore: playerScorecard.largeStraight, opponentScore: opponentScorecard.largeStraight)
                ScoreTupleView(playerScore: playerScorecard.yahtzee, opponentScore: opponentScorecard.yahtzee)
                ScoreTupleView(playerScore: playerScorecard.chance, opponentScore: opponentScorecard.chance)
            }
        }
    }
}

#Preview {
    ScorecardView(
        playerScorecard: .constant(Scorecard()),
        opponentScorecard: .constant(Scorecard())
    )
}
