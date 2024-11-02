//
//  File.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 7/28/24.
//

import Foundation

struct DiceScorer {
    private let dictionary: [DieValue: Int]

    private let values: [DieValue]

    private let scorecard: Scorecard

    public init(scorecard: Scorecard, dice: DiceValues?) {
        self.scorecard = scorecard

        self.values = [
            dice?.value1,
            dice?.value2,
            dice?.value3,
            dice?.value4,
            dice?.value5
        ].compactMap { $0 }

        self.dictionary = [
            .one: values.filter({ $0 == .one }).count,
            .two: values.filter({ $0 == .two }).count,
            .three: values.filter({ $0 == .three }).count,
            .four: values.filter({ $0 == .four }).count,
            .five: values.filter({ $0 == .five }).count,
            .six: values.filter({ $0 == .six }).count
        ]
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
        let keysString = dictionary.filter({ $0.value > 0 }).keys
            .sorted(by: { $0.rawValue < $1.rawValue })
            .map({ "\($0.rawValue)" })
            .joined()

        return keysString.contains("1234") || keysString.contains("2345") || keysString.contains("3456")
    }

    public var hasLargeStraight: Bool {
        let keysString = dictionary.filter({ $0.value > 0 }).keys
            .sorted(by: { $0.rawValue < $1.rawValue })
            .map({ "\($0.rawValue)" })
            .joined()

        return keysString.contains("12345") || keysString.contains("23456")
    }

    public var hasYahtzee: Bool {
        dictionary.filter({ $0.value == 5 }).first != nil
    }

    public var threeOfAKindScore: Int {
        if hasThreeOfAKind || isAdditionalYahtzee {
            return diceTotal
        } else {
            return 0
        }
    }

    public var fourOfAKindScore: Int {
        if hasFourOfAKind || isAdditionalYahtzee {
            return diceTotal
        } else {
            return 0
        }
    }

    public var fullHouseScore: Int {
        if hasFullHouse || isAdditionalYahtzee {
            return 25
        } else {
            return 0
        }
    }

    public var smallStraightScore: Int {
        if hasSmallStraight || isAdditionalYahtzee {
            return 30
        } else {
            return 0
        }
    }

    public var largeStraightScore: Int {
        if hasLargeStraight || isAdditionalYahtzee {
            return 40
        } else {
            return 0
        }
    }

    public var yahtzeeScore: Int {
        if hasYahtzee {
            return 50
        } else {
            return 0
        }
    }

    public func evaluate() -> [ScoreTuple] {
        var possibleScores = [ScoreTuple]()
        let allowedScoreTypes = allowedScoreTypes()
        for scoreType in allowedScoreTypes {
            if !scorecard[scoreType].hasValue {
                possibleScores.append(
                    ScoreTuple(
                        type: scoreType,
                        value: nil,
                        possibleValue: score(for: scoreType)
                    )
                )
            }
        }
        return possibleScores
    }

    public func score(for scoreType: ScoreType) -> Int {
        switch scoreType {
        case .ones:
            return total(for: .one)
        case .twos:
            return total(for: .two)
        case .threes:
            return total(for: .three)
        case .fours:
            return total(for: .four)
        case .fives:
            return total(for: .five)
        case .sixes:
            return total(for: .six)
        case .threeOfAKind:
            return threeOfAKindScore
        case .fourOfAKind:
            return fourOfAKindScore
        case .fullHouse:
            return fullHouseScore
        case .smallStraight:
            return smallStraightScore
        case .largeStraight:
            return largeStraightScore
        case .yahtzee:
            return yahtzeeScore
        case .chance:
            return diceTotal
        }
    }

    public func total(for dieValue: DieValue) -> Int {
        values.filter({ $0 == dieValue })
            .reduce(0, { $0 + $1.rawValue })
    }

    public func count(for dieValue: DieValue) -> Int {
        dictionary[dieValue] ?? 0
    }

    private var isAdditionalYahtzee: Bool {
        let dieValue = values.first ?? .one
        let isYahtzee = values.allSatisfy({ $0 == dieValue })
        return isYahtzee && scorecard.yahtzee.hasValue
    }

    private func allowedScoreTypes() -> [ScoreType] {
        guard isAdditionalYahtzee else {
            return ScoreType.allCases
        }

        let dieValue = values.first ?? .one
        var forcedScoreType: ScoreType? = nil

        if dieValue == .one && scorecard.ones.isEmpty {
            forcedScoreType = .ones
        } else if dieValue == .two && scorecard.twos.isEmpty {
            forcedScoreType = .twos
        } else if dieValue == .three && scorecard.threes.isEmpty {
            forcedScoreType = .threes
        } else if dieValue == .four && scorecard.fours.isEmpty {
            forcedScoreType = .fours
        } else if dieValue == .five && scorecard.fives.isEmpty {
            forcedScoreType = .fives
        } else if dieValue == .six && scorecard.sixes.isEmpty {
            forcedScoreType = .sixes
        }

        if let forcedScoreType {
            return [forcedScoreType]
        } else {
            return ScoreType.allCases
        }
    }
}
