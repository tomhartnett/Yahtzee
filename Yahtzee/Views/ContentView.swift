//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct ContentView: View {
    #warning("Add view model that has a scorecard & dicecup.")
    @State private var diceCup = DiceCup()
    @State private var scorecard = Scorecard()

    var remainingRolls: String {
        "\(diceCup.remainingRolls)"
    }

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Text("Score:")
                Text("\(scorecard.totalScore)")
            }
            .font(.headline)

            HStack(spacing: 32) {
                VStack {
                    ScoreTupleView(scoreTuple: scorecard.ones)
                    ScoreTupleView(scoreTuple: scorecard.twos)
                    ScoreTupleView(scoreTuple: scorecard.threes)
                    ScoreTupleView(scoreTuple: scorecard.fours)
                    ScoreTupleView(scoreTuple: scorecard.fives)
                    ScoreTupleView(scoreTuple: scorecard.sixes)
                    ScoreTupleView(scoreTuple: scorecard.bonus)
                }

                VStack {
                    ScoreTupleView(scoreTuple: scorecard.threeOfAKind)
                    ScoreTupleView(scoreTuple: scorecard.fourOfAKind)
                    ScoreTupleView(scoreTuple: scorecard.fullHouse)
                    ScoreTupleView(scoreTuple: scorecard.smallStraight)
                    ScoreTupleView(scoreTuple: scorecard.largeStraight)
                    ScoreTupleView(scoreTuple: scorecard.yahtzee)
                    ScoreTupleView(scoreTuple: scorecard.chance)
                }
            }

            HStack(spacing: 16) {
                DieView(die: $diceCup.die1)
                DieView(die: $diceCup.die2)
                DieView(die: $diceCup.die3)
                DieView(die: $diceCup.die4)
                DieView(die: $diceCup.die5)
            }

            HStack {
                Button(action: {
                    diceCup.roll()
                }) {
                    Text("Roll")
                        .font(.title)
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(diceCup.remainingRolls <= 0)

                VStack {
                    Text("Rolls")
                    Text(remainingRolls)
                }
            }

            Button(action: {

            }) {
                Text("Play")
                    .font(.title)
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
            .buttonStyle(BorderedProminentButtonStyle())

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
