//
//  ScoreRowView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreRowView: View {
    @Environment(\EnvironmentValues.layoutMetrics) private var layoutMetrics

    var playerScore: ScoreBox

    var opponentScore: ScoreBox

    @Binding var selectedScoreType: ScoreType?

    @State private var scale = 1.0

    var isSelected: Bool {
        selectedScoreType == playerScore.scoreType
    }

    var borderColor: Color {
        isSelected ? Color.yellow : Color.secondary
    }

    var borderWidth: CGFloat {
        isSelected ? layoutMetrics.selectedScoreBorderWidth : layoutMetrics.scoreBorderWidth
    }

    var playerScoreValue: String {
        if let score = playerScore.value {
            return "\(score)"
        } else {
            return " "
        }
    }

    var body: some View {
        HStack {
            playerScore.scoreType.displayImage
                .font(.system(size: layoutMetrics.largeSymbolFontSize))
                .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)

            ScoreBoxView(score: playerScore)
                .border(borderColor, width: borderWidth)
                .background(playerScore.hasValue ? Color.green.opacity(0.5) : Color.clear)
                .scaleEffect(scale)
                .animation(.spring(duration: 0.25, bounce: 0.75), value: scale)

            ScoreBoxView(score: opponentScore)
                .border(Color.secondary, width: 2)
                .background(opponentScore.hasValue ? Color.green.opacity(0.5) : Color.clear)
        }
        .onTapGesture {
            guard playerScore.isAvailableForScoring else { return }

            withAnimation(.bouncy) {
                scale *= 1.1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.bouncy) {
                    scale = 1.0
                }
            }

            selectedScoreType = playerScore.scoreType
        }
    }
}

struct ScoreBoxView: View {
    @Environment(\EnvironmentValues.layoutMetrics) private var layoutMetrics

    var score: ScoreBox

    var scoreValue: String {
        if let value = score.value {
            return "\(value)"
        } else if let possibleValue = score.possibleValue {
            return "\(possibleValue)"
        } else {
            return ""
        }
    }

    var textColor: Color {
        if score.hasPossibleValue {
            return .secondary
        } else {
            return .primary
        }
    }

    var body: some View {
        Text(scoreValue)
            .font(.system(size: layoutMetrics.titleFontSize))
            .minimumScaleFactor(0.1)
            .padding(4 * layoutMetrics.scale)
            .foregroundStyle(textColor)
            .frame(width: layoutMetrics.scoreBoxSize, height: layoutMetrics.scoreBoxSize)
    }
}

extension ScoreType {
    var displayImage: Image {
        switch self {
        case .ones:
            return Image(systemName: "die.face.1")
        case .twos:
            return Image(systemName: "die.face.2")
        case .threes:
            return Image(systemName: "die.face.3")
        case .fours:
            return Image(systemName: "die.face.4")
        case .fives:
            return Image(systemName: "die.face.5")
        case .sixes:
            return Image(systemName: "die.face.6")
        case .threeOfAKind:
            return Image(systemName: "3.circle")
        case .fourOfAKind:
            return Image(systemName: "4.circle")
        case .fullHouse:
            return Image(systemName: "house")
        case .smallStraight:
            return Image(systemName: "s.circle")
        case .largeStraight:
            return Image(systemName: "l.circle")
        case .yahtzee:
            return Image(systemName: "y.circle")
        case .chance:
            return Image(systemName: "questionmark.app")
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        // blank, pre-roll state
        ScoreRowView(
            playerScore: .init(scoreType: .ones),
            opponentScore: .init(scoreType: .ones),
            selectedScoreType: .constant(nil)
        )

        // possible score state
        ScoreRowView(
            playerScore: .init(scoreType: .ones, possibleValue: 40),
            opponentScore: .init(scoreType: .ones),
            selectedScoreType: .constant(nil)
        )

        // possible score state selected
        ScoreRowView(
            playerScore: .init(scoreType: .ones, possibleValue: 40),
            opponentScore: .init(scoreType: .ones),
            selectedScoreType: .constant(.ones)
        )

        // score state
        ScoreRowView(
            playerScore: .init(scoreType: .ones, value: 40),
            opponentScore: .init(scoreType: .ones),
            selectedScoreType: .constant(nil)
        )
    }
    .padding()
}
