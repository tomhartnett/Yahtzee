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
