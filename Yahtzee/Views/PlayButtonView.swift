//
//  PlayButtonView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/4/24.
//

import SwiftUI

struct PlayButtonView: View {
    @Binding var game: Game

    var body: some View {
        Button(action: {
            game.playerScore()
        }) {
            Text("Play")
                .font(.title)
                .frame(maxWidth: .infinity, minHeight: 40)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(game.diceCup.values == nil)
    }
}

#Preview {
    PlayButtonView(game: .constant(Game()))
}