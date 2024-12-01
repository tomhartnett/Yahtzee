//
//  GameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

enum GameSheet: Identifiable {
    case newGame
    case scoreboard

    var id: Self {
        return self
    }
}

struct GameView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    @State private var game = Game(.ok)

    @State private var activeSheet: GameSheet?

    var body: some View {
        HStack {
            Spacer()

            VStack {
                Spacer()

                HStack {
                    PlayerScoreView(
                        image: Image(systemName: "person.crop.circle"),
                        score: game.playerScorecard.totalScore,
                        isRightAligned: false
                    )
                    .frame(maxWidth: .infinity)

                    Button(action: {
                        activeSheet = .scoreboard
                    }) {
                        Image(systemName: "info.circle")
                            .tint(.primary)
                    }

                    PlayerScoreView(
                        image: game.opponent.profileImage,
                        score: game.opponentScorecard.totalScore,
                        isRightAligned: true
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                ScorecardView(
                    playerScorecard: $game.playerScorecard,
                    opponentScorecard: $game.opponentScorecard,
                    selectedScoreType: $game.selectedScoreType
                )
                .padding(.horizontal)

                DiceRollingView(game: $game)
                    .aspectRatio(3, contentMode: .fit)

                HStack {
                    RollButtonView(
                        diceCup: $game.diceCup,
                        scorecard: $game.playerScorecard,
                        diceAction: $game.diceAction
                    )
                    PlayButtonView(game: $game)
                }
                .padding(.bottom)
            }
            .frame(maxWidth: 400)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    activeSheet = .newGame
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .newGame:
                NewGameView(
                    game: $game,
                    initialSkillLevel: game.opponent.skillLevel
                )
            case .scoreboard:
                ScoreboardView(game: game)
                    .presentationDetents([.medium])
            }
        }
    }

    func gameboardSize(for containerSize: CGSize) -> CGSize {
        if horizontalSizeClass == .regular {
            return CGSize(width: containerSize.width * 0.4, height: containerSize.height)
        } else {
            return containerSize
        }
    }
}

#Preview {
    GameView()
}

extension Bot {
    var profileImage: Image {
        switch skillLevel {
        case .bad:
            Image("Unskilled Dummy Bot")
        case .ok:
            Image("Meh Bot")
        case .great:
            Image("Hard Bot")
        }
    }
}
