//
//  YahtzeeKit+Extensions.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import YahtzeeKit

extension ScoreType {
    var score: Int? {
        switch self {
        case .ones(score: let score):
            return score
        case .twos(score: let score):
            return score
        case .threes(score: let score):
            return score
        case .fours(score: let score):
            return score
        case .fives(score: let score):
            return score
        case .sixes(score: let score):
            return score
        case .upperBonus(score: let score):
            return score
        case .threeOfAKind(score: let score):
            return score
        case .fourOfAKind(score: let score):
            return score
        case .fullHouse(score: let score):
            return score
        case .smallStraight(score: let score):
            return score
        case .largeStraight(score: let score):
            return score
        case .yahtzee(score: let score):
            return score
        case .chance(score: let score):
            return score
        }
    }
}

extension DieValue {
    var displayLabel: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        }
    }
}
