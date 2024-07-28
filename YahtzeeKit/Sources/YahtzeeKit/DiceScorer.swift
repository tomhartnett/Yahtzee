//
//  File.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 7/28/24.
//

import Foundation

struct DiceScorer {
    private var dictionary: [DieValue: Int] = [:]

    private var values: [DieValue] = []

    public init() {}

    public mutating func score(_ dice: DiceValues?) {
        guard let dice else {
            values = []
            dictionary.removeAll()
            return
        }

        values = [
            dice.value1,
            dice.value2,
            dice.value3,
            dice.value4,
            dice.value5
        ]

        dictionary[.one] = values.filter({ $0 == .one }).count
        dictionary[.two] = values.filter({ $0 == .two }).count
        dictionary[.three] = values.filter({ $0 == .three }).count
        dictionary[.four] = values.filter({ $0 == .four }).count
        dictionary[.five] = values.filter({ $0 == .five }).count
        dictionary[.six] = values.filter({ $0 == .six }).count
    }

    public var diceTotal: Int {
        values.reduce(0, { $0 + $1.rawValue })
    }

    public var hasThreeOfAKind: Bool {
        dictionary.filter({ $0.value >= 3 }).first != nil
    }

    public var hasFourOfAKind: Bool {
        dictionary.filter({ $0.value >= 4 }).first != nil
    }

    public var hasFullHouse: Bool {
        dictionary.filter({ $0.value == 2 }).first != nil && hasThreeOfAKind
    }

    public var hasSmallStraight: Bool {
        dictionary.filter({ $0.value == 1 }).count >= 3
    }

    public var hasLargeStraight: Bool {
        dictionary.filter({ $0.value == 1 }).count == 5
    }

    public var hasYahtzee: Bool {
        dictionary.filter({ $0.value == 5 }).first != nil
    }

    public func total(for dieValue: DieValue) -> Int {
        values.filter({ $0 == dieValue })
            .reduce(0, { $0 + $1.rawValue })
    }
}
