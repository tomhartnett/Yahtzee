//
//  GameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct GameView: View {
    @State var game = Game()

    @State private var isShowingMenu = false

    var body: some View {
        VStack(spacing: 24) {
            GameScoreView(
                playerScore: game.playerScorecard.totalScore,
                opponentScore: game.opponentScorecard.totalScore
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
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    isShowingMenu.toggle()
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .confirmationDialog("Menu", isPresented: $isShowingMenu, titleVisibility: .hidden) {
            Button(action: {
                game = Game()
            }) {
                Text("New Game")
            }
        }
    }
}

#Preview {
    GameView()
}
