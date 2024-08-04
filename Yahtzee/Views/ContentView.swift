//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct ContentView: View {
    @State var game = Game()

    var body: some View {
        VStack(spacing: 24) {
            GameScoreView(
                playerScore: game.playerScorecard.totalScore,
                opponentScore: game.opponentScorecard.totalScore,
                remainingTurns: game.playerScorecard.remainingTurns
            )

            ScorecardView(
                playerScorecard: $game.playerScorecard,
                opponentScorecard: $game.opponentScorecard,
                selectedScoreType: $game.selectedScoreType
            )

            DiceCupView(diceCup: $game.diceCup)

            HStack {
                RollButtonView(diceCup: $game.diceCup, scorecard: $game.playerScorecard)
                PlayButtonView(game: $game)
            }

            NewGameButton(game: $game)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
