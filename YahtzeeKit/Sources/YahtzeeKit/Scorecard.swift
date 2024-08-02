//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum ScoreType {
    case ones
    case twos
    case threes
    case fours
    case fives
    case sixes
    case upperBonus
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
    public let value: Int?

    public var valueOrZero: Int {
        return value ?? 0
    }

    public init(type: ScoreType, value: Int?) {
        self.type = type
        self.value = value
    }

    public init(type: ScoreType) {
        self.type = type
        self.value = nil
    }
}

public struct Scorecard {
    public var ones: ScoreTuple
    public var twos: ScoreTuple
    public var threes: ScoreTuple
    public var fours: ScoreTuple
    public var fives: ScoreTuple
    public var sixes: ScoreTuple
    public var bonus: ScoreTuple
    public var threeOfAKind: ScoreTuple
    public var fourOfAKind: ScoreTuple
    public var fullHouse: ScoreTuple
    public var smallStraight: ScoreTuple
    public var largeStraight: ScoreTuple
    public var yahtzee: ScoreTuple
    public var chance: ScoreTuple

    public var totalScore: Int {
        ones.valueOrZero +
        twos.valueOrZero +
        threes.valueOrZero +
        fours.valueOrZero +
        fives.valueOrZero +
        sixes.valueOrZero +
        bonus.valueOrZero +
        threeOfAKind.valueOrZero +
        fourOfAKind.valueOrZero +
        fullHouse.valueOrZero +
        smallStraight.valueOrZero +
        largeStraight.valueOrZero +
        yahtzee.valueOrZero +
        chance.valueOrZero
    }

    public init() {
        ones = ScoreTuple(type: .ones)
        twos = ScoreTuple(type: .twos)
        threes = ScoreTuple(type: .threes)
        fours = ScoreTuple(type: .fours)
        fives = ScoreTuple(type: .fives)
        sixes = ScoreTuple(type: .sixes)
        bonus = ScoreTuple(type: .upperBonus)
        threeOfAKind = ScoreTuple(type: .threeOfAKind)
        fourOfAKind = ScoreTuple(type: .fourOfAKind)
        fullHouse = ScoreTuple(type: .fullHouse)
        smallStraight = ScoreTuple(type: .smallStraight)
        largeStraight = ScoreTuple(type: .largeStraight)
        yahtzee = ScoreTuple(type: .yahtzee)
        chance = ScoreTuple(type: .chance)
    }
}
