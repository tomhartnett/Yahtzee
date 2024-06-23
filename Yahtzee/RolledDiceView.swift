//
//  RolledDiceView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/23/24.
//

import SwiftUI
import YahtzeeKit

struct RolledDiceView: View {
    var die1: Die
    var die2: Die
    var die3: Die
    var die4: Die
    var die5: Die

    var body: some View {
        HStack {
            DieSlotView(die: die1)
            DieSlotView(die: die2)
            DieSlotView(die: die3)
            DieSlotView(die: die4)
            DieSlotView(die: die5)
        }
    }
}

struct DieSlotView: View {
    var die: Die

    var displayText: String {
        if let value = die.value?.rawValue {
            return "\(value)"
        } else {
            return ""
        }
    }

    var body: some View {
        Rectangle()
            .frame(width: 50, height: 50)
            .border(die.isHeld ? .red : .black)
            .shadow(color: .yellow, radius: 10)
    }
}

#Preview {
    RolledDiceView(
        die1: Die(value: .one),
        die2: Die(value: .two),
        die3: Die(value: .three),
        die4: Die(value: .four),
        die5: Die(value: .five)
    )
}
