//
//  Dice.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

enum DieSlot {
    case one
    case two
    case three
    case four
    case five
}

enum DieValue: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6

    static func random() -> DieValue {
        let random = Int.random(in: 1...6)
        return DieValue(rawValue: random) ?? .one
    }
}

struct Die {
    var value: DieValue?
    var isHeld: Bool = false

    mutating func roll() {
        guard !isHeld else { return }

        value = DieValue.random()
    }

    mutating func hold() {
        isHeld.toggle()
    }
}

struct DiceValues {
    let value1: DieValue
    let value2: DieValue
    let value3: DieValue
    let value4: DieValue
    let value5: DieValue

    init(
        _ value1: DieValue,
        _ value2: DieValue,
        _ value3: DieValue,
        _ value4: DieValue,
        _ value5: DieValue
    ) {
        self.value1 = value1
        self.value2 = value2
        self.value3 = value3
        self.value4 = value4
        self.value5 = value5
    }
}

struct DiceCup {
    var die1 = Die()

    var die2 = Die()

    var die3 = Die()

    var die4 = Die()

    var die5 = Die()

    var remainingRolls: Int = 3

    private var dictionary = [DieValue: Int]()

    mutating func roll(_ useValues: DiceValues? = nil) {
        guard remainingRolls > 0 else { return }

        dictionary.removeAll()

        if let values = useValues {
            die1.value = values.value1
            die2.value = values.value2
            die3.value = values.value3
            die4.value = values.value4
            die5.value = values.value5
        } else {
            die1.roll()
            die2.roll()
            die3.roll()
            die4.roll()
            die5.roll()
        }

        let dice = currentValues

        dictionary[.one] = dice.filter({ $0 == .one }).count
        dictionary[.two] = dice.filter({ $0 == .two }).count
        dictionary[.three] = dice.filter({ $0 == .three }).count
        dictionary[.four] = dice.filter({ $0 == .four }).count
        dictionary[.five] = dice.filter({ $0 == .five }).count
        dictionary[.six] = dice.filter({ $0 == .six }).count

        remainingRolls -= 1
    }

    mutating func hold(_ slot: DieSlot) {
        switch slot {
        case .one:
            die1.hold()
        case .two:
            die2.hold()
        case .three:
            die3.hold()
        case .four:
            die4.hold()
        case .five:
            die5.hold()
        }
    }
}

extension DiceCup {
    var currentValues: [DieValue] {
        [
            die1.value,
            die2.value,
            die3.value,
            die4.value,
            die5.value
        ].compactMap { $0 }
    }

    var diceTotal: Int {
        currentValues.reduce(0, { $0 + $1.rawValue })
    }

    var hasThreeOfAKind: Bool {
        dictionary.filter({ $0.value >= 3 }).first != nil
    }

    var hasFourOfAKind: Bool {
        dictionary.filter({ $0.value >= 4 }).first != nil
    }

    var hasFullHouse: Bool {
        dictionary.filter({ $0.value == 2 }).first != nil && hasThreeOfAKind
    }

    var hasSmallStraight: Bool {
        dictionary.filter({ $0.value == 1 }).count >= 3
    }

    var hasLargeStraight: Bool {
        dictionary.filter({ $0.value == 1 }).count == 5
    }

    var hasYahtzee: Bool {
        dictionary.filter({ $0.value == 5 }).first != nil
    }

    func total(for dieValue: DieValue) -> Int {
        currentValues.filter({ $0 == dieValue }).reduce(0, { $0 + $1.rawValue })
    }
}
