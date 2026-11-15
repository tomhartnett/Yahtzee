//
//  GameContainerScreen.swift
//  Rollzee
//
//  Created by Tom Hartnett on 6/16/26.
//

import SwiftUI
import YahtzeeKit

struct GameContainerScreen: View {
    @Environment(\.scenePhase) private var scenePhase

    @State private var game: Game? = Game.loadSavedGame()
    @State private var isGamePresented = false

    var body: some View {
        NavigationStack {
            StartScreen(
                game: game,
                onNewGame: {
                    startNewGame()
                    isGamePresented = true
                },
                onContinueGame: {
                    isGamePresented = game != nil
                },
                onEndGame: {
                    endGame()
                }
            )
            .navigationDestination(isPresented: $isGamePresented) {
                if let game {
                    GameScreen(game: game)
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard newPhase == .inactive || newPhase == .background else {
                return
            }

            game?.save()
        }
    }

    private func startNewGame() {
        Game.deleteSavedGame()
        game = Game(botOpponent: BotKind.default.makeBot())
    }

    private func endGame() {
        Game.deleteSavedGame()
        game = nil
        isGamePresented = false
    }
}
