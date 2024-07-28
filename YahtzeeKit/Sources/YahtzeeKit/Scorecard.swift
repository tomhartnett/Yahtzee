//
//  Scorecard.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum ScoreType {
    case ones(score: Int)
    case twos(score: Int)
    case threes(score: Int)
    case fours(score: Int)
    case fives(score: Int)
    case sixes(score: Int)
    case upperBonus(score: Int)
    case threeOfAKind(score: Int)
    case fourOfAKind(score: Int)
    case fullHouse(score: Int)
    case smallStraight(score: Int)
    case largeStraight(score: Int)
    case yahtzee(score: Int)
    case chance(score: Int)
}

public struct Scorecard {
    public var ones: ScoreType?
    public var twos: ScoreType?
    public var threes: ScoreType?
    public var fours: ScoreType?
    public var fives: ScoreType?
    public var sixes: ScoreType?
    public var bonus: ScoreType?
    public var threeOfAKind: ScoreType?
    public var fourOfAKind: ScoreType?
    public var fullHouse: ScoreType?
    public var smallStraight: ScoreType?
    public var largeStraight: ScoreType?
    public var yahtzee: ScoreType?
    public var chance: ScoreType?
}
