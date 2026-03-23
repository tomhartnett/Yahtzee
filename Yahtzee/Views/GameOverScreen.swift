//
//  GameOverView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/8/25.
//

import SwiftUI

extension GameOverScreen {
    enum GameOutcome {
        case lost
        case won
        case tied

        init(playerScore: Int, opponentScore: Int) {
            if playerScore > opponentScore {
                self = .won
            } else if playerScore == opponentScore {
                self = .tied
            } else {
                self = .lost
            }
        }
    }
}

struct GameOverScreen: View {
    @Environment(\.dismiss) var dismiss

    @State private var emojiMessage = ""

    @State private var outcomeMessage = ""

    let outcome: GameOutcome

    let newGameAction: (() -> Void)

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text(emojiMessage)
                    .font(.system(size: 64))

                Text(outcomeMessage)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Button(action: {
                    dismiss()
                    newGameAction()
                }) {
                    Text("New Game")
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 24)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .tint(.primary)
                    }
                }
            }
            .task {
                switch outcome {
                case .lost:
                    emojiMessage = ["😢", "😞", "🤖"].randomElement()!
                    outcomeMessage = "You Lost."
                case .won:
                    emojiMessage = ["🏆", "🎉", "😎"].randomElement()!
                    outcomeMessage = "You Won!"
                case .tied:
                    emojiMessage = ["😬", "🤷🏻‍♂️", "👔"].randomElement()!
                    outcomeMessage = "Tie"
                }
            }
        }
    }
}

#Preview("Won") {
    VStack {
        Text("Hello World")
    }
    .sheet(isPresented: .constant(true)) {
        GameOverScreen(
            outcome: .init(playerScore: 300, opponentScore: 250),
            newGameAction: {}
        )
        .presentationDetents([.medium])
    }
}

#Preview("Lost") {
    GameOverScreen(
        outcome: .init(playerScore: 250, opponentScore: 300),
        newGameAction: {}
    )
}

#Preview("Tied") {
    GameOverScreen(
        outcome: .init(playerScore: 250, opponentScore: 250),
        newGameAction: {}
    )
}
