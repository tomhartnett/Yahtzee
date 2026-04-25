//
//  GameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

enum GameSheet: Identifiable {
    case scoreboard

    var id: Self {
        return self
    }
}

struct GameScreen: View {
    @Binding var game: Game

    @State private var activeSheet: GameSheet?

    var body: some View {
        GeometryReader { proxy in
            let metrics = LayoutMetrics.adaptive(for: proxy.size, safeAreaInsets: proxy.safeAreaInsets)

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
                                .font(.system(size: metrics.bodyFontSize))
                                .tint(.primary)
                        }

                        PlayerScoreView(
                            image: Image(systemName: "poweroutlet.type.f"),
                            score: game.opponentScorecard.totalScore,
                            isRightAligned: true
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, metrics.horizontalPadding)

                    ScorecardView(
                        playerScorecard: $game.playerScorecard,
                        opponentScorecard: $game.opponentScorecard,
                        selectedScoreType: $game.selectedScoreType
                    )
                    .padding(.horizontal, metrics.horizontalPadding)

                    Spacer(minLength: 0)

                    if game.isGameOver {
                        VStack {
                            GameOverView(outcome: gameOutcome)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(3, contentMode: .fit)

                    } else {
                        VStack {
                            if let turn = game.opponentLastTurn {
                                OpponentTurnView(turn: turn)
                            } else {
                                DiceRollingView(game: $game)
                            }
                        }
                        .aspectRatio(3, contentMode: .fit)
                    }

                    Spacer(minLength: 0)

                    bottomActionArea(metrics: metrics)
                        .padding(.bottom, metrics.bottomPadding + proxy.safeAreaInsets.bottom)
                }
                .environment(\.layoutMetrics, metrics)
                .frame(maxWidth: metrics.maxContentWidth, maxHeight: .infinity)

                Spacer()
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .scoreboard:
                ScoreboardView(game: game)
                    .presentationDetents([.medium])
            }
        }
    }
}

private extension GameScreen {
    var gameOutcome: GameOutcome {
        .init(
            playerScore: game.playerScorecard.totalScore,
            opponentScore: game.opponentScorecard.totalScore
        )
    }

    @ViewBuilder
    func bottomActionArea(metrics: LayoutMetrics) -> some View {
        if game.isGameOver {
            Button(action: {
                game.reset()
            }) {
                Text("New Game")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: metrics.titleFontSize, weight: .bold))
                    .padding(.vertical, 4 * metrics.scale)
            }
            .buttonStyle(.borderedProminent)
        } else {
            controlsFooter
        }
    }

    var controlsFooter: some View {
        ZStack {
            HStack {
                RollButtonView(
                    game: $game
                )

                PlayButtonView(game: $game)
            }
            .opacity(game.isOpponentTurn ? 0 : 1)

            Text("Bot is rolling")
                .italic()
                .foregroundStyle(.secondary)
                .opacity(game.isOpponentTurn ? 1 : 0)
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

#Preview("New Game") {
    GameScreen(game: .constant(Game(botOpponent: LuckBot())))
}

#Preview("Game Over") {
    @Previewable @State var game = Game(botOpponent: LuckBot())
    game.isGameOver = true
    return GameScreen(game: .constant(game))
}
