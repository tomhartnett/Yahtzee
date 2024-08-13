//
//  LuckyBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/13/24.
//

import Foundation

public class LuckyBot: Bot {
    public var name: String { "LuckyBot" }

    public init() {}

    public func takeTurn(_ scorecard: Scorecard, with values: DiceValues?) -> ScoreTuple {

        let scoreType = scorecard.randomEmpty()
        let luckFactor = LuckFactor.random()
        let score: Int

        switch scoreType {
        case .ones:
            if luckFactor == .awesome {
                score = 4
            } else if luckFactor == .decent {
                score = 3
            } else {
                score = 2
            }
        case .twos:
            if luckFactor == .awesome {
                score = 8
            } else if luckFactor == .decent {
                score = 6
            } else {
                score = 4
            }
        case .threes:
            if luckFactor == .awesome {
                score = 12
            } else if luckFactor == .decent {
                score = 9
            } else {
                score = 6
            }
        case .fours:
            if luckFactor == .awesome {
                score = 16
            } else if luckFactor == .decent {
                score = 12
            } else {
                score = 8
            }
        case .fives:
            if luckFactor == .awesome {
                score = 20
            } else if luckFactor == .decent {
                score = 15
            } else {
                score = 10
            }
        case .sixes:
            if luckFactor == .awesome {
                score = 24
            } else if luckFactor == .decent {
                score = 18
            } else {
                score = 12
            }
        case .threeOfAKind:
            if luckFactor == .awesome {
                score = Int.random(in: 26...29)
            } else if luckFactor == .decent {
                score = Int.random(in: 20...25)
            } else {
                score = Int.random(in: 9...13)
            }
        case .fourOfAKind:
            if luckFactor == .awesome {
                score = Int.random(in: 26...29)
            } else if luckFactor == .decent {
                score = Int.random(in: 20...25)
            } else {
                score = Int.random(in: 9...13)
            }
        case .fullHouse:
            if luckFactor == .awesome || luckFactor == .decent {
                score = 25
            } else {
                score = 0
            }
        case .smallStraight:
            if luckFactor == .awesome || luckFactor == .decent {
                score = 30
            } else {
                score = 0
            }
        case .largeStraight:
            if luckFactor == .awesome || luckFactor == .decent {
                score = 40
            } else {
                score = 0
            }
        case .yahtzee:
            if luckFactor == .awesome {
                score = 50
            } else {
                score = 0
            }
        case .chance:
            if luckFactor == .awesome {
                score = Int.random(in: 26...29)
            } else if luckFactor == .decent {
                score = Int.random(in: 20...25)
            } else {
                score = Int.random(in: 9...13)
            }
        }

        return ScoreTuple(type: scoreType, value: score)
    }


    private enum LuckFactor {
        case bad
        case decent
        case awesome

        static func random() -> LuckFactor {
            let random = Int.random(in: 1...5)

            if random == 1 {
                return .awesome
            } else if random >= 2 && random <= 4 {
                return .decent
            } else {
                return .bad
            }
        }
    }
}
