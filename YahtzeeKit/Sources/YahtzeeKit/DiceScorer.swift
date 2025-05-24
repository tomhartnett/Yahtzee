//
//  File.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 7/28/24.
//

import Foundation

struct DiceScorer {
    private let dice: DiceValues

    private let scorecard: Scorecard

    public init(scorecard: Scorecard, dice: DiceValues?) {
        self.scorecard = scorecard
        self.dice = dice!
    }

    public var diceTotal: Int {
        dice.total
    }

    public var hasThreeOfAKind: Bool {
        dice.isThreeOfAKind
    }

    public var hasFourOfAKind: Bool {
        dice.isFourOfAKind
    }

    public var hasFullHouse: Bool {
        dice.isFullHouse
    }

    public var hasSmallStraight: Bool {
        dice.isSmallStraight
    }

    public var hasLargeStraight: Bool {
        dice.isLargeStraight
    }

    public var hasYahtzee: Bool {
        dice.isYahtzee
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

    public func evaluate() -> [ScoreBox] {
        var possibleScores = [ScoreBox]()
        let allowedScoreTypes = allowedScoreTypes()
        for scoreType in allowedScoreTypes {
            if !scorecard[scoreType].hasValue {
                possibleScores.append(
                    ScoreBox(
                        scoreType: scoreType,
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
        dice.total(for: dieValue)
    }

    private var isAdditionalYahtzee: Bool {
        dice.isYahtzee && scorecard.yahtzee.hasValue
    }

    private func allowedScoreTypes() -> [ScoreType] {
        guard isAdditionalYahtzee else {
            return ScoreType.allCases
        }

        let dieValue = dice.value1
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
