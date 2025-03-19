//
//  ConfigurableBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/24/24.
//

import Foundation

public enum BotSkillLevel: CaseIterable, Identifiable {
    case bad
    case ok
    case great

    public var id: Self {
        self
    }
}

public class ConfigurableBot: Bot {

    public let skillLevel: BotSkillLevel

    public init(skillLevel: BotSkillLevel) {
        self.skillLevel = skillLevel
    }

    public func takeTurn(_ scorecard: Scorecard) -> ScoreTuple {
        let scoreType = scorecard.randomEmpty()
        let score: Int

        let luckFactor = Int.random(in: 0...2)
        let isLucky = luckFactor == 1 ? true : false
        let isUnlucky = luckFactor == 0 ? true : false

        switch scoreType {
        case .ones:
            if skillLevel == .great {
                score = isLucky ? 4 : 3
            } else if skillLevel == .ok {
                score = isUnlucky ? 2 : 3
            } else {
                score = isLucky ? 2 : 0
            }
            
        case .twos:
            if skillLevel == .great {
                score = isLucky ? 8 : 6
            } else if skillLevel == .ok {
                score = isLucky ? 6 : 4
            } else {
                score = isLucky ? 4 : 0
            }

        case .threes:
            if skillLevel == .great {
                score = isLucky ? 12 : 9
            } else if skillLevel == .ok {
                score = isLucky ? 9 : 6
            } else {
                score = 6
            }

        case .fours:
            if skillLevel == .great {
                score = isLucky ? 16 : 12
            } else if skillLevel == .ok {
                score = isLucky ? 12 : 8
            } else {
                score = 8
            }

        case .fives:
            if skillLevel == .great {
                score = isLucky ? 20 : 15
            } else if skillLevel == .ok {
                score = isLucky ? 15 : 10
            } else {
                score = 10
            }

        case .sixes:
            if skillLevel == .great {
                score = isLucky ? 24 : 18
            } else if skillLevel == .ok {
                score = isLucky ? 18 : 12
            } else {
                score = isLucky ? 12 : 0
            }

        case .threeOfAKind:
            let highScore = Int.random(in: 25...29)
            let midScore = Int.random(in: 14...24)
            let lowScore = Int.random(in: 0...13)

            if skillLevel == .great {
                score = isUnlucky ? midScore : highScore
            } else if skillLevel == .ok {
                score = isLucky ? highScore : midScore
            } else {
                score = lowScore
            }

        case .fourOfAKind:
            let highScore = Int.random(in: 25...29)
            let midScore = Int.random(in: 14...24)
            let lowScore = Int.random(in: 0...13)

            if skillLevel == .great {
                score = isUnlucky ? midScore : highScore
            } else if skillLevel == .ok {
                score = isLucky ? highScore : midScore
            } else {
                score = lowScore
            }

        case .fullHouse:
            if skillLevel == .great {
                score = isUnlucky ? 0 : 25
            } else if skillLevel == .ok {
                score = isLucky ? 25 : 0
            } else {
                score = 0
            }

        case .smallStraight:
            if skillLevel == .great {
                score = isUnlucky ? 0 : 30
            } else if skillLevel == .ok {
                score = isLucky ? 30 : 0
            } else {
                score = 0
            }

        case .largeStraight:
            if skillLevel == .great {
                score = isUnlucky ? 0 : 40
            } else if skillLevel == .ok {
                score = isLucky ? 40 : 0
            } else {
                score = 0
            }
        case .yahtzee:
            if skillLevel == .great {
                score = isUnlucky ? 0 : 50
            } else if skillLevel == .ok {
                score = isLucky ? 50 : 0
            } else {
                score = 0
            }

        case .chance:
            let highScore = Int.random(in: 26...29)
            let midScore = Int.random(in: 20...25)
            let lowScore = Int.random(in: 9...13)

            if skillLevel == .great {
                score = isUnlucky ? midScore : highScore
            } else if skillLevel == .ok {
                score = isLucky ? highScore : midScore
            } else {
                score = lowScore
            }
        }

        return ScoreTuple(type: scoreType, value: score)
    }
}
