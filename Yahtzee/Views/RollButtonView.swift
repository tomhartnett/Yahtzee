//
//  RollButtonView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI
import YahtzeeKit

struct RollButtonView: View {
    @Binding var diceCup: DiceCup

    @Binding var scorecard: Scorecard

    @Binding var diceAction: DiceAction?

    var body: some View {
        Button(action: {
            diceCup.roll()
            if let values = diceCup.values {
                diceAction = .rollDice(values)
            }
            scorecard.evaluate(diceCup.values)
        }) {
            HStack {
                Text("Roll")
                    .font(.title)

                Circle()
                    .frame(width: 20)
                    .foregroundStyle(diceCup.remainingRolls > 0 ? .yellow : .gray)



                Circle()
                    .frame(width: 20)
                    .foregroundStyle(diceCup.remainingRolls > 1 ? .yellow : .gray)



                Circle()
                    .frame(width: 20)
                    .foregroundStyle(diceCup.remainingRolls > 2 ? .yellow : .gray)

            }
            .frame(maxWidth: .infinity, minHeight: 40)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(diceCup.remainingRolls <= 0 || scorecard.isFull)
    }
}

#Preview {
    RollButtonView(
        diceCup: .constant(DiceCup()),
        scorecard: .constant(Scorecard()),
        diceAction: .constant(nil)
    )
}
