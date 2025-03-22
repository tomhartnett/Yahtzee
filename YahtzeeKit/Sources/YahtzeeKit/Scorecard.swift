//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public struct Scorecard {
    public var ones: ScoreBox {
        scoreDictionary[ScoreType.ones] ?? ScoreBox(scoreType: .ones)
    }

    public var twos: ScoreBox {
        scoreDictionary[ScoreType.twos] ?? ScoreBox(scoreType: .twos)
    }

    public var threes: ScoreBox {
        scoreDictionary[ScoreType.threes] ?? ScoreBox(scoreType: .threes)
    }

    public var fours: ScoreBox {
        scoreDictionary[ScoreType.fours] ?? ScoreBox(scoreType: .fours)
    }

    public var fives: ScoreBox {
        scoreDictionary[ScoreType.fives] ?? ScoreBox(scoreType: .fives)
    }

    public var sixes: ScoreBox {
        scoreDictionary[ScoreType.sixes] ?? ScoreBox(scoreType: .sixes)
    }

    public var threeOfAKind: ScoreBox {
        scoreDictionary[ScoreType.threeOfAKind] ?? ScoreBox(scoreType: .threeOfAKind)
    }

    public var fourOfAKind: ScoreBox {
        scoreDictionary[ScoreType.fourOfAKind] ?? ScoreBox(scoreType: .fourOfAKind)
    }

    public var fullHouse: ScoreBox {
        scoreDictionary[ScoreType.fullHouse] ?? ScoreBox(scoreType: .fullHouse)
    }

    public var smallStraight: ScoreBox {
        scoreDictionary[ScoreType.smallStraight] ?? ScoreBox(scoreType: .smallStraight)
    }

    public var largeStraight: ScoreBox {
        scoreDictionary[ScoreType.largeStraight] ?? ScoreBox(scoreType: .largeStraight)
    }

    public var yahtzee: ScoreBox {
        scoreDictionary[ScoreType.yahtzee] ?? ScoreBox(scoreType: .yahtzee)
    }

    public var chance: ScoreBox {
        scoreDictionary[ScoreType.chance] ?? ScoreBox(scoreType: .chance)
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

    public var yahtzeeBonus: Int {
        yahtzeeBonusCount * 100
    }

    public var totalScore: Int {
        return upperTotal + upperBonus + lowerTotal + yahtzeeBonus
    }

    public var remainingTurns: Int {
        var turns = 0

        if !ones.hasValue {
            turns += 1
        }

        if !twos.hasValue {
            turns += 1
        }

        if !threes.hasValue {
            turns += 1
        }

        if !fours.hasValue {
            turns += 1
        }

        if !fives.hasValue {
            turns += 1
        }

        if !sixes.hasValue {
            turns += 1
        }

        if !threeOfAKind.hasValue {
            turns += 1
        }

        if !fourOfAKind.hasValue {
            turns += 1
        }

        if !fullHouse.hasValue {
            turns += 1
        }

        if !smallStraight.hasValue {
            turns += 1
        }

        if !largeStraight.hasValue {
            turns += 1
        }

        if !yahtzee.hasValue {
            turns += 1
        }

        if !chance.hasValue {
            turns += 1
        }

        return turns
    }

    public var isFull: Bool {
        return remainingTurns <= 0
    }

    public var yahtzeeBonusCount = 0

    private var scoreDictionary = [ScoreType: ScoreBox]()

    public init() {
        for scoreType in ScoreType.allCases {
            scoreDictionary[scoreType] = ScoreBox(scoreType: scoreType)
        }
    }

    subscript(scoreType: ScoreType) -> ScoreBox {
        get {
            scoreDictionary[scoreType] ?? ScoreBox(scoreType: scoreType)
        }
        set(newValue) {
            scoreDictionary[scoreType] = newValue
        }
    }

    public mutating func evaluate(_ dice: DiceValues?) {
        guard let dice else {
            return
        }

        clearPossibleScores()

        let scorer = DiceScorer(scorecard: self, dice: dice)

        let possibleScores = scorer.evaluate()
        for score in possibleScores {
            scoreDictionary[score.scoreType] = score
        }
    }

    public mutating func clearPossibleScores() {
        for scoreType in ScoreType.allCases {
            scoreDictionary[scoreType]?.clearPossibleValue()
        }
    }

    public mutating func score(_ dice: DiceValues, scoreType: ScoreType) {
        let scorer = DiceScorer(scorecard: self, dice: dice)
        let isYahtzeeBonus = dice.isYahtzee && yahtzee.valueOrZero > 0

        scoreDictionary[scoreType]?.clearPossibleValue()
        scoreDictionary[scoreType]?.setValue(scorer.score(for: scoreType))

        if isYahtzeeBonus {
            yahtzeeBonusCount += 1
        }
    }

    public mutating func score(_ scoreTuple: ScoreBox) {
        let isYahtzeeBonus = scoreTuple.scoreType == .yahtzee && scoreTuple.valueOrZero > 0 && yahtzee.valueOrZero > 0

        scoreDictionary[scoreTuple.scoreType]?.clearPossibleValue()
        scoreDictionary[scoreTuple.scoreType]?.setValue(scoreTuple.valueOrZero)

        if isYahtzeeBonus {
            yahtzeeBonusCount += 1
        }
    }
}
