//
//  GameOverView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/8/25.
//

import SwiftUI

extension GameOverView {
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
struct GameOverView: View {
    @Environment(\.dismiss) var dismiss

    var outcome: GameOutcome

    var newGameAction: (() -> Void)

    var emojiMessage: String {
        switch outcome {
        case .lost:
            return ["😢", "😞", "🤖"].randomElement()!
        case .won:
            return ["🏆", "🎉", "😎"].randomElement()!
        case .tied:
            return ["😬", "🤷🏻‍♂️", "👔"].randomElement()!
        }
    }

    var outcomeMessage: String {
        switch outcome {
        case .lost:
            return "You Lost."
        case .won:
            return "You Won!"
        case .tied:
            return "Tie"
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(emojiMessage)
                    .font(.system(size: 64))

                Text(outcomeMessage)
                    .font(.largeTitle)

                Button(action: {
                    dismiss()
                    newGameAction()
                }) {
                    Text("New Game")
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .tint(.primary)
                    }
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
        GameOverView(
            outcome: .init(playerScore: 300, opponentScore: 250),
            newGameAction: {}
        )
        .presentationDetents([.medium])
    }
}

#Preview("Lost") {
    GameOverView(
        outcome: .init(playerScore: 250, opponentScore: 300),
        newGameAction: {}
    )
}

#Preview("Tied") {
    GameOverView(
        outcome: .init(playerScore: 250, opponentScore: 250),
        newGameAction: {}
    )
}
