//
//  Game.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import Foundation
import YahtzeeKit

enum DiceAction {
    case toggleDieHold
    case resetDice
    case rollDice(DiceValues)
}

@Observable class Game {
    var diceCup: DiceCup

    var playerScorecard: Scorecard

    var opponentScorecard: Scorecard

    var opponent: Bot

    var selectedScoreType: ScoreType?

    var diceAction: DiceAction? = .resetDice

    var isRollInProgress = false

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
        selectedScoreType = nil
        diceCup.reset()
        diceAction = .resetDice
    }

    func opponentTurn() {
        let tuple = opponent.takeTurn(opponentScorecard)
        opponentScorecard.score(tuple)
    }
}
