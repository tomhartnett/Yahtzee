//
//  ViewModel.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/20/24.
//

import SwiftUI
import YahtzeeKit

@Observable
class ViewModel {
    var die1: Die {
        diceCup.die1
    }

    var die2: Die {
        diceCup.die2
    }

    var die3: Die {
        diceCup.die3
    }

    var die4: Die {
        diceCup.die4
    }

    var die5: Die {
        diceCup.die5
    }

    var remainingRolls: Int {
        diceCup.remainingRolls
    }

    private var diceCup = DiceCup()

    func hold(_ die: DieSlot) {
        diceCup.hold(die)
    }

    func roll() {
        diceCup.roll()
    }
}
