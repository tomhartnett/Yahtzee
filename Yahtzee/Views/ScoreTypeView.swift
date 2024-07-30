//
//  ScoreTypeView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreTypeView: View {
    var scoreType: ScoreType

//    var scorecard: Scorecard

    @State private var isSelected = false

    var borderColor: Color {
        isSelected ? Color.yellow : Color.clear
    }

    var borderWidth: CGFloat {
        isSelected ? 4 : 0
    }

    var scoreDisplayLabel: String {
        if let score = scoreType.score {
            return "\(score)"
        } else {
            return " "
        }
    }

    var body: some View {
        HStack {
            scoreType.displayImage
                .font(.largeTitle)
                .frame(width: 40, height: 40)
            Text(scoreDisplayLabel)
                .frame(width: 40, height: 40)
                .border(Color.primary)
        }
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
        case .upperBonus:
            return Image(systemName: "35.circle")
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
        ScoreTypeView(scoreType: .ones(score: nil))

        // possible score, rolled state
        ScoreTypeView(scoreType: .twos(score: 6))

        // selected state
        ScoreTypeView(scoreType: .threes(score: 9))

        // past score state
        ScoreTypeView(scoreType: .fours(score: nil))

        ScoreTypeView(scoreType: .fives(score: nil))
        ScoreTypeView(scoreType: .sixes(score: nil))

        ScoreTypeView(scoreType: .upperBonus(score: nil))
        ScoreTypeView(scoreType: .threeOfAKind(score: nil))
        ScoreTypeView(scoreType: .fourOfAKind(score: nil))
        ScoreTypeView(scoreType: .fullHouse(score: nil))
        ScoreTypeView(scoreType: .smallStraight(score: nil))
        ScoreTypeView(scoreType: .largeStraight(score: nil))
        ScoreTypeView(scoreType: .yahtzee(score: nil))
        ScoreTypeView(scoreType: .chance(score: nil))
    }
    .padding()
}
