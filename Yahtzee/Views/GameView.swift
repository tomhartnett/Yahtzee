//
//  GameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct GameView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    @State var game = Game(.great)

    @State private var isShowingMenu = false

    @State private var diceControlInput: ControlInput?

    var body: some View {
        GeometryReader { proxy in
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

                    Spacer()

                    DiceRollingView(controlInput: $diceControlInput)

                    Spacer()

                    HStack {
                        Button(action: {
                            diceControlInput = .roll
                        }) {
                            Text("Roll")
                        }
                        .buttonStyle(BorderedProminentButtonStyle())

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
                        isShowingMenu.toggle()
                    }) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingMenu) {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    NewGameView(
                        game: $game, initialSkillLevel: game.opponent.skillLevel
                    )
                    .presentationDetents([.fraction(0.7)])
                } else {
                    NewGameView(
                        game: $game, initialSkillLevel: game.opponent.skillLevel
                    )
                }
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
    fileprivate var profileImage: Image {
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
