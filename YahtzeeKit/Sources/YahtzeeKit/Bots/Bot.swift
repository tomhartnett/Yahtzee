//
//  Bot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/13/24.
//

import Foundation

public protocol Bot {
    var skillLevel: BotSkillLevel { get }
    func takeTurn(_ scorecard: Scorecard) -> ScoreBox
}

public protocol BotProvider {
    func makeBot() -> Bot
    func saveBotPreference(_ skillLevel: BotSkillLevel)
}

public struct DefaultBotProvider: BotProvider {
    private let skillLevelKey = "DefaultBotProvider-saved-bot-skill-level"

    public init() {}

    public func makeBot() -> Bot {
        let skillLevel: BotSkillLevel
        if let rawValue = UserDefaults.standard.value(forKey: skillLevelKey) as? Int,
           let savedSkillLevel = BotSkillLevel(rawValue: rawValue) {
            skillLevel = savedSkillLevel
        } else {
            skillLevel = .ok
        }

        return ConfigurableBot(skillLevel: skillLevel)
    }

    public func saveBotPreference(_ skillLevel: BotSkillLevel) {
        UserDefaults.standard.set(skillLevel.rawValue, forKey: skillLevelKey)
    }
}

extension Scorecard {
    func randomEmpty() -> ScoreType {
        let scores: [ScoreBox] = [
            ones,
            twos,
            threes,
            fours,
            fives,
            sixes,
            threeOfAKind,
            fourOfAKind,
            fullHouse,
            smallStraight,
            largeStraight,
            yahtzee,
            chance
        ]

        let available = scores.filter({ $0.isEmpty })

        let random = Int.random(in: 0..<available.count)

        return available[random].scoreType
    }
}
