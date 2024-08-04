//
//  DieView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import SwiftUI
import YahtzeeKit

struct DieView: View {
    var die: Die

    var borderColor: Color {
        die.isHeld ? Color.yellow : Color.secondary
    }

    var borderWidth: CGFloat {
        die.isHeld ? 4 : 2
    }

    var displayValue: String {
        if let value = die.value {
            return value.displayLabel
        } else {
            return ""
        }
    }

    var body: some View {
        ZStack {
            Text(displayValue)
                .font(.largeTitle)
        }
        .frame(width: 50, height: 50)
        .border(borderColor, width: borderWidth)
    }
}

#Preview {
    HStack {
        DieView(die: Die())
        DieView(die: Die(value: .one))
        DieView(die: Die(value: .two, isHeld: true))
        DieView(die: Die())
        DieView(die: Die(value: .three))
    }
}
