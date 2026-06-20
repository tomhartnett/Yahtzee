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
    @State private var scrollViewportHeight: CGFloat = 0
    @State private var scrollContentHeight: CGFloat = 0
    @State private var scoreAreaHeight: CGFloat = 0
    @State private var isWinningConfettiVisible = false
    @State private var winningConfettiBurstID = UUID()

    var body: some View {
        GeometryReader { proxy in
            let metrics = LayoutMetrics.adaptive(for: proxy.size, safeAreaInsets: proxy.safeAreaInsets)

            HStack {
                Spacer()

                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            scoreArea(metrics: metrics)
                                .onGeometryChange(for: CGFloat.self) { geometry in
                                    geometry.size.height
                                } action: { newHeight in
                                    scoreAreaHeight = newHeight
                                }

                            ZStack {
                                middleContent
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(3, contentMode: .fit)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: middleContentMinHeight(metrics: metrics))
                        }
                        .frame(minHeight: scrollViewportHeight)
                        .onGeometryChange(for: CGFloat.self) { geometry in
                            geometry.size.height
                        } action: { newHeight in
                            scrollContentHeight = newHeight
                        }
                    }
                    .scrollDisabled(isScrollLocked)
                    .onGeometryChange(for: CGFloat.self) { geometry in
                        geometry.size.height
                    } action: { newHeight in
                        scrollViewportHeight = newHeight
                    }
                    .environment(\.layoutMetrics, metrics)
                    .frame(maxWidth: metrics.maxContentWidth, maxHeight: .infinity)

                    bottomActionArea(metrics: metrics)
                        .padding(.bottom, metrics.bottomPadding)

                    Spacer()
                }
                .frame(maxWidth: metrics.maxContentWidth, maxHeight: .infinity, alignment: .top)

                Spacer()
            }
        }
        .overlay {
            if isWinningConfettiVisible {
                ConfettiView()
                    .id(winningConfettiBurstID)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .allowsHitTesting(false)
                    .ignoresSafeArea()
            }
        }
        .onAppear(perform: updateWinningConfetti)
        .onChange(of: shouldShowWinningConfetti) { _, _ in
            updateWinningConfetti()
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
    var isScrollLocked: Bool {
        scrollViewportHeight > 0 && scrollContentHeight <= scrollViewportHeight + 1
    }

    var gameOutcome: GameOutcome {
        .init(
            playerScore: game.playerScorecard.totalScore,
            opponentScore: game.opponentScorecard.totalScore
        )
    }

    var shouldShowWinningConfetti: Bool {
        game.isGameOver && gameOutcome == .won
    }

    func updateWinningConfetti() {
        guard shouldShowWinningConfetti else {
            isWinningConfettiVisible = false
            return
        }

        winningConfettiBurstID = UUID()
        isWinningConfettiVisible = true

        let burstID = winningConfettiBurstID
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(7))
            guard winningConfettiBurstID == burstID else {
                return
            }

            isWinningConfettiVisible = false
        }
    }

    func middleContentMinHeight(metrics: LayoutMetrics) -> CGFloat {
        let preferredHeight = scrollViewportHeight - scoreAreaHeight
        let minimumHeight = metrics.maxContentWidth / 3
        return max(preferredHeight, minimumHeight)
    }

    func scoreArea(metrics: LayoutMetrics) -> some View {
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
        }
    }

    @ViewBuilder
    var middleContent: some View {
        if game.isGameOver {
            GameOverView(outcome: gameOutcome)
        } else if let turn = game.opponentLastTurn {
            OpponentTurnView(turn: turn)
        } else {
            DiceRollingView(game: $game)
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
        .ignoresSafeArea(.container, edges: .bottom)
    }

    @ViewBuilder
    func bottomActionArea(metrics: LayoutMetrics) -> some View {
        if game.isGameOver {
            Button(action: {
                game.reset()
            }) {
                Text("New Game")
                    .frame(maxWidth: .infinity, minHeight: metrics.footerButtonHeight)
                    .font(.system(size: metrics.titleFontSize, weight: .bold))
            }
            .buttonStyle(.borderedProminent)
        } else {
            controlsFooter
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
    GameScreen(game: .constant(Game(botOpponent: BotKind.default.makeBot())))
}

#Preview("Game Over") {
    @Previewable @State var game = Game(botOpponent: BotKind.default.makeBot())
    game.isGameOver = true
    return GameScreen(game: .constant(game))
}
