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
    case scoreboard

    var id: Self {
        return self
    }
}

struct GameScreen: View {
    @Binding var game: Game

    @Environment(\.scenePhase) private var scenePhase

    @State private var activeSheet: GameSheet?

    var body: some View {
        HStack {
            Spacer()

            VStack {
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
                        image: Image(systemName: "poweroutlet.type.f"),
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

                ZStack {
                    HStack {
                        RollButtonView(
                            game: $game
                        )

                        PlayButtonView(game: $game)
                    }
                    .padding(.bottom)
                    .opacity(game.isOpponentTurn ? 0 : 1)

                    Text("Bot is rolling")
                        .italic()
                        .foregroundStyle(.secondary)
                        .opacity(game.isOpponentTurn ? 1 : 0)
                }
            }
            .frame(maxWidth: 400)

            Spacer()
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .gameOver:
                GameOverScreen(
                    outcome: .init(
                        playerScore: game.playerScorecard.totalScore,
                        opponentScore: game.opponentScorecard.totalScore
                    ),
                    newGameAction: {
                        game.reset()
                    }
                )
                .presentationDetents([.medium])

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
        .onChange(of: scenePhase) { _, newPhase in
            guard game.isGameOver else { return }

            switch newPhase {
            case .active:
                activeSheet = .gameOver
            case .inactive, .background:
                break
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    GameScreen(game: .constant(Game(botOpponent: LuckBot())))
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
