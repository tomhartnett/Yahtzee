//
//  Bot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/13/24.
//

import Foundation

public protocol Bot {
    func takeTurn(_ scorecard: Scorecard) -> ScoreBox
}

public protocol BotProvider {
    func makeBot() -> Bot
}

public struct DefaultBotProvider: BotProvider {
    public init() {}

    public func makeBot() -> Bot {
        LuckBot()
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
