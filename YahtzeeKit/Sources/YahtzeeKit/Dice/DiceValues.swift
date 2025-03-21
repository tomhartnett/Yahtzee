//
//  DiceValues.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

public struct DiceValues: Equatable {
    public let value1: DieValue
    public let value2: DieValue
    public let value3: DieValue
    public let value4: DieValue
    public let value5: DieValue

    public var isThreeOfAKind: Bool {
        // 1 1 1 3 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count <= 3
    }

    public var isFourOfAKind: Bool {
        // 1 1 1 1 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count <= 2
    }

    public var isFullHouse: Bool {
        // 1 1 1 4 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count == 2
    }

    public var isSmallStraight: Bool {
        // 1 2 3 4 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count >= 4
    }

    public var isLargeStraight: Bool {
        // 1 2 3 4 5
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count == 5
    }

    public var isYahtzee: Bool {
        // 1 1 1 1 1
        [value1, value2, value3, value4, value5].allSatisfy({ $0 == value1 })
    }

    public var total: Int {
        value1.rawValue + value2.rawValue + value3.rawValue + value4.rawValue + value5.rawValue
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

    init(
        _ value1: DieValue?,
        _ value2: DieValue?,
        _ value3: DieValue?,
        _ value4: DieValue?,
        _ value5: DieValue?
    ) {
        self.value1 = value1 ?? .one
        self.value2 = value2 ?? .one
        self.value3 = value3 ?? .one
        self.value4 = value4 ?? .one
        self.value5 = value5 ?? .one
    }
}

extension DiceValues {
    static func random() -> DiceValues {
        DiceValues(
            DieValue.random(),
            DieValue.random(),
            DieValue.random(),
            DieValue.random(),
            DieValue.random()
        )
    }

    func shuffled() -> DiceValues {
        let dice: [DieValue] = [
            value1,
            value2,
            value3,
            value4,
            value5
        ]

        let shuffled = dice.shuffled()

        return DiceValues(
            dice[0],
            dice[1],
            dice[2],
            dice[3],
            dice[4]
        )
    }
}
