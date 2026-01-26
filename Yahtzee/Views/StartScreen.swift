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
    @State private var navigation: Navigation?

    @State private var game: Game?

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
        NavigationStack {
            VStack(spacing: 24) {
                Button(action: {
                    // Toggle between starting a new game and quitting the current one
                    if showNewGame {
                        game = Game(botOpponent: LuckBot())
                        navigation = .game
                    } else {
                        game = nil
                    }

                }, label: {
                    Text(showNewGame ? "New Game" : "Quit Game")
                        .frame(maxWidth: .infinity) // TODO: looks bad on iPad
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                })
                .buttonStyle(.borderedProminent)

                Button(action: {
                    navigation = .game
                }, label: {
                    Text(showCompletedGame ? "View Completed Game" : "Continue Game")
                        .frame(maxWidth: .infinity) // TODO: looks bad on iPad
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                })
                .buttonStyle(.borderedProminent)
                .disabled(game == nil)
            }
            .padding(.horizontal, 24)
            .navigationDestination(item: $navigation) { _ in
                let currentGame = game ?? Game(botOpponent: LuckBot())
                GameScreen(game: .constant(currentGame)) // TODO: hacky
            }
        }
    }
}

#Preview {
    StartScreen()
}
