//
//  DiceValues.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

public struct DiceValues: Equatable, Codable {
    public let value1: DieValue
    public let value2: DieValue
    public let value3: DieValue
    public let value4: DieValue
    public let value5: DieValue

    public var isThreeOfAKind: Bool {
        // 1 1 1 3 4
        for value in values {
            if values.filter({ $0 == value }).count >= 3 {
                return true
            }
        }

        return false
    }

    public var isFourOfAKind: Bool {
        // 1 1 1 1 4
        for value in values {
            if values.filter({ $0 == value }).count >= 4 {
                return true
            }
        }

        return false
    }

    public var isFullHouse: Bool {
        // 1 1 1 4 4
        // 4 4 6 4 4
        var hasThree = false
        var hasPair = false
        for value in values {
            let count = values.filter({ $0 == value }).count
            if count == 3 {
                hasThree = true
            } else if count == 2 {
                hasPair = true
            }
        }

        return hasThree && hasPair
    }

    public var isSmallStraight: Bool {
        let uniqueValues: Set<Int> = Set(values.map({ $0.rawValue }))

        guard uniqueValues.count >= 4 else { return false }

        let sortedValues = uniqueValues.sorted()
        var successes = 0
        for (index, value) in sortedValues.enumerated() {
            if index == sortedValues.count - 1 { continue }

            guard let next = sortedValues[safe: index + 1] else { continue }

            if next - value != 1 {
                successes = 0
            } else {
                successes += 1
            }

            if successes == 3 { return true }
        }
        return false
    }

    public var isLargeStraight: Bool {
        let uniqueValues: Set<Int> = Set(values.map({ $0.rawValue }))

        guard uniqueValues.count == 5 else { return false }

        let sortedValues = uniqueValues.sorted()

        for (index, value) in sortedValues.enumerated() {
            if index == sortedValues.count - 1 { continue }

            guard let next = sortedValues[safe: index + 1] else { continue }

            if next - value != 1 { return false }
        }

        return true
    }

    public var isYahtzee: Bool {
        // 1 1 1 1 1
        [value1, value2, value3, value4, value5].allSatisfy({ $0 == value1 })
    }

    public var total: Int {
        value1.rawValue + value2.rawValue + value3.rawValue + value4.rawValue + value5.rawValue
    }

    public var values: [DieValue] {
        [value1, value2, value3, value4, value5]
    }

    public func total(for dieValue: DieValue) -> Int {
        values.filter({ $0 == dieValue }).reduce(0, { $0 + $1.rawValue })
    }

    public init(
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

    public init(
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
}
