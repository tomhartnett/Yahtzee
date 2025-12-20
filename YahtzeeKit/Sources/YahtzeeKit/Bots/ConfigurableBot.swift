//
//  ConfigurableBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/24/24.
//

import Foundation

public class ConfigurableBot: Bot {
    public init() {}

    public func takeTurn(_ scorecard: Scorecard) -> ScoreBox {
        let scoreType = scorecard.randomEmpty()
        let score: Int

        let luckFactor = Int.random(in: 0...4)
        let isLucky = luckFactor != 0

        if !isLucky && !scoreType.isNonZero {
            return ScoreBox(scoreType: scoreType, value: 0)
        }

        let topSectionMultiplier = Int.random(in: 2...4)

        var threeOrFourOfKindExtras = [1, 2, 3, 4, 5, 6]

        switch scoreType {
        case .ones:
            score = topSectionMultiplier

        case .twos:
            score = topSectionMultiplier * 2

        case .threes:
            score = topSectionMultiplier * 3

        case .fours:
            score = topSectionMultiplier * 4

        case .fives:
            score = topSectionMultiplier * 5

        case .sixes:
            score = topSectionMultiplier * 6

        case .threeOfAKind:
            let random1: Int
            if isLucky {
                random1 = Int.random(in: 5...6)
            } else {
                random1 = Int.random(in: 1...4)
            }
            threeOrFourOfKindExtras.removeAll(where: { $0 == random1 })
            let random2 = threeOrFourOfKindExtras.randomElement()!
            let random3 = threeOrFourOfKindExtras.randomElement(where: { $0 != random2 })!
            score = random1 * 3 + random2 + random3

        case .fourOfAKind:
            let random1: Int
            if isLucky {
                random1 = Int.random(in: 5...6)
            } else {
                random1 = Int.random(in: 1...4)
            }
            threeOrFourOfKindExtras.removeAll(where: { $0 == random1 })
            let random2 = threeOrFourOfKindExtras.randomElement()!
            score = random1 * 4 + random2

        case .fullHouse:
            score = 25

        case .smallStraight:
            score = 30

        case .largeStraight:
            score = 40

        case .yahtzee:
            score = 50

        case .chance:
            score = Int.random(in: 6...29)
        }

        return ScoreBox(scoreType: scoreType, value: score)
    }
}
