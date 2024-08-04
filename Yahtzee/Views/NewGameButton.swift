//
//  NewGameButton.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/4/24.
//

import SwiftUI

struct NewGameButton: View {
    @Binding var game: Game

    var body: some View {
        Button(action: {
            game = Game()
        }) {
            Text("NEW GAME")
                .font(.title)
                .frame(maxWidth: .infinity, minHeight: 40)
        }
        .buttonStyle(BorderedProminentButtonStyle())
    }
}

#Preview {
    NewGameButton(game: .constant(Game()))
}
