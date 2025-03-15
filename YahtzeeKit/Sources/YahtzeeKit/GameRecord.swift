//
//  GameRecord.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/15/25.
//

import Foundation
import SwiftData

@Model
public class GameRecord {
    public struct Scorecard: Codable {
        public var scores: [ScoreType: Int]
        public var yahtzeeBonusCount: Int

        public init(
            scores: [ScoreType : Int],
            yahtzeeBonusCount: Int
        ) {
            self.scores = scores
            self.yahtzeeBonusCount = yahtzeeBonusCount
        }
    }

    public var playerScorecard: Scorecard
    public var opponentScorecard: Scorecard
    public var startDate: Date
    public var endDate: Date

    public init(
        playerScorecard: Scorecard,
        opponentScorecard: Scorecard,
        startDate: Date,
        endDate: Date
    ) {
        self.playerScorecard = playerScorecard
        self.opponentScorecard = opponentScorecard
        self.startDate = startDate
        self.endDate = endDate
    }
}
