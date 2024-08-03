//
//  ScoreTypeView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import SwiftUI
import YahtzeeKit

struct ScoreTupleView: View {
    var scoreTuple: ScoreTuple

    @State private var isSelected = false

    var borderColor: Color {
        isSelected ? Color.yellow : Color.clear
    }

    var borderWidth: CGFloat {
        isSelected ? 4 : 0
    }

    var scoreDisplayLabel: String {
        if let score = scoreTuple.value {
            return "\(score)"
        } else {
            return " "
        }
    }

    var body: some View {
        HStack {
            scoreTuple.type.displayImage
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
//        case .upperBonus:
//            return Image(systemName: "35.circle")
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
        ScoreTupleView(scoreTuple: .init(type: .ones))

        // possible score, rolled state
        ScoreTupleView(scoreTuple: .init(type: .twos))

        // selected state
        ScoreTupleView(scoreTuple: .init(type: .threes))

        // past score state
        ScoreTupleView(scoreTuple: .init(type: .fours, value: 16))
    }
    .padding()
}
