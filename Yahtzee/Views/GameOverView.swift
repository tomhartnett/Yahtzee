//
//  GameOverView.swift
//  Rollzee
//
//  Created by Tom Hartnett on 4/25/26.
//

import SwiftUI

enum GameOutcome {
    case lost
    case won
    case tied

    var emoji: String {
        switch self {
        case .lost:
            return ["😢", "😞", "🤖"].randomElement()!
        case .won:
            return ["🏆", "🎉", "😎"].randomElement()!
        case .tied:
            return ["😬", "🤷🏻‍♂️", "👔"].randomElement()!
        }
    }

    var message: String {
        switch self {
        case .lost:
            return "You Lost."
        case .won:
            return "You Won!"
        case .tied:
            return "Tie"
        }
    }

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

struct GameOverView: View {
    @Environment(\.layoutMetrics) private var layoutMetrics

    let outcome: GameOutcome

    var body: some View {
        VStack(spacing: layoutMetrics.gameOverSpacing) {
            Text(outcome.emoji)
                .font(.system(size: layoutMetrics.gameOverEmojiFontSize))

            Text(outcome.message)
                .font(.system(size: layoutMetrics.titleFontSize, weight: .bold))
                .fontWeight(.bold)
        }
    }
}

#Preview("Won") {
    GameOverView(outcome: .won)
}

#Preview("Lost") {
    GameOverView(outcome: .lost)
}

#Preview("Tied") {
    GameOverView(outcome: .tied)
}
