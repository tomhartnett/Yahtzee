//
//  StartScreen.swift
//  Rollzee
//
//  Created by Tom Hartnett on 1/25/26.
//

import SwiftUI
import YahtzeeKit

enum Navigation: Identifiable {
    case game

    var id: Self {
        self
    }
}

struct StartScreen: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.scenePhase) private var scenePhase

    @State private var navigation: Navigation?
    @State private var game: Game? = Game.loadSavedGame()

    private var usesSplitView: Bool {
        horizontalSizeClass == .regular
    }

    var showNewGame: Bool {
        if let currentGame = game, !currentGame.isGameOver {
            return false
        } else {
            return true
        }
    }

    var showCompletedGame: Bool {
        if let currentGame = game, currentGame.isGameOver {
            return true
        } else {
            return false
        }
    }

    var body: some View {
        Group {
            if usesSplitView {
                splitViewLayout
            } else {
                stackLayout
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard newPhase == .inactive || newPhase == .background else {
                return
            }

            game?.save()
        }
    }

    private var stackLayout: some View {
        NavigationStack {
            startScreenContent
            .navigationDestination(item: $navigation) { _ in
                if let gameBinding {
                    GameScreen(game: gameBinding)
                }
            }
        }
    }

    private var splitViewLayout: some View {
        NavigationSplitView {
            startScreenContent
                .navigationTitle("Yahtzee")
                .navigationBarTitleDisplayMode(.inline)
        } detail: {
            detailContent
        }
        .navigationSplitViewStyle(.balanced)
    }

    private var startScreenContent: some View {
        VStack(spacing: 24) {
            Button(action: {
                if showNewGame {
                    game = Game(botOpponent: BotKind.default.makeBot())
                    navigateToGame()
                } else {
                    Game.deleteSavedGame()
                    game = nil
                    navigation = nil
                }
            }, label: {
                Text(showNewGame ? "New Game" : "Quit Game")
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            })
            .buttonStyle(.borderedProminent)

            if !usesSplitView {
                Button(action: {
                    navigateToGame()
                }, label: {
                    Text(showCompletedGame ? "View Completed Game" : "Continue Game")
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                })
                .buttonStyle(.borderedProminent)
                .disabled(game == nil)
            }
        }
        .frame(maxWidth: 360)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 24)
    }

    @ViewBuilder
    private var detailContent: some View {
        if let gameBinding {
            GameScreen(game: gameBinding)
        } else {
            ContentUnavailableView(
                "Start a Game",
                systemImage: "dice.fill",
                description: Text("Choose New Game to begin.")
            )
        }
    }

    private var gameBinding: Binding<Game>? {
        guard game != nil else {
            return nil
        }

        return Binding(
            get: {
                game ?? Game(botOpponent: BotKind.default.makeBot())
            },
            set: { updatedGame in
                game = updatedGame
            }
        )
    }

    private func navigateToGame() {
        guard game != nil else {
            return
        }

        if !usesSplitView {
            navigation = .game
        }
    }
}

#Preview {
    StartScreen()
}
