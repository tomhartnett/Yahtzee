//
//  GameAPI.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/18/24.
//

import Foundation

struct Game {
    var playerScoreCard = ScoreCard()
    var opponentScoreCard = ScoreCard()
}

enum ScoreType {
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

struct CategoryScore {
    let category: ScoreType
    var score: Int
}

struct ScoreCard {
    var onesScore: CategoryScore?
    var twosScore: CategoryScore?
    var threesScore: CategoryScore?
    var foursScore: CategoryScore?
    var fivesScore: CategoryScore?
    var sixesScore: CategoryScore?
    var bonusScore: CategoryScore?
    var threeOfAKindScore: CategoryScore?
    var fourOfAKindScore: CategoryScore?
    var fullHouseScore: CategoryScore?
    var smallStraightScore: CategoryScore?
    var largeStraightScore: CategoryScore?
    var yahtzeeScore: CategoryScore?
    var chanceScoore: CategoryScore?
}
