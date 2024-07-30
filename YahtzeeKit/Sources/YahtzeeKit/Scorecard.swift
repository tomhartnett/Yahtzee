//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum ScoreType {
    case ones(score: Int?)
    case twos(score: Int?)
    case threes(score: Int?)
    case fours(score: Int?)
    case fives(score: Int?)
    case sixes(score: Int?)
    case upperBonus(score: Int?)
    case threeOfAKind(score: Int?)
    case fourOfAKind(score: Int?)
    case fullHouse(score: Int?)
    case smallStraight(score: Int?)
    case largeStraight(score: Int?)
    case yahtzee(score: Int?)
    case chance(score: Int?)

    public var score: Int {
        switch self {
        case .ones(score: let score):
            return score ?? 0
        case .twos(score: let score):
            return score ?? 0
        case .threes(score: let score):
            return score ?? 0
        case .fours(score: let score):
            return score ?? 0
        case .fives(score: let score):
            return score ?? 0
        case .sixes(score: let score):
            return score ?? 0
        case .upperBonus(score: let score):
            return score ?? 0
        case .threeOfAKind(score: let score):
            return score ?? 0
        case .fourOfAKind(score: let score):
            return score ?? 0
        case .fullHouse(score: let score):
            return score ?? 0
        case .smallStraight(score: let score):
            return score ?? 0
        case .largeStraight(score: let score):
            return score ?? 0
        case .yahtzee(score: let score):
            return score ?? 0
        case .chance(score: let score):
            return score ?? 0
        }
    }
}

public struct Scorecard {
    public var ones: ScoreType
    public var twos: ScoreType
    public var threes: ScoreType
    public var fours: ScoreType
    public var fives: ScoreType
    public var sixes: ScoreType
    public var bonus: ScoreType
    public var threeOfAKind: ScoreType
    public var fourOfAKind: ScoreType
    public var fullHouse: ScoreType
    public var smallStraight: ScoreType
    public var largeStraight: ScoreType
    public var yahtzee: ScoreType
    public var chance: ScoreType

    public var pendingScore: ScoreType?

    public var totalScore: Int {
        ones.score +
        twos.score +
        threes.score +
        fours.score +
        fives.score +
        sixes.score +
        bonus.score +
        threeOfAKind.score +
        fourOfAKind.score +
        fullHouse.score +
        smallStraight.score +
        largeStraight.score +
        yahtzee.score +
        chance.score
    }

    public init() {
        ones = .ones(score: nil)
        twos = .twos(score: nil)
        threes = .threes(score: nil)
        fours = .fours(score: nil)
        fives = .fives(score: nil)
        sixes = .sixes(score: nil)
        bonus = .upperBonus(score: nil)
        threeOfAKind = .threeOfAKind(score: nil)
        fourOfAKind = .fourOfAKind(score: nil)
        fullHouse = .fullHouse(score: nil)
        smallStraight = .smallStraight(score: nil)
        largeStraight = .largeStraight(score: nil)
        yahtzee = .yahtzee(score: nil)
        chance = .chance(score: nil)
    }

    public mutating func score(_ scoreType: ScoreType) {
        switch scoreType {

        case .ones(score: let score):
            ones = .ones(score: score)
        case .twos(score: let score):
            twos = .twos(score: score)
        case .threes(score: let score):
            threes = .threes(score: score)
        case .fours(score: let score):
            fours = .fours(score: score)
        case .fives(score: let score):
            fives = .fives(score: score)
        case .sixes(score: let score):
            sixes = .sixes(score: score)
        case .upperBonus(score: let score):
            bonus = .upperBonus(score: score)
        case .threeOfAKind(score: let score):
            threeOfAKind = .threeOfAKind(score: score)
        case .fourOfAKind(score: let score):
            fourOfAKind = .fourOfAKind(score: score)
        case .fullHouse(score: let score):
            fullHouse = .fullHouse(score: score)
        case .smallStraight(score: let score):
            smallStraight = .smallStraight(score: score)
        case .largeStraight(score: let score):
            largeStraight = .largeStraight(score: score)
        case .yahtzee(score: let score):
            yahtzee = .yahtzee(score: score)
        case .chance(score: let score):
            chance = .chance(score: score)
        }
    }
}
