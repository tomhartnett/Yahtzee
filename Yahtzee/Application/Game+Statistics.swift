//
//  Game+Statistics.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 3/15/25.
//

import Foundation

/*
 Statistics ideas

 number of games
 wins
 losses
 ties

 average threeOfAKind score
 average fourOfAKind score
 average chance score

 number of yahtzees
 number of yahtzee bonuses

 average game time

 Plan:
 1. Create SwiftData model to store game results
 2. Write methods against it to calculate stats (maybe save metrics and only calculate once)
 3. Display stats when game ends (high-level summary eg total games, game length, etc. With option to view more)
 4. CloudKit to sync stats
 */
import YahtzeeKit

extension GameRecord {
    convenience init(_ game: Game) {
        self.init(
            playerScorecard: .init(game.playerScorecard),
            opponentScorecard: .init(game.opponentScorecard),
            startDate: game.startDate,
            endDate: game.endDate ?? Date.distantFuture
        )
    }
}

extension GameRecord.Scorecard {
    init(_ scorecard: Scorecard) {
        let scores: [ScoreType: Int] = [
            .ones: scorecard.ones.valueOrZero,
            .twos: scorecard.twos.valueOrZero,
            .threes: scorecard.threes.valueOrZero,
            .fours: scorecard.fours.valueOrZero,
            .fives: scorecard.fives.valueOrZero,
            .sixes: scorecard.sixes.valueOrZero,
            .threeOfAKind: scorecard.threeOfAKind.valueOrZero,
            .fourOfAKind: scorecard.fourOfAKind.valueOrZero,
            .fullHouse: scorecard.fullHouse.valueOrZero,
            .smallStraight: scorecard.smallStraight.valueOrZero,
            .largeStraight: scorecard.largeStraight.valueOrZero,
            .yahtzee: scorecard.yahtzee.valueOrZero,
            .chance: scorecard.chance.valueOrZero
        ]

        self.init(
            scores: scores,
            yahtzeeBonusCount: scorecard.yahtzeeBonusCount
        )
    }
}
