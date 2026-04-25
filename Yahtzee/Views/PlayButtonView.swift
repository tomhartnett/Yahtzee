//
//  PlayButtonView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/4/24.
//

import SwiftUI

struct PlayButtonView: View {
    @Environment(\.layoutMetrics) private var layoutMetrics

    @Binding var game: Game

    var body: some View {
        Button(action: {
            game.playerScore()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                game.opponentRoll()
            }
        }) {
            Text("Play")
                .font(.system(size: layoutMetrics.titleFontSize))
                .frame(maxWidth: .infinity, minHeight: layoutMetrics.footerButtonHeight)
        }
        .buttonStyle(.borderedProminent)
        .disabled(game.diceCup.values == nil || game.selectedScoreType == nil)
    }
}

#Preview {
    PlayButtonView(game: .constant(.previewSample))
}
