//
//  ScoreType.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

import Foundation

public enum ScoreType: String, CaseIterable, Codable {
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
