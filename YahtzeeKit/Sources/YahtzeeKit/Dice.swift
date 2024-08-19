//
//  Dice.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum DieSlot {
    case one
    case two
    case three
    case four
    case five
}

public enum DieValue: Int, CaseIterable {
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

public struct Die {
    public var value: DieValue?
    public var isHeld: Bool = false

    public init(value: DieValue? = nil, isHeld: Bool = false) {
        self.value = value
        self.isHeld = isHeld
    }

    mutating func roll() {
        guard !isHeld else { return }

        value = DieValue.random()
    }

    mutating func hold() {
        guard value != nil else { return }

        isHeld.toggle()
    }
}

public struct DiceValues: Equatable {
    let value1: DieValue
    let value2: DieValue
    let value3: DieValue
    let value4: DieValue
    let value5: DieValue

    public var isYahtzee: Bool {
        [value1, value2, value3, value4, value5].allSatisfy({ $0 == value1 })
    }

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

public struct DiceCup {
    public var values: DiceValues? {
        guard let value1 = die1.value,
              let value2 = die2.value,
              let value3 = die3.value,
              let value4 = die4.value,
              let value5 = die5.value else {
            return nil
        }

        return DiceValues(
            value1,
            value2,
            value3,
            value4,
            value5
        )
    }

    public var die1 = Die()

    public var die2 = Die()

    public var die3 = Die()

    public var die4 = Die()

    public var die5 = Die()

    public var remainingRolls: Int = 3

    public init() {}

    public mutating func roll(_ useValues: DiceValues? = nil) {
        guard remainingRolls > 0 else { return }

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

        remainingRolls -= 1
    }

    public mutating func hold(_ slot: DieSlot) {
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

    public mutating func reset() {
        remainingRolls = 3
        die1.value = nil
        die2.value = nil
        die3.value = nil
        die4.value = nil
        die5.value = nil

        die1.isHeld = false
        die2.isHeld = false
        die3.isHeld = false
        die4.isHeld = false
        die5.isHeld = false
    }
}
