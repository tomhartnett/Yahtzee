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
    @State private var playerScorecard = Scorecard()
    @State private var opponentScorecard = Scorecard()

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Text("Score:")
                Text("\(playerScorecard.totalScore)")
                Text("–")
                Text("\(opponentScorecard.totalScore)")
            }
            .font(.headline)

            ScorecardView(
                playerScorecard: $playerScorecard,
                opponentScorecard: $opponentScorecard
            )

            HStack(spacing: 16) {
                DieView(die: $diceCup.die1)
                DieView(die: $diceCup.die2)
                DieView(die: $diceCup.die3)
                DieView(die: $diceCup.die4)
                DieView(die: $diceCup.die5)
            }

            Button(action: {

            }) {
                Text("Play")
                    .font(.title)
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
            .buttonStyle(BorderedProminentButtonStyle())

            Button(action: {
                diceCup.roll()
                playerScorecard.evaluate(diceCup.values)
            }) {
                HStack {
                    Text("Roll")
                        .font(.title)

                    if diceCup.remainingRolls > 0 {
                        Circle()
                            .frame(width: 20)
                            .foregroundStyle(.yellow)
                    }

                    if diceCup.remainingRolls > 1 {
                        Circle()
                            .frame(width: 20)
                            .foregroundStyle(.yellow)
                    }

                    if diceCup.remainingRolls > 2 {
                        Circle()
                            .frame(width: 20)
                            .foregroundStyle(.yellow)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 40)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .disabled(diceCup.remainingRolls <= 0)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
