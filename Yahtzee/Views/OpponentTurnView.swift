//
//  OpponentTurnView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/20/25.
//

import SwiftUI
import YahtzeeKit

struct OpponentTurnView: View {
    @Environment(\.layoutMetrics) private var layoutMetrics

    var turn: Turn

    var body: some View {
        VStack {
            HStack(spacing: layoutMetrics.opponentTurnDieSpacing) {
                Image(turn.dice.value1.imageName)
                    .resizable()
                    .frame(
                        width: layoutMetrics.opponentTurnDieSize,
                        height: layoutMetrics.opponentTurnDieSize
                    )
                    .border(.black)
                Image(turn.dice.value2.imageName)
                    .resizable()
                    .frame(
                        width: layoutMetrics.opponentTurnDieSize,
                        height: layoutMetrics.opponentTurnDieSize
                    )
                    .border(.black)
                Image(turn.dice.value3.imageName)
                    .resizable()
                    .frame(
                        width: layoutMetrics.opponentTurnDieSize,
                        height: layoutMetrics.opponentTurnDieSize
                    )
                    .border(.black)
                Image(turn.dice.value4.imageName)
                    .resizable()
                    .frame(
                        width: layoutMetrics.opponentTurnDieSize,
                        height: layoutMetrics.opponentTurnDieSize
                    )
                    .border(.black)
                Image(turn.dice.value5.imageName)
                    .resizable()
                    .frame(
                        width: layoutMetrics.opponentTurnDieSize,
                        height: layoutMetrics.opponentTurnDieSize
                    )
                    .border(.black)
            }
            Text("Bot scores **\(turn.score.valueOrZero)** for **\(turn.score.scoreType.displayName)**")
                .font(.system(size: layoutMetrics.opponentTurnTextSize))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .minimumScaleFactor(0.1)
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

#Preview {
    OpponentTurnView(
        turn: Turn(dice: DiceValues(.one, .one, .four, .three, .one),
                   score: ScoreBox(scoreType: .ones, value: 3, possibleValue: nil))
    )
    .frame(height: 100)
}
