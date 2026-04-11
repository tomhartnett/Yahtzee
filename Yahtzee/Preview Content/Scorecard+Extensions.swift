//
//  ScorecardView+Extensions.swift
//  Rollzee
//
//  Created by Tom Hartnett on 4/11/26.
//

import SwiftUI
import YahtzeeKit

extension Scorecard {
    static var exampleWithUpperBonus: Scorecard {
        var scorecard = Scorecard()
        scorecard.score(ScoreBox(scoreType: .ones, value: 3, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .twos, value: 6, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .threes, value: 9, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fours, value: 12, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fives, value: 15, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .sixes, value: 18, possibleValue: nil))
        return scorecard
    }

    static var exampleWithoutUpperBonus: Scorecard {
        var scorecard = Scorecard()
        scorecard.score(ScoreBox(scoreType: .ones, value: 1, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .twos, value: 6, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .threes, value: 9, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fours, value: 12, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .fives, value: 15, possibleValue: nil))
        scorecard.score(ScoreBox(scoreType: .sixes, value: 12, possibleValue: nil))
        return scorecard
    }
}
