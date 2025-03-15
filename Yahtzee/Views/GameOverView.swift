//
//  GameOverView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/8/25.
//

import SwiftUI

struct GameOverView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var activeSheet: GameSheet?

    var didWin: Bool

    var emojiMessage: String {
        let losingEmojis = ["😢", "😞", "🤖"]
        let winningEmojis = ["🏆", "🎉", "😎"]

        if didWin {
            return winningEmojis.randomElement()!
        } else {
            return losingEmojis.randomElement()!
        }
    }

    var outcomeMessage: String {
        if didWin {
            return "You Won!"
        } else {
            return "You Lost."
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
                    activeSheet = .newGame
                }) {
                    Text("New Game")
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .background(Color(.systemBackground))
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
    GameOverView(
        activeSheet: .constant(nil),
        didWin: true
    )
}

#Preview("Lost") {
    GameOverView(
        activeSheet: .constant(nil),
        didWin: false
    )
}
