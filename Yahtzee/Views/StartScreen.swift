//
//  StartScreen.swift
//  Rollzee
//
//  Created by Tom Hartnett on 1/25/26.
//

import SwiftUI
import YahtzeeKit

struct StartScreen: View {
    let game: Game
    let onNewGame: () -> Void
    let onContinueGame: () -> Void

    private var continueGameTitle: String {
        game.isGameOver ? "View Completed Game" : "Continue Game"
    }

    private var remainingTurnsText: String {
        let turns = game.playerScorecard.remainingTurns
        return turns == 1 ? "1 turn remaining" : "\(turns) turns remaining"
    }

    var body: some View {
        VStack(spacing: 28) {
            VStack(spacing: 12) {
                Image(systemName: "dice.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                    .foregroundStyle(.fill)
                    .accessibilityLabel("Rollzee")

                Text(remainingTurnsText)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 16) {
                scoreSummary(title: "You", score: game.playerScorecard.totalScore)
                scoreSummary(title: "Bot", score: game.opponentScorecard.totalScore)
            }

            VStack(spacing: 16) {
                Button(action: onNewGame) {
                    Text("New Game")
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                }
                .buttonStyle(.borderedProminent)

                Button(action: onContinueGame) {
                    Text(continueGameTitle)
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: 360)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 24)
    }

    private func scoreSummary(title: String, score: Int) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(score, format: .number)
                .font(.title2)
                .fontWeight(.bold)
                .monospacedDigit()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Game Container") {
    GameContainerScreen()
}

#Preview("Start Screen") {
    StartScreen(
        game: Game(botOpponent: BotKind.default.makeBot()),
        onNewGame: {},
        onContinueGame: {}
    )
}
