//
//  ScoreTupleView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreTupleView: View {
    var playerScore: ScoreTuple

    var opponentScore: ScoreTuple

    var isSelected: Bool

    var borderColor: Color {
        isSelected ? Color.yellow : Color.secondary
    }

    var borderWidth: CGFloat {
        isSelected ? 4 : 2
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
            playerScore.type.displayImage
                .font(.largeTitle)
                .frame(width: 40, height: 40)

            ScoreBoxView(scoreTuple: playerScore)
                .border(borderColor, width: borderWidth)
                .background(playerScore.hasValue ? Color.green.opacity(0.5) : Color.clear)

            ScoreBoxView(scoreTuple: opponentScore)
                .border(Color.secondary, width: 2)
                .background(opponentScore.hasValue ? Color.green.opacity(0.5) : Color.clear)
        }
    }
}

struct ScoreBoxView: View {
    var scoreTuple: ScoreTuple

    var score: String {
        if let value = scoreTuple.value {
            return "\(value)"
        } else if let possibleValue = scoreTuple.possibleValue {
            return "\(possibleValue)"
        } else {
            return ""
        }
    }

    var textColor: Color {
        if scoreTuple.hasPossibleValue {
            return .secondary
        } else {
            return .primary
        }
    }

    var body: some View {
        Text(score)
            .font(.title)
            .foregroundStyle(textColor)
            .frame(width: 40, height: 40)
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
        ScoreTupleView(
            playerScore: .init(type: .ones),
            opponentScore: .init(type: .ones),
            isSelected: false
        )

        // possible score state
        ScoreTupleView(
            playerScore: .init(type: .ones, possibleValue: 4),
            opponentScore: .init(type: .ones),
            isSelected: false
        )

        // score state
        ScoreTupleView(
            playerScore: .init(type: .ones, value: 4),
            opponentScore: .init(type: .ones),
            isSelected: false
        )
    }
    .padding()
}
