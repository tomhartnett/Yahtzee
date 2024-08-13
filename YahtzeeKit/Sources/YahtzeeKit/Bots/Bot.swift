//
//  Bot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/13/24.
//

import Foundation

public protocol Bot {
    func takeTurn(_ scorecard: Scorecard, with values: DiceValues?) -> ScoreTuple
}

public extension Bot {
    func takeTurn(_ scorecard: Scorecard) -> ScoreTuple {
        takeTurn(scorecard, with: nil)
    }
}

public struct BotFactory {
    public static func randomBot() -> Bot {
        let random = Int.random(in: 1...5)

        if random == 1 {
            return BetterBot()
        } else if random >= 2 && random <= 4 {
            return LuckyBot()
        } else {
            return RandomBot()
        }
    }
}
