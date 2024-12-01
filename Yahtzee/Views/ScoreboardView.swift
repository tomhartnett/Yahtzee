//
//  ScoreboardView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 11/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreboardView: View {
    @Environment(\.dismiss) var dismiss

    var game: Game

    var body: some View {
        NavigationStack {
            Grid(alignment: .center) {
                GridRow {
                    Text("")
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)

                    game.opponent.profileImage
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                }

                Divider()

                RowView(
                    label: "Upper Total",
                    playerScore: game.playerScorecard.upperTotal,
                    opponentScore: game.opponentScorecard.upperTotal
                )

                Divider()

                RowView (
                    label: "Upper Bonus",
                    playerScore: game.playerScorecard.upperBonus,
                    opponentScore: game.opponentScorecard.upperBonus
                )

                Divider()

                RowView (
                    label: "Lower Total",
                    playerScore: game.playerScorecard.lowerTotal,
                    opponentScore: game.opponentScorecard.lowerTotal
                )

                Divider()

                RowView (
                    label: "Yahtzee Bonus",
                    playerScore: game.playerScorecard.yahtzeeBonus,
                    opponentScore: game.opponentScorecard.yahtzeeBonus
                )

                Divider()

                RowView (
                    label: "Grand Total",
                    playerScore: game.playerScorecard.totalScore,
                    opponentScore: game.opponentScorecard.totalScore
                )
            }
            .padding()
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

extension ScoreboardView {
    struct RowView: View {
        var label: String
        var playerScore: Int
        var opponentScore: Int

        var body: some View {
            GridRow {
                Text(label)
                    .gridColumnAlignment(.leading)
                Text(playerScore.formatted())
                Text(opponentScore.formatted())
            }
        }
    }
}

#Preview {
    VStack {
        Text("Hello World")
    }
    .sheet(isPresented: .constant(true)) {
        ScoreboardView(game: Game(.ok))
    }
}
