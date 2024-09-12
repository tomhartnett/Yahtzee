//
//  Game.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import Foundation
import YahtzeeKit

@Observable class Game {
    var diceCup: DiceCup

    var playerScorecard: Scorecard

    var opponentScorecard: Scorecard

    var selectedScoreType: ScoreType?

    var opponent: Bot

    init(_ botSkillLevel: BotSkillLevel) {
        diceCup = DiceCup()
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
        opponent = ConfigurableBot(skillLevel: botSkillLevel)
    }

    func playerScore() {
        guard let values = diceCup.values,
              let scoreType = selectedScoreType else {
            return
        }

        playerScorecard.score(values, scoreType: scoreType)
        playerScorecard.clearPossibleScores()
        diceCup.reset()
        selectedScoreType = nil
    }

    func opponentTurn() {
        let tuple = opponent.takeTurn(opponentScorecard)
        opponentScorecard.score(tuple)
    }
}
