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

public struct CategoryScore {
    public let category: ScoreType
    public var score: Int
}

public struct Scorecard {
    public var onesScore: CategoryScore?
    public var twosScore: CategoryScore?
    public var threesScore: CategoryScore?
    public var foursScore: CategoryScore?
    public var fivesScore: CategoryScore?
    public var sixesScore: CategoryScore?
    public var bonusScore: CategoryScore?
    public var threeOfAKindScore: CategoryScore?
    public var fourOfAKindScore: CategoryScore?
    public var fullHouseScore: CategoryScore?
    public var smallStraightScore: CategoryScore?
    public var largeStraightScore: CategoryScore?
    public var yahtzeeScore: CategoryScore?
    public var chanceScoore: CategoryScore?
}
