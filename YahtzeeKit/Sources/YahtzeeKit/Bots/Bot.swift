//
//  Bot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/13/24.
//

import Foundation

public struct TurnResult {
    public let score: ScoreBox
    public let dice: DiceValues
}

public enum BotKind: String, Codable {
    case luck

    public static var `default`: BotKind {
        .luck
    }

    public func makeBot() -> any Bot {
        switch self {
        case .luck:
            return LuckBot()
        }
    }
}

public protocol Bot {
    var kind: BotKind { get }

    func takeTurn(_ scorecard: Scorecard) -> TurnResult
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
