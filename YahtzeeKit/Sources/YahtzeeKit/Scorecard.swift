//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum ScoreType: CaseIterable {
    case ones
    case twos
    case threes
    case fours
    case fives
    case sixes
    case threeOfAKind
    case fourOfAKind
    case fullHouse
    case smallStraight
    case largeStraight
    case yahtzee
    case chance
}

public struct ScoreTuple {
    public let type: ScoreType
    public var value: Int?
    public var possibleValue: Int?

    public var hasValue: Bool {
        value != nil
    }

    public var hasPossibleValue: Bool {
        possibleValue != nil
    }

    public var valueOrZero: Int {
        return value ?? 0
    }

    public var possibleValueOrZero: Int {
        return possibleValue ?? 0
    }

    public init(type: ScoreType, value: Int? = nil, possibleValue: Int? = nil) {
        self.type = type
        self.value = value
        self.possibleValue = possibleValue
    }

    public mutating func setValue(_ value: Int) {
        self.value = value
    }

    public mutating func setPossibleValue(_ possibleValue: Int) {
        self.possibleValue = possibleValue
    }

    public mutating func clearPossibleValue() {
        possibleValue = nil
    }
}

public struct Scorecard {
    public var ones: ScoreTuple {
        scoreDictionary[ScoreType.ones] ?? ScoreTuple(type: .ones)
    }

    public var twos: ScoreTuple {
        scoreDictionary[ScoreType.twos] ?? ScoreTuple(type: .twos)
    }

    public var threes: ScoreTuple {
        scoreDictionary[ScoreType.threes] ?? ScoreTuple(type: .threes)
    }

    public var fours: ScoreTuple {
        scoreDictionary[ScoreType.fours] ?? ScoreTuple(type: .fours)
    }

    public var fives: ScoreTuple {
        scoreDictionary[ScoreType.fives] ?? ScoreTuple(type: .fives)
    }

    public var sixes: ScoreTuple {
        scoreDictionary[ScoreType.sixes] ?? ScoreTuple(type: .sixes)
    }

    public var threeOfAKind: ScoreTuple {
        scoreDictionary[ScoreType.threeOfAKind] ?? ScoreTuple(type: .threeOfAKind)
    }

    public var fourOfAKind: ScoreTuple {
        scoreDictionary[ScoreType.fourOfAKind] ?? ScoreTuple(type: .fourOfAKind)
    }

    public var fullHouse: ScoreTuple {
        scoreDictionary[ScoreType.fullHouse] ?? ScoreTuple(type: .fullHouse)
    }

    public var smallStraight: ScoreTuple {
        scoreDictionary[ScoreType.smallStraight] ?? ScoreTuple(type: .smallStraight)
    }

    public var largeStraight: ScoreTuple {
        scoreDictionary[ScoreType.largeStraight] ?? ScoreTuple(type: .largeStraight)
    }

    public var yahtzee: ScoreTuple {
        scoreDictionary[ScoreType.yahtzee] ?? ScoreTuple(type: .yahtzee)
    }

    public var chance: ScoreTuple {
        scoreDictionary[ScoreType.chance] ?? ScoreTuple(type: .chance)
    }

    public var upperTotal: Int {
        ones.valueOrZero +
        twos.valueOrZero +
        threes.valueOrZero +
        fours.valueOrZero +
        fives.valueOrZero +
        sixes.valueOrZero
    }

    public var upperBonus: Int {
        upperTotal >= 63 ? 35 : 0
    }

    public var lowerTotal: Int {
        threeOfAKind.valueOrZero +
        fourOfAKind.valueOrZero +
        fullHouse.valueOrZero +
        smallStraight.valueOrZero +
        largeStraight.valueOrZero +
        yahtzee.valueOrZero +
        chance.valueOrZero
    }

    public var totalScore: Int {
        upperTotal + upperBonus + lowerTotal
    }

    private var scoreDictionary = [ScoreType: ScoreTuple]()

    public init() {
        for scoreType in ScoreType.allCases {
            scoreDictionary[scoreType] = ScoreTuple(type: scoreType)
        }
    }

    public mutating func evaluate(_ dice: DiceValues) {
        let scorer = DiceScorer(dice)

        for scoreType in ScoreType.allCases {
            let tuple = scoreDictionary[scoreType] ?? ScoreTuple(type: scoreType)
            if !tuple.hasValue {
                let score = ScoreTuple(
                    type: scoreType,
                    value: nil,
                    possibleValue: scorer.score(for: scoreType)
                )
                scoreDictionary[scoreType]?.setPossibleValue(score.possibleValueOrZero)
            }
        }
    }

    public mutating func clearPossibleScores() {
        for scoreType in ScoreType.allCases {
            scoreDictionary[scoreType]?.clearPossibleValue()
        }
    }

    public mutating func score(_ dice: DiceValues, scoreType: ScoreType) {
        let scorer = DiceScorer(dice)
        scoreDictionary[scoreType]?.clearPossibleValue()
        scoreDictionary[scoreType]?.setValue(scorer.score(for: scoreType))
    }
}
