//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct ContentView: View {
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
                    ScoreTypeView(scoreType: scorecard.ones)
                    ScoreTypeView(scoreType: scorecard.twos)
                    ScoreTypeView(scoreType: scorecard.threes)
                    ScoreTypeView(scoreType: scorecard.fours)
                    ScoreTypeView(scoreType: scorecard.fives)
                    ScoreTypeView(scoreType: scorecard.sixes)
                    ScoreTypeView(scoreType: scorecard.bonus)
                }

                VStack {
                    ScoreTypeView(scoreType: scorecard.threeOfAKind)
                    ScoreTypeView(scoreType: scorecard.fourOfAKind)
                    ScoreTypeView(scoreType: scorecard.fullHouse)
                    ScoreTypeView(scoreType: scorecard.smallStraight)
                    ScoreTypeView(scoreType: scorecard.largeStraight)
                    ScoreTypeView(scoreType: scorecard.yahtzee)
                    ScoreTypeView(scoreType: scorecard.chance)
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
