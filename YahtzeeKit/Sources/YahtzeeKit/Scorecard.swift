//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public struct Scorecard {
    public var ones: ScoreTuple {
        scoreDictionary[ScoreType.ones] ?? ScoreTuple(scoreType: .ones)
    }

    public var twos: ScoreTuple {
        scoreDictionary[ScoreType.twos] ?? ScoreTuple(scoreType: .twos)
    }

    public var threes: ScoreTuple {
        scoreDictionary[ScoreType.threes] ?? ScoreTuple(scoreType: .threes)
    }

    public var fours: ScoreTuple {
        scoreDictionary[ScoreType.fours] ?? ScoreTuple(scoreType: .fours)
    }

    public var fives: ScoreTuple {
        scoreDictionary[ScoreType.fives] ?? ScoreTuple(scoreType: .fives)
    }

    public var sixes: ScoreTuple {
        scoreDictionary[ScoreType.sixes] ?? ScoreTuple(scoreType: .sixes)
    }

    public var threeOfAKind: ScoreTuple {
        scoreDictionary[ScoreType.threeOfAKind] ?? ScoreTuple(scoreType: .threeOfAKind)
    }

    public var fourOfAKind: ScoreTuple {
        scoreDictionary[ScoreType.fourOfAKind] ?? ScoreTuple(scoreType: .fourOfAKind)
    }

    public var fullHouse: ScoreTuple {
        scoreDictionary[ScoreType.fullHouse] ?? ScoreTuple(scoreType: .fullHouse)
    }

    public var smallStraight: ScoreTuple {
        scoreDictionary[ScoreType.smallStraight] ?? ScoreTuple(scoreType: .smallStraight)
    }

    public var largeStraight: ScoreTuple {
        scoreDictionary[ScoreType.largeStraight] ?? ScoreTuple(scoreType: .largeStraight)
    }

    public var yahtzee: ScoreTuple {
        scoreDictionary[ScoreType.yahtzee] ?? ScoreTuple(scoreType: .yahtzee)
    }

    public var chance: ScoreTuple {
        scoreDictionary[ScoreType.chance] ?? ScoreTuple(scoreType: .chance)
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

    private var scoreDictionary = [ScoreType: ScoreTuple]()

    public init() {
        for scoreType in ScoreType.allCases {
            scoreDictionary[scoreType] = ScoreTuple(scoreType: scoreType)
        }
    }

    subscript(scoreType: ScoreType) -> ScoreTuple {
        get {
            scoreDictionary[scoreType] ?? ScoreTuple(scoreType: scoreType)
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

    public mutating func score(_ scoreTuple: ScoreTuple) {
        let isYahtzeeBonus = scoreTuple.scoreType == .yahtzee && scoreTuple.valueOrZero > 0 && yahtzee.valueOrZero > 0

        scoreDictionary[scoreTuple.scoreType]?.clearPossibleValue()
        scoreDictionary[scoreTuple.scoreType]?.setValue(scoreTuple.valueOrZero)

        if isYahtzeeBonus {
            yahtzeeBonusCount += 1
        }
    }
}
