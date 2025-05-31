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
        // 1 2 3 4 4
        // 3 3 4 2 6
        // 2 3 3 4 6
        // 1 2 3 3 4
        let uniqueValues: Set<Int> = Set(values.map({ $0.rawValue }))
        let sortedValues: [Int] = uniqueValues.sorted()
        let valuesString = sortedValues.map({ "\($0)" }).joined()
        let possibleStraights = ["1234", "2345", "3456"]
        return possibleStraights.first(where: { valuesString.contains($0) }) != nil
    }

    public var isLargeStraight: Bool {
        // 1 2 3 4 5
        // 1 2 3 4 4
        // 3 3 4 2 6
        // 2 3 3 4 6
        let sortedValues: [Int] = values.map({ $0.rawValue }).sorted()

        for index in 1...4 {
            let value = sortedValues[index]
            let previousValue = sortedValues[index - 1]
            if value - previousValue != 1 {
                return false
            }
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
}
