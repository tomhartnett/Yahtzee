//
//  GameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

enum GameSheet: Identifiable {
    case gameOver
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

                VStack {
                    if let turn = game.opponentLastTurn {
                        OpponentTurnView(turn: turn)
                    } else {
                        DiceRollingView(game: $game)
                    }
                }
                .aspectRatio(3, contentMode: .fit)

                HStack {
                    RollButtonView(
                        game: $game
                    )
                    .disabled(game.isRollInProgress || game.isOpponentTurn)

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
            case .gameOver:
                GameOverView(
                    activeSheet: $activeSheet,
                    didWin: game.playerScorecard.totalScore > game.opponentScorecard.totalScore
                )
                .presentationDetents([.medium])

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
        .onChange(of: game.isGameOver) { oldState, newState in
            switch (oldState, newState) {
            case (false, true):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    activeSheet = .gameOver
                }
            default:
                break
            }
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

extension ScoreType {
    var displayName: String {
        switch self {
        case .ones:
            return "Ones"
        case .twos:
            return "Twos"
        case .threes:
            return "Threes"
        case .fours:
            return "Fours"
        case .fives:
            return "Fives"
        case .sixes:
            return "Sixes"
        case .threeOfAKind:
            return "3 of a Kind"
        case .fourOfAKind:
            return "4 of a Kind"
        case .fullHouse:
            return "Full House"
        case .smallStraight:
            return "Small Straight"
        case .largeStraight:
            return "Large Straight"
        case .yahtzee:
            return "Yahtzee"
        case .chance:
            return "Chance"
        }
    }
}

extension DieValue {
    var imageName: String {
        switch self {
        case .one:
            return "die-face-1"
        case .two:
            return "die-face-2"
        case .three:
            return "die-face-3"
        case .four:
            return "die-face-4"
        case .five:
            return "die-face-5"
        case .six:
            return "die-face-6"
        }
    }
}
